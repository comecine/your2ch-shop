import type { APIRoute } from 'astro';
import { env as cfEnv } from "cloudflare:workers";
import { requireAdmin, jsonResponse, corsHeaders } from '../_helpers';

const { DB: db } = cfEnv as unknown as { DB: D1Database };

export const GET: APIRoute = async (context) => {
  try {
    const admin = await requireAdmin(context.request);
    if (!admin) return jsonResponse({ success: false, error: '未授权' }, 401);

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

    const statusMap: Record<string, number> = {};
    for (const row of ordersByStatus.results as { status: string; count: number }[]) {
      statusMap[row.status] = row.count;
    }

    return jsonResponse({
      success: true,
      data: {
        total_orders: (totalOrders as { count: number } | null)?.count || 0,
        total_users: (totalUsers as { count: number } | null)?.count || 0,
        total_products: (totalProducts as { count: number } | null)?.count || 0,
        monthly_sales: (monthlySales as { amount: number } | null)?.amount || 0,
        orders_by_status: statusMap,
      },
    });
  } catch (err: unknown) {
    return jsonResponse({ success: false, error: (err as Error).message }, 500);
  }
};

export const OPTIONS: APIRoute = async () => {
  return new Response(null, { status: 204, headers: corsHeaders });
};
