import { verifyPassword, createJWT, jsonResponse, corsHeaders } from '../_helpers.js';

export async function onRequestPost(context) {
  try {
    const body = await context.request.json();
    const { email, password } = body;

    if (!email || !password) {
      return jsonResponse({ success: false, error: '邮箱和密码为必填项' }, 400);
    }

    const db = context.env.DB;
    const user = await db.prepare(
      'SELECT id, username, email, password_hash, status FROM users WHERE email = ?'
    ).bind(email).first();

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
      context.env.JWT_SECRET
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
  } catch (err) {
    return jsonResponse({ success: false, error: err.message }, 500);
  }
}

export async function onRequestOptions() {
  return new Response(null, { status: 204, headers: corsHeaders });
}
