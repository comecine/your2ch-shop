import { requireAdmin, jsonResponse, corsHeaders } from '../../_helpers.js';

export async function onRequestGet(context) {
  try {
    const admin = await requireAdmin(context);
    if (!admin) return jsonResponse({ success: false, error: '未授权' }, 401);

    const url = new URL(context.request.url);
    const page = Math.max(1, parseInt(url.searchParams.get('page') || '1', 10));
    const limit = Math.min(100, Math.max(1, parseInt(url.searchParams.get('limit') || '20', 10)));
    const search = url.searchParams.get('search') || '';
    const offset = (page - 1) * limit;

    const db = context.env.DB;
    let where = '1=1';
    const params = [];

    if (search) {
      where += ' AND p.name LIKE ?';
      params.push(`%${search}%`);
    }

    const countRow = await db.prepare(
      `SELECT COUNT(*) as total FROM products p WHERE ${where}`
    ).bind(...params).first();
    const total = countRow?.total || 0;

    const products = await db.prepare(
      `SELECT p.*, c.name as category_name
       FROM products p
       LEFT JOIN categories c ON p.category_id = c.id
       WHERE ${where}
       ORDER BY p.created_at DESC
       LIMIT ? OFFSET ?`
    ).bind(...params, limit, offset).all();

    return jsonResponse({
      success: true,
      data: { products: products.results, total, page, totalPages: Math.ceil(total / limit) },
    });
  } catch (err) {
    return jsonResponse({ success: false, error: err.message }, 500);
  }
}

export async function onRequestPost(context) {
  try {
    const admin = await requireAdmin(context);
    if (!admin) return jsonResponse({ success: false, error: '未授权' }, 401);

    const body = await context.request.json();
    const { category_id, name, slug, description, price, original_price, image_url, images, stock, status = 'active' } = body;

    if (!category_id || !name || !slug || price === undefined) {
      return jsonResponse({ success: false, error: '分类、名称、slug、价格为必填项' }, 400);
    }

    const db = context.env.DB;
    const nowTs = Math.floor(Date.now() / 1000);

    const result = await db.prepare(
      `INSERT INTO products (category_id, name, slug, description, price, original_price,
        image_url, images, stock, status, created_at, updated_at)
       VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`
    ).bind(
      category_id, name, slug, description || null, price,
      original_price || null, image_url || null,
      images ? JSON.stringify(images) : null,
      stock || 0, status, nowTs, nowTs
    ).run();

    return jsonResponse({
      success: true,
      message: '商品创建成功',
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
