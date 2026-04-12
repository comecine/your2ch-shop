import type { APIRoute } from 'astro';
import { env as cfEnv } from "cloudflare:workers";
import { requireAuth, jsonResponse, corsHeaders } from '../_helpers';

const { DB: db } = cfEnv as unknown as { DB: D1Database };

export const GET: APIRoute = async (context) => {
  try {
    const user = await requireAuth(context.request);
    if (!user) return jsonResponse({ success: false, error: '请先登录' }, 401);

    const items = await db.prepare(
      `SELECT ci.id, ci.quantity, ci.created_at,
              p.id as product_id, p.name, p.slug, p.price, p.original_price,
              p.image_url, p.stock
       FROM cart_items ci
       JOIN products p ON ci.product_id = p.id
       WHERE ci.user_id = ?
       ORDER BY ci.created_at DESC`
    ).bind(user.userId).all();

    const total = (items.results as { price: number; quantity: number }[])
      .reduce((sum, item) => sum + item.price * item.quantity, 0);

    return jsonResponse({ success: true, data: { items: items.results, total } });
  } catch (err: unknown) {
    return jsonResponse({ success: false, error: (err as Error).message }, 500);
  }
};

export const POST: APIRoute = async (context) => {
  try {
    const user = await requireAuth(context.request);
    if (!user) return jsonResponse({ success: false, error: '请先登录' }, 401);

    const body = await context.request.json();
    const { product_id, quantity = 1 } = body;

    if (!product_id || quantity < 1) {
      return jsonResponse({ success: false, error: '参数错误' }, 400);
    }

    // Check product exists and is active
    const product = await db.prepare(
      "SELECT id, stock FROM products WHERE id = ? AND status = 'active'"
    ).bind(product_id).first();
    if (!product) return jsonResponse({ success: false, error: '商品不存在' }, 404);

    // Upsert: insert or add quantity
    await db.prepare(
      `INSERT INTO cart_items (user_id, product_id, quantity)
       VALUES (?, ?, ?)
       ON CONFLICT(user_id, product_id)
       DO UPDATE SET quantity = quantity + excluded.quantity`
    ).bind(user.userId, product_id, quantity).run();

    return jsonResponse({ success: true, message: '已加入购物车' }, 201);
  } catch (err: unknown) {
    return jsonResponse({ success: false, error: (err as Error).message }, 500);
  }
};

export const OPTIONS: APIRoute = async () => {
  return new Response(null, { status: 204, headers: corsHeaders });
};
