import { jsonResponse, corsHeaders } from '../_helpers.js';

export async function onRequestGet(context) {
  try {
    const db = context.env.DB;

    const banners = await db.prepare(
      `SELECT id, title, subtitle, image_url, link_url, sort_order
       FROM banners
       WHERE status = 'active'
       ORDER BY sort_order ASC, id ASC`
    ).all();

    return jsonResponse({ success: true, data: { banners: banners.results } });
  } catch (err) {
    return jsonResponse({ success: false, error: err.message }, 500);
  }
}

export async function onRequestOptions() {
  return new Response(null, { status: 204, headers: corsHeaders });
}
