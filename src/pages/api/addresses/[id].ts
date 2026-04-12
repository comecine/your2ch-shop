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
    const { name, phone, province, city, district, detail, is_default } = body;

    const existing = await db.prepare(
      'SELECT id FROM addresses WHERE id = ? AND user_id = ?'
    ).bind(id, user.userId).first();
    if (!existing) return jsonResponse({ success: false, error: '地址不存在' }, 404);

    if (is_default) {
      await db.prepare(
        'UPDATE addresses SET is_default = 0 WHERE user_id = ?'
      ).bind(user.userId).run();
    }

    const fields: string[] = [];
    const values: unknown[] = [];
    if (name !== undefined) { fields.push('name = ?'); values.push(name); }
    if (phone !== undefined) { fields.push('phone = ?'); values.push(phone); }
    if (province !== undefined) { fields.push('province = ?'); values.push(province); }
    if (city !== undefined) { fields.push('city = ?'); values.push(city); }
    if (district !== undefined) { fields.push('district = ?'); values.push(district); }
    if (detail !== undefined) { fields.push('detail = ?'); values.push(detail); }
    if (is_default !== undefined) { fields.push('is_default = ?'); values.push(is_default ? 1 : 0); }

    if (fields.length === 0) {
      return jsonResponse({ success: false, error: '没有提供更新字段' }, 400);
    }

    values.push(id, user.userId);
    await db.prepare(
      `UPDATE addresses SET ${fields.join(', ')} WHERE id = ? AND user_id = ?`
    ).bind(...values).run();

    return jsonResponse({ success: true, message: '地址更新成功' });
  } catch (err: unknown) {
    return jsonResponse({ success: false, error: (err as Error).message }, 500);
  }
};

export const DELETE: APIRoute = async (context) => {
  try {
    const user = await requireAuth(context.request);
    if (!user) return jsonResponse({ success: false, error: '请先登录' }, 401);

    const { id } = context.params;

    const existing = await db.prepare(
      'SELECT id FROM addresses WHERE id = ? AND user_id = ?'
    ).bind(id, user.userId).first();
    if (!existing) return jsonResponse({ success: false, error: '地址不存在' }, 404);

    await db.prepare('DELETE FROM addresses WHERE id = ? AND user_id = ?').bind(id, user.userId).run();

    return jsonResponse({ success: true, message: '地址已删除' });
  } catch (err: unknown) {
    return jsonResponse({ success: false, error: (err as Error).message }, 500);
  }
};

export const OPTIONS: APIRoute = async () => {
  return new Response(null, { status: 204, headers: corsHeaders });
};
