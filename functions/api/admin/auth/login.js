import { verifyPassword, createJWT, jsonResponse, corsHeaders } from '../../_helpers.js';

export async function onRequestPost(context) {
  try {
    const body = await context.request.json();
    const { username, password } = body;

    if (!username || !password) {
      return jsonResponse({ success: false, error: '用户名和密码为必填项' }, 400);
    }

    const db = context.env.DB;
    const admin = await db.prepare(
      'SELECT id, username, password_hash, role FROM admin_users WHERE username = ?'
    ).bind(username).first();

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
      context.env.JWT_SECRET
    );

    const headers = new Headers({
      'Content-Type': 'application/json',
      ...corsHeaders,
      'Set-Cookie': `admin_token=${token}; HttpOnly; Path=/; Max-Age=86400; SameSite=Lax`,
    });

    return new Response(JSON.stringify({
      success: true,
      data: { admin: { id: admin.id, username: admin.username, role: admin.role } },
    }), { status: 200, headers });
  } catch (err) {
    return jsonResponse({ success: false, error: err.message }, 500);
  }
}

export async function onRequestOptions() {
  return new Response(null, { status: 204, headers: corsHeaders });
}
