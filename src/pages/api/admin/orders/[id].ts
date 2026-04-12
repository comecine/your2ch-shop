import type { APIRoute } from 'astro';
import { env as cfEnv } from "cloudflare:workers";
import { requireAdmin, jsonResponse, corsHeaders } from '../../_helpers';

const { DB: db } = cfEnv as unknown as { DB: D1Database };

const VALID_STATUSES = ['pending', 'confirmed', 'shipped', 'completed', 'cancelled'];

export const GET: APIRoute = async (context) => {
  try {
    const admin = await requireAdmin(context.request);
    if (!admin) return jsonResponse({ success: false, error: '未授权' }, 401);

    const { id } = context.params;

    const order = await db.prepare(
      `SELECT o.*, u.username, u.email
       FROM orders o
       LEFT JOIN users u ON o.user_id = u.id
       WHERE o.id = ?`
    ).bind(id).first();

    if (!order) return jsonResponse({ success: false, error: '订单不存在' }, 404);

    const items = await db.prepare(
      'SELECT * FROM order_items WHERE order_id = ?'
    ).bind(id).all();

    return jsonResponse({ success: true, data: { order: { ...order, items: items.results } } });
  } catch (err: unknown) {
    return jsonResponse({ success: false, error: (err as Error).message }, 500);
  }
};

export const PUT: APIRoute = async (context) => {
  try {
    const admin = await requireAdmin(context.request);
    if (!admin) return jsonResponse({ success: false, error: '未授权' }, 401);

    const { id } = context.params;
    const body = await context.request.json();
    const { status, remark } = body;

    if (!status) return jsonResponse({ success: false, error: '请提供订单状态' }, 400);
    if (!VALID_STATUSES.includes(status)) {
      return jsonResponse({ success: false, error: '无效的订单状态' }, 400);
    }

    const nowTs = Math.floor(Date.now() / 1000);

    const existing = await db.prepare('SELECT id FROM orders WHERE id = ?').bind(id).first();
    if (!existing) return jsonResponse({ success: false, error: '订单不存在' }, 404);

    const fields = ['status = ?', 'updated_at = ?'];
    const values: unknown[] = [status, nowTs];

    if (remark !== undefined) {
      fields.push('remark = ?');
      values.push(remark);
    }
    values.push(id);

    await db.prepare(
      `UPDATE orders SET ${fields.join(', ')} WHERE id = ?`
    ).bind(...values).run();

    return jsonResponse({ success: true, message: '订单状态已更新' });
  } catch (err: unknown) {
    return jsonResponse({ success: false, error: (err as Error).message }, 500);
  }
};

export const OPTIONS: APIRoute = async () => {
  return new Response(null, { status: 204, headers: corsHeaders });
};
