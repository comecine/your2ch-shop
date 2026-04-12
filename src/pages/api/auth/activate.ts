import type { APIRoute } from 'astro';
import { env as cfEnv } from "cloudflare:workers";
import { jsonResponse, corsHeaders } from '../_helpers';

const { DB: db } = cfEnv as unknown as { DB: D1Database };

export const GET: APIRoute = async (context) => {
  try {
    const url = new URL(context.request.url);
    const token = url.searchParams.get('token');

    if (!token) {
      return jsonResponse({ success: false, error: '缺少激活令牌' }, 400);
    }

    const now = Math.floor(Date.now() / 1000);

    const user = await db.prepare(
      'SELECT id, activation_expires FROM users WHERE activation_token = ?'
    ).bind(token).first();

    if (!user) {
      return jsonResponse({ success: false, error: '无效的激活令牌' }, 400);
    }

    if ((user as { activation_expires: number }).activation_expires < now) {
      return jsonResponse({ success: false, error: '激活令牌已过期，请重新注册' }, 400);
    }

    await db.prepare(
      `UPDATE users SET status = 'active', activation_token = NULL, activation_expires = NULL,
       updated_at = ? WHERE id = ?`
    ).bind(now, (user as { id: number }).id).run();

    return jsonResponse({ success: true, message: '账号激活成功，请登录' });
  } catch (err: unknown) {
    return jsonResponse({ success: false, error: (err as Error).message }, 500);
  }
};

export const OPTIONS: APIRoute = async () => {
  return new Response(null, { status: 204, headers: corsHeaders });
};
