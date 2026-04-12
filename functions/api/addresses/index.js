import { requireAuth, jsonResponse, corsHeaders } from '../_helpers.js';

export async function onRequestGet(context) {
  try {
    const user = await requireAuth(context);
    if (!user) return jsonResponse({ success: false, error: '请先登录' }, 401);

    const addresses = await context.env.DB.prepare(
      'SELECT * FROM addresses WHERE user_id = ? ORDER BY is_default DESC, created_at DESC'
    ).bind(user.userId).all();

    return jsonResponse({ success: true, data: { addresses: addresses.results } });
  } catch (err) {
    return jsonResponse({ success: false, error: err.message }, 500);
  }
}

export async function onRequestPost(context) {
  try {
    const user = await requireAuth(context);
    if (!user) return jsonResponse({ success: false, error: '请先登录' }, 401);

    const body = await context.request.json();
    const { name, phone, province, city, district, detail, is_default = 0 } = body;

    if (!name || !phone || !province || !city || !district || !detail) {
      return jsonResponse({ success: false, error: '请填写完整地址信息' }, 400);
    }

    const db = context.env.DB;

    if (is_default) {
      await db.prepare(
        'UPDATE addresses SET is_default = 0 WHERE user_id = ?'
      ).bind(user.userId).run();
    }

    const result = await db.prepare(
      `INSERT INTO addresses (user_id, name, phone, province, city, district, detail, is_default)
       VALUES (?, ?, ?, ?, ?, ?, ?, ?)`
    ).bind(user.userId, name, phone, province, city, district, detail, is_default ? 1 : 0).run();

    return jsonResponse({
      success: true,
      message: '地址添加成功',
      data: { id: result.meta.last_row_id },
    }, 201);
  } catch (err) {
    return jsonResponse({ success: false, error: err.message }, 500);
  }
}

export async function onRequestOptions() {
  return new Response(null, { status: 204, headers: corsHeaders });
}
