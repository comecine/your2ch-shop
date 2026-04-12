import { requireAuth, jsonResponse, corsHeaders } from '../_helpers.js';

export async function onRequestGet(context) {
  try {
    const user = await requireAuth(context);
    if (!user) return jsonResponse({ success: false, error: '请先登录' }, 401);

    const { id } = context.params;
    const db = context.env.DB;

    const order = await db.prepare(
      `SELECT id, order_no, total_amount, status, payment_method, payment_status,
              shipping_name, shipping_phone, shipping_address, remark, created_at, updated_at
       FROM orders WHERE id = ? AND user_id = ?`
    ).bind(id, user.userId).first();

    if (!order) return jsonResponse({ success: false, error: '订单不存在' }, 404);

    const items = await db.prepare(
      'SELECT * FROM order_items WHERE order_id = ?'
    ).bind(id).all();

    return jsonResponse({ success: true, data: { order: { ...order, items: items.results } } });
  } catch (err) {
    return jsonResponse({ success: false, error: err.message }, 500);
  }
}

export async function onRequestOptions() {
  return new Response(null, { status: 204, headers: corsHeaders });
}
