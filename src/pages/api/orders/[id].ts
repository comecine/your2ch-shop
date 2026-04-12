import type { APIRoute } from 'astro';
import { env as cfEnv } from "cloudflare:workers";
import { requireAuth, jsonResponse, corsHeaders } from '../_helpers';

const { DB: db } = cfEnv as unknown as { DB: D1Database };

export const GET: APIRoute = async (context) => {
  try {
    const user = await requireAuth(context.request);
    if (!user) return jsonResponse({ success: false, error: '请先登录' }, 401);

    const { id } = context.params;

    const order = await db.prepare(
      `SELECT id, order_no, total_amount, status, payment_method, payment_status,
              shipping_name, shipping_phone, shipping_address, remark, created_at, updated_at
       FROM orders WHERE id = ? AND user_id = ?`
    ).bind(id, user.userId).first();

    if (!order) return jsonResponse({ success: false, error: '订单不存在' }, 404);

    const items = await db.prepare(
      'SELECT * FROM order_items WHERE order_id = ?'
    ).bind(id).all();

    return jsonResponse({ success: true, data: { order: { ...order, items: items.results } } });
  } catch (err: unknown) {
    return jsonResponse({ success: false, error: (err as Error).message }, 500);
  }
};

export const OPTIONS: APIRoute = async () => {
  return new Response(null, { status: 204, headers: corsHeaders });
};
