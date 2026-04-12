import { requireAdmin, jsonResponse, corsHeaders } from '../../_helpers.js';

export async function onRequestGet(context) {
  try {
    const admin = await requireAdmin(context);
    if (!admin) return jsonResponse({ success: false, error: '未授权' }, 401);

    const categories = await context.env.DB.prepare(
      `SELECT c.*, COUNT(p.id) as product_count
       FROM categories c
       LEFT JOIN products p ON p.category_id = c.id AND p.status = 'active'
       GROUP BY c.id
       ORDER BY c.sort_order ASC, c.id ASC`
    ).all();

    return jsonResponse({ success: true, data: { categories: categories.results } });
  } catch (err) {
    return jsonResponse({ success: false, error: err.message }, 500);
  }
}

export async function onRequestPost(context) {
  try {
    const admin = await requireAdmin(context);
    if (!admin) return jsonResponse({ success: false, error: '未授权' }, 401);

    const body = await context.request.json();
    const { name, slug, icon, sort_order = 0 } = body;

    if (!name || !slug) {
      return jsonResponse({ success: false, error: '名称和slug为必填项' }, 400);
    }

    const nowTs = Math.floor(Date.now() / 1000);
    const result = await context.env.DB.prepare(
      'INSERT INTO categories (name, slug, icon, sort_order, created_at) VALUES (?, ?, ?, ?, ?)'
    ).bind(name, slug, icon || null, sort_order, nowTs).run();

    return jsonResponse({
      success: true,
      message: '分类创建成功',
      data: { id: result.meta.last_row_id },
    }, 201);
  } catch (err) {
    if (err.message?.includes('UNIQUE')) {
      return jsonResponse({ success: false, error: 'slug 已存在' }, 409);
    }
    return jsonResponse({ success: false, error: err.message }, 500);
  }
}

export async function onRequestOptions() {
  return new Response(null, { status: 204, headers: corsHeaders });
}
