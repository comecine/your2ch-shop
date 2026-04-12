import type { APIRoute } from 'astro';
import { env as cfEnv } from "cloudflare:workers";
import { requireAuth, jsonResponse, corsHeaders } from '../_helpers';

const { DB: db } = cfEnv as unknown as { DB: D1Database };

export const GET: APIRoute = async (context) => {
  try {
    const user = await requireAuth(context.request);
    if (!user) return jsonResponse({ success: false, error: '请先登录' }, 401);

    const addresses = await db.prepare(
      'SELECT * FROM addresses WHERE user_id = ? ORDER BY is_default DESC, created_at DESC'
    ).bind(user.userId).all();

    return jsonResponse({ success: true, data: { addresses: addresses.results } });
  } catch (err: unknown) {
    return jsonResponse({ success: false, error: (err as Error).message }, 500);
  }
};

export const POST: APIRoute = async (context) => {
  try {
    const user = await requireAuth(context.request);
    if (!user) return jsonResponse({ success: false, error: '请先登录' }, 401);

    const body = await context.request.json();
    const { name, phone, province, city, district, detail, is_default = 0 } = body;

    if (!name || !phone || !province || !city || !district || !detail) {
      return jsonResponse({ success: false, error: '请填写完整地址信息' }, 400);
    }

    if (is_default) {
      await db.prepare(
        'UPDATE addresses SET is_default = 0 WHERE user_id = ?'
      ).bind(user.userId).run();
    }

    const result = await db.prepare(
      `INSERT INTO addresses (user_id, name, phone, province, city, district, detail, is_default)
       VALUES (?, ?, ?, ?, ?, ?, ?, ?)`
    ).bind(user.userId, name, phone, province, city, district, detail, is_default ? 1 : 0).run();

    return jsonResponse({
      success: true,
      message: '地址添加成功',
      data: { id: result.meta.last_row_id },
    }, 201);
  } catch (err: unknown) {
    return jsonResponse({ success: false, error: (err as Error).message }, 500);
  }
};

export const OPTIONS: APIRoute = async () => {
  return new Response(null, { status: 204, headers: corsHeaders });
};
