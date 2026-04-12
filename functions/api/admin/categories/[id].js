import { requireAdmin, jsonResponse, corsHeaders } from '../../_helpers.js';

export async function onRequestPut(context) {
  try {
    const admin = await requireAdmin(context);
    if (!admin) return jsonResponse({ success: false, error: '未授权' }, 401);

    const { id } = context.params;
    const body = await context.request.json();
    const db = context.env.DB;

    const existing = await db.prepare('SELECT id FROM categories WHERE id = ?').bind(id).first();
    if (!existing) return jsonResponse({ success: false, error: '分类不存在' }, 404);

    const allowedFields = ['name', 'slug', 'icon', 'sort_order'];
    const fields = [];
    const values = [];

    for (const key of allowedFields) {
      if (body[key] !== undefined) {
        fields.push(`${key} = ?`);
        values.push(body[key]);
      }
    }
    if (fields.length === 0) return jsonResponse({ success: false, error: '没有提供更新字段' }, 400);

    values.push(id);
    await db.prepare(
      `UPDATE categories SET ${fields.join(', ')} WHERE id = ?`
    ).bind(...values).run();

    return jsonResponse({ success: true, message: '分类更新成功' });
  } catch (err) {
    return jsonResponse({ success: false, error: err.message }, 500);
  }
}

export async function onRequestDelete(context) {
  try {
    const admin = await requireAdmin(context);
    if (!admin) return jsonResponse({ success: false, error: '未授权' }, 401);

    const { id } = context.params;
    const db = context.env.DB;

    const existing = await db.prepare('SELECT id FROM categories WHERE id = ?').bind(id).first();
    if (!existing) return jsonResponse({ success: false, error: '分类不存在' }, 404);

    // Check if any products use this category
    const productCount = await db.prepare(
      'SELECT COUNT(*) as count FROM products WHERE category_id = ?'
    ).bind(id).first();
    if (productCount?.count > 0) {
      return jsonResponse({ success: false, error: '该分类下还有商品，无法删除' }, 409);
    }

    await db.prepare('DELETE FROM categories WHERE id = ?').bind(id).run();

    return jsonResponse({ success: true, message: '分类已删除' });
  } catch (err) {
    return jsonResponse({ success: false, error: err.message }, 500);
  }
}

export async function onRequestOptions() {
  return new Response(null, { status: 204, headers: corsHeaders });
}
