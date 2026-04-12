import type { APIRoute } from 'astro';
import { env as cfEnv } from "cloudflare:workers";
import { verifyPassword, createJWT, jsonResponse, corsHeaders } from '../../_helpers';

const { DB: db, JWT_SECRET } = cfEnv as unknown as { DB: D1Database; JWT_SECRET: string };

export const POST: APIRoute = async (context) => {
  try {
    const body = await context.request.json();
    const { username, password } = body;

    if (!username || !password) {
      return jsonResponse({ success: false, error: '用户名和密码为必填项' }, 400);
    }

    const admin = await db.prepare(
      'SELECT id, username, password_hash, role FROM admin_users WHERE username = ?'
    ).bind(username).first() as { id: number; username: string; password_hash: string; role: string } | null;

    if (!admin) {
      return jsonResponse({ success: false, error: '用户名或密码错误' }, 401);
    }

    const valid = await verifyPassword(password, admin.password_hash);
    if (!valid) {
      return jsonResponse({ success: false, error: '用户名或密码错误' }, 401);
    }

    const token = await createJWT(
      {
        adminId: admin.id,
        username: admin.username,
        role: admin.role,
        exp: Math.floor(Date.now() / 1000) + 86400, // 24h
      },
      JWT_SECRET
    );

    const headers = new Headers({
      'Content-Type': 'application/json',
      ...corsHeaders,
    });
    // HttpOnly token（安全用）
    headers.append('Set-Cookie', `admin_token=${token}; HttpOnly; Path=/; Max-Age=86400; SameSite=Lax`);
    // JS 可讀的 flag（供 AdminLayout client-side 檢查用）
    headers.append('Set-Cookie', `admin_logged_in=1; Path=/; Max-Age=86400; SameSite=Lax`);

    return new Response(JSON.stringify({
      success: true,
      data: { admin: { id: admin.id, username: admin.username, role: admin.role } },
    }), { status: 200, headers });
  } catch (err: unknown) {
    return jsonResponse({ success: false, error: (err as Error).message }, 500);
  }
};

export const OPTIONS: APIRoute = async () => {
  return new Response(null, { status: 204, headers: corsHeaders });
};
