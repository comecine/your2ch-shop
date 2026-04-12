import type { APIRoute } from 'astro';
import { env as cfEnv } from "cloudflare:workers";
import { verifyPassword, createJWT, jsonResponse, corsHeaders } from '../_helpers';

const { DB: db, JWT_SECRET } = cfEnv as unknown as { DB: D1Database; JWT_SECRET: string };

export const POST: APIRoute = async (context) => {
  try {
    const body = await context.request.json();
    const { email, password } = body;

    if (!email || !password) {
      return jsonResponse({ success: false, error: '邮箱和密码为必填项' }, 400);
    }

    const user = await db.prepare(
      'SELECT id, username, email, password_hash, status FROM users WHERE email = ?'
    ).bind(email).first() as { id: number; username: string; email: string; password_hash: string; status: string } | null;

    if (!user) {
      return jsonResponse({ success: false, error: '邮箱或密码错误' }, 401);
    }

    const valid = await verifyPassword(password, user.password_hash);
    if (!valid) {
      return jsonResponse({ success: false, error: '邮箱或密码错误' }, 401);
    }

    if (user.status !== 'active') {
      return jsonResponse({ success: false, error: '账号尚未激活或已被停用' }, 403);
    }

    const token = await createJWT(
      { userId: user.id, email: user.email, username: user.username, exp: Math.floor(Date.now() / 1000) + 604800 },
      JWT_SECRET
    );

    const headers = new Headers({
      'Content-Type': 'application/json',
      ...corsHeaders,
      'Set-Cookie': `auth_token=${token}; HttpOnly; Path=/; Max-Age=604800; SameSite=Lax`,
    });

    return new Response(JSON.stringify({
      success: true,
      data: { user: { id: user.id, username: user.username, email: user.email } },
    }), { status: 200, headers });
  } catch (err: unknown) {
    return jsonResponse({ success: false, error: (err as Error).message }, 500);
  }
};

export const OPTIONS: APIRoute = async () => {
  return new Response(null, { status: 204, headers: corsHeaders });
};
