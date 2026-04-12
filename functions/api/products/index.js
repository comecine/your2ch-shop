import { jsonResponse, corsHeaders } from '../_helpers.js';

export async function onRequestGet(context) {
  try {
    const url = new URL(context.request.url);
    const page = Math.max(1, parseInt(url.searchParams.get('page') || '1', 10));
    const limit = Math.min(100, Math.max(1, parseInt(url.searchParams.get('limit') || '12', 10)));
    const category = url.searchParams.get('category') || '';
    const search = url.searchParams.get('search') || '';
    const sort = url.searchParams.get('sort') || 'newest';
    const offset = (page - 1) * limit;

    const db = context.env.DB;

    let where = "p.status = 'active'";
    const params = [];

    if (category) {
      where += ' AND c.slug = ?';
      params.push(category);
    }
    if (search) {
      where += ' AND p.name LIKE ?';
      params.push(`%${search}%`);
    }

    const orderMap = {
      price_asc: 'p.price ASC',
      price_desc: 'p.price DESC',
      newest: 'p.created_at DESC',
      sales: 'p.sales DESC',
    };
    const orderBy = orderMap[sort] || 'p.created_at DESC';

    const countRow = await db.prepare(
      `SELECT COUNT(*) as total FROM products p
       LEFT JOIN categories c ON p.category_id = c.id
       WHERE ${where}`
    ).bind(...params).first();
    const total = countRow?.total || 0;

    const products = await db.prepare(
      `SELECT p.id, p.name, p.slug, p.description, p.price, p.original_price,
              p.image_url, p.stock, p.sales, p.created_at,
              c.id as category_id, c.name as category_name, c.slug as category_slug
       FROM products p
       LEFT JOIN categories c ON p.category_id = c.id
       WHERE ${where}
       ORDER BY ${orderBy}
       LIMIT ? OFFSET ?`
    ).bind(...params, limit, offset).all();

    return jsonResponse({
      success: true,
      data: {
        products: products.results,
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
