import { requireAdmin, jsonResponse, corsHeaders } from '../../_helpers.js';

export async function onRequestGet(context) {
  try {
    const admin = await requireAdmin(context);
    if (!admin) return jsonResponse({ success: false, error: '未授权' }, 401);

    const url = new URL(context.request.url);
    const page = Math.max(1, parseInt(url.searchParams.get('page') || '1', 10));
    const limit = Math.min(100, Math.max(1, parseInt(url.searchParams.get('limit') || '20', 10)));
    const lowStock = url.searchParams.get('low_stock') === '1';
    const offset = (page - 1) * limit;

    const db = context.env.DB;
    let where = "p.status = 'active'";
    const params = [];

    if (lowStock) {
      where += ' AND p.stock < 10';
    }

    const countRow = await db.prepare(
      `SELECT COUNT(*) as total FROM products p WHERE ${where}`
    ).bind(...params).first();
    const total = countRow?.total || 0;

    const products = await db.prepare(
      `SELECT p.id, p.name, p.slug, p.stock, p.sales, p.status,
              c.name as category_name
       FROM products p
       LEFT JOIN categories c ON p.category_id = c.id
       WHERE ${where}
       ORDER BY p.stock ASC, p.id ASC
       LIMIT ? OFFSET ?`
    ).bind(...params, limit, offset).all();

    return jsonResponse({
      success: true,
      data: {
        inventory: products.results,
        total,
        page,
        totalPages: Math.ceil(total / limit),
      },
    });
  } catch (err) {
    return jsonResponse({ success: false, error: err.message }, 500);
  }
}

export async function onRequestOptions() {
  return new Response(null, { status: 204, headers: corsHeaders });
}
