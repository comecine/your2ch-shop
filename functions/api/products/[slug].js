import { jsonResponse, corsHeaders } from '../_helpers.js';

export async function onRequestGet(context) {
  try {
    const { slug } = context.params;
    const db = context.env.DB;

    const product = await db.prepare(
      `SELECT p.*, c.name as category_name, c.slug as category_slug
       FROM products p
       LEFT JOIN categories c ON p.category_id = c.id
       WHERE p.slug = ? AND p.status = 'active'`
    ).bind(slug).first();

    if (!product) {
      return jsonResponse({ success: false, error: '商品不存在' }, 404);
    }

    // Parse images JSON if present
    if (product.images) {
      try { product.images = JSON.parse(product.images); } catch { product.images = []; }
    }

    return jsonResponse({ success: true, data: { product } });
  } catch (err) {
    return jsonResponse({ success: false, error: err.message }, 500);
  }
}

export async function onRequestOptions() {
  return new Response(null, { status: 204, headers: corsHeaders });
}
