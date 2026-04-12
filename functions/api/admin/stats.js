import { requireAdmin, jsonResponse, corsHeaders } from '../_helpers.js';

export async function onRequestGet(context) {
  try {
    const admin = await requireAdmin(context);
    if (!admin) return jsonResponse({ success: false, error: '未授权' }, 401);

    const db = context.env.DB;

    // Start of current month (Unix timestamp)
    const now = new Date();
    const monthStart = Math.floor(new Date(now.getFullYear(), now.getMonth(), 1).getTime() / 1000);

    const [
      totalOrders,
      totalUsers,
      totalProducts,
      monthlySales,
      ordersByStatus,
    ] = await Promise.all([
      db.prepare('SELECT COUNT(*) as count FROM orders').first(),
      db.prepare('SELECT COUNT(*) as count FROM users').first(),
      db.prepare("SELECT COUNT(*) as count FROM products WHERE status = 'active'").first(),
      db.prepare(
        "SELECT COALESCE(SUM(total_amount), 0) as amount FROM orders WHERE created_at >= ? AND status != 'cancelled'"
      ).bind(monthStart).first(),
      db.prepare(
        `SELECT status, COUNT(*) as count FROM orders GROUP BY status`
      ).all(),
    ]);

    const statusMap = {};
    for (const row of ordersByStatus.results) {
      statusMap[row.status] = row.count;
    }

    return jsonResponse({
      success: true,
      data: {
        total_orders: totalOrders?.count || 0,
        total_users: totalUsers?.count || 0,
        total_products: totalProducts?.count || 0,
        monthly_sales: monthlySales?.amount || 0,
        orders_by_status: statusMap,
      },
    });
  } catch (err) {
    return jsonResponse({ success: false, error: err.message }, 500);
  }
}

export async function onRequestOptions() {
  return new Response(null, { status: 204, headers: corsHeaders });
}
