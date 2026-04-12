import { hashPassword, jsonResponse, corsHeaders } from '../_helpers.js';

export async function onRequestPost(context) {
  try {
    const body = await context.request.json();
    const { username, email, password, phone } = body;

    if (!username || !email || !password) {
      return jsonResponse({ success: false, error: '用户名、邮箱和密码为必填项' }, 400);
    }

    const db = context.env.DB;

    // Check duplicate email
    const existingEmail = await db.prepare('SELECT id FROM users WHERE email = ?').bind(email).first();
    if (existingEmail) {
      return jsonResponse({ success: false, error: '该邮箱已被注册' }, 409);
    }

    // Check duplicate username
    const existingUsername = await db.prepare('SELECT id FROM users WHERE username = ?').bind(username).first();
    if (existingUsername) {
      return jsonResponse({ success: false, error: '该用户名已被使用' }, 409);
    }

    const passwordHash = await hashPassword(password);
    const activationToken = crypto.randomUUID();
    const activationExpires = Math.floor(Date.now() / 1000) + 86400; // +24h

    await db.prepare(`
      INSERT INTO users (username, email, password_hash, phone, status, activation_token, activation_expires)
      VALUES (?, ?, ?, ?, 'pending', ?, ?)
    `).bind(username, email, passwordHash, phone || null, activationToken, activationExpires).run();

    return jsonResponse({
      success: true,
      message: '注册成功，请查收激活邮件',
      data: { activation_token: activationToken }, // demo only
    }, 201);
  } catch (err) {
    return jsonResponse({ success: false, error: err.message }, 500);
  }
}

export async function onRequestOptions() {
  return new Response(null, { status: 204, headers: corsHeaders });
}
