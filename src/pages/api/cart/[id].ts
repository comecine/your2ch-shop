import type { APIRoute } from 'astro';
import { env as cfEnv } from "cloudflare:workers";
import { requireAuth, jsonResponse, corsHeaders } from '../_helpers';

const { DB: db } = cfEnv as unknown as { DB: D1Database };

export const PUT: APIRoute = async (context) => {
  try {
    const user = await requireAuth(context.request);
    if (!user) return jsonResponse({ success: false, error: '请先登录' }, 401);

    const { id } = context.params;
    const body = await context.request.json();
    const { quantity } = body;

    if (!quantity || quantity < 1) {
      return jsonResponse({ success: false, error: '数量必须大于0' }, 400);
    }

    const item = await db.prepare(
      'SELECT id FROM cart_items WHERE id = ? AND user_id = ?'
    ).bind(id, user.userId).first();

    if (!item) return jsonResponse({ success: false, error: '购物车项目不存在' }, 404);

    await db.prepare(
      'UPDATE cart_items SET quantity = ? WHERE id = ? AND user_id = ?'
    ).bind(quantity, id, user.userId).run();

    return jsonResponse({ success: true, message: '已更新数量' });
  } catch (err: unknown) {
    return jsonResponse({ success: false, error: (err as Error).message }, 500);
  }
};

export const DELETE: APIRoute = async (context) => {
  try {
    const user = await requireAuth(context.request);
    if (!user) return jsonResponse({ success: false, error: '请先登录' }, 401);

    const { id } = context.params;

    const item = await db.prepare(
      'SELECT id FROM cart_items WHERE id = ? AND user_id = ?'
    ).bind(id, user.userId).first();

    if (!item) return jsonResponse({ success: false, error: '购物车项目不存在' }, 404);

    await db.prepare(
      'DELETE FROM cart_items WHERE id = ? AND user_id = ?'
    ).bind(id, user.userId).run();

    return jsonResponse({ success: true, message: '已删除' });
  } catch (err: unknown) {
    return jsonResponse({ success: false, error: (err as Error).message }, 500);
  }
};

export const OPTIONS: APIRoute = async () => {
  return new Response(null, { status: 204, headers: corsHeaders });
};
