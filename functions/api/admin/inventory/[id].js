import { requireAdmin, jsonResponse, corsHeaders } from '../../_helpers.js';

export async function onRequestPut(context) {
  try {
    const admin = await requireAdmin(context);
    if (!admin) return jsonResponse({ success: false, error: '未授权' }, 401);

    const { id } = context.params;
    const body = await context.request.json();
    const { stock } = body;

    if (stock === undefined || stock < 0) {
      return jsonResponse({ success: false, error: '请提供有效的库存数量（>= 0）' }, 400);
    }

    const db = context.env.DB;
    const nowTs = Math.floor(Date.now() / 1000);

    const existing = await db.prepare('SELECT id FROM products WHERE id = ?').bind(id).first();
    if (!existing) return jsonResponse({ success: false, error: '商品不存在' }, 404);

    await db.prepare(
      'UPDATE products SET stock = ?, updated_at = ? WHERE id = ?'
    ).bind(stock, nowTs, id).run();

    return jsonResponse({ success: true, message: '库存已更新', data: { id: parseInt(id), stock } });
  } catch (err) {
    return jsonResponse({ success: false, error: err.message }, 500);
  }
}

export async function onRequestOptions() {
  return new Response(null, { status: 204, headers: corsHeaders });
}
