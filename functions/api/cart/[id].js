import { requireAuth, jsonResponse, corsHeaders } from '../_helpers.js';

export async function onRequestPut(context) {
  try {
    const user = await requireAuth(context);
    if (!user) return jsonResponse({ success: false, error: '请先登录' }, 401);

    const { id } = context.params;
    const body = await context.request.json();
    const { quantity } = body;

    if (!quantity || quantity < 1) {
      return jsonResponse({ success: false, error: '数量必须大于0' }, 400);
    }

    const db = context.env.DB;
    const item = await db.prepare(
      'SELECT id FROM cart_items WHERE id = ? AND user_id = ?'
    ).bind(id, user.userId).first();

    if (!item) return jsonResponse({ success: false, error: '购物车项目不存在' }, 404);

    await db.prepare(
      'UPDATE cart_items SET quantity = ? WHERE id = ? AND user_id = ?'
    ).bind(quantity, id, user.userId).run();

    return jsonResponse({ success: true, message: '已更新数量' });
  } catch (err) {
    return jsonResponse({ success: false, error: err.message }, 500);
  }
}

export async function onRequestDelete(context) {
  try {
    const user = await requireAuth(context);
    if (!user) return jsonResponse({ success: false, error: '请先登录' }, 401);

    const { id } = context.params;
    const db = context.env.DB;

    const item = await db.prepare(
      'SELECT id FROM cart_items WHERE id = ? AND user_id = ?'
    ).bind(id, user.userId).first();

    if (!item) return jsonResponse({ success: false, error: '购物车项目不存在' }, 404);

    await db.prepare(
      'DELETE FROM cart_items WHERE id = ? AND user_id = ?'
    ).bind(id, user.userId).run();

    return jsonResponse({ success: true, message: '已删除' });
  } catch (err) {
    return jsonResponse({ success: false, error: err.message }, 500);
  }
}

export async function onRequestOptions() {
  return new Response(null, { status: 204, headers: corsHeaders });
}
