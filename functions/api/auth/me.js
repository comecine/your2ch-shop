import { requireAuth, jsonResponse, corsHeaders } from '../_helpers.js';

export async function onRequestGet(context) {
  try {
    const user = await requireAuth(context);
    if (!user) {
      return jsonResponse({ success: false, error: '未登录或登录已过期' }, 401);
    }

    const dbUser = await context.env.DB.prepare(
      'SELECT id, username, email, phone, avatar, status, created_at FROM users WHERE id = ?'
    ).bind(user.userId).first();

    if (!dbUser) {
      return jsonResponse({ success: false, error: '用户不存在' }, 404);
    }

    return jsonResponse({ success: true, data: { user: dbUser } });
  } catch (err) {
    return jsonResponse({ success: false, error: err.message }, 500);
  }
}

export async function onRequestOptions() {
  return new Response(null, { status: 204, headers: corsHeaders });
}
