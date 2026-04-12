import type { APIRoute } from 'astro';
import { env as cfEnv } from "cloudflare:workers";
import { requireAuth, jsonResponse, corsHeaders } from '../_helpers';

const { DB: db } = cfEnv as unknown as { DB: D1Database };

export const GET: APIRoute = async (context) => {
  try {
    const user = await requireAuth(context.request);
    if (!user) {
      return jsonResponse({ success: false, error: '未登录或登录已过期' }, 401);
    }

    const dbUser = await db.prepare(
      'SELECT id, username, email, phone, avatar, status, created_at FROM users WHERE id = ?'
    ).bind(user.userId).first();

    if (!dbUser) {
      return jsonResponse({ success: false, error: '用户不存在' }, 404);
    }

    return jsonResponse({ success: true, data: { user: dbUser } });
  } catch (err: unknown) {
    return jsonResponse({ success: false, error: (err as Error).message }, 500);
  }
};

export const OPTIONS: APIRoute = async () => {
  return new Response(null, { status: 204, headers: corsHeaders });
};
