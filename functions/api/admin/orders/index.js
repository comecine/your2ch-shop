import { requireAdmin, jsonResponse, corsHeaders } from '../../_helpers.js';

export async function onRequestGet(context) {
  try {
    const admin = await requireAdmin(context);
    if (!admin) return jsonResponse({ success: false, error: '未授权' }, 401);

    const url = new URL(context.request.url);
    const page = Math.max(1, parseInt(url.searchParams.get('page') || '1', 10));
    const limit = Math.min(100, Math.max(1, parseInt(url.searchParams.get('limit') || '20', 10)));
    const status = url.searchParams.get('status') || '';
    const offset = (page - 1) * limit;

    const db = context.env.DB;
    let where = '1=1';
    const params = [];

    if (status) {
      where += ' AND o.status = ?';
      params.push(status);
    }

    const countRow = await db.prepare(
      `SELECT COUNT(*) as total FROM orders o WHERE ${where}`
    ).bind(...params).first();
    const total = countRow?.total || 0;

    const orders = await db.prepare(
      `SELECT o.*, u.username, u.email
       FROM orders o
       LEFT JOIN users u ON o.user_id = u.id
       WHERE ${where}
       ORDER BY o.created_at DESC
       LIMIT ? OFFSET ?`
    ).bind(...params, limit, offset).all();

    return jsonResponse({
      success: true,
      data: { orders: orders.results, total, page, totalPages: Math.ceil(total / limit) },
    });
  } catch (err) {
    return jsonResponse({ success: false, error: err.message }, 500);
  }
}

export async function onRequestOptions() {
  return new Response(null, { status: 204, headers: corsHeaders });
}
