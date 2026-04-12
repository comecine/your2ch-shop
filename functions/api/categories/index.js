import { jsonResponse, corsHeaders } from '../_helpers.js';

export async function onRequestGet(context) {
  try {
    const db = context.env.DB;

    const categories = await db.prepare(
      `SELECT c.id, c.name, c.slug, c.icon, c.sort_order,
              COUNT(p.id) as product_count
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

export async function onRequestOptions() {
  return new Response(null, { status: 204, headers: corsHeaders });
}
