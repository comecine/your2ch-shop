import type { APIRoute } from 'astro';
import { env as cfEnv } from "cloudflare:workers";
import { requireAdmin, jsonResponse, corsHeaders } from '../../_helpers';

const { DB: db } = cfEnv as unknown as { DB: D1Database };

export const PUT: APIRoute = async (context) => {
  try {
    const admin = await requireAdmin(context.request);
    if (!admin) return jsonResponse({ success: false, error: '未授权' }, 401);

    const { id } = context.params;
    const body = await context.request.json();

    const existing = await db.prepare('SELECT id FROM categories WHERE id = ?').bind(id).first();
    if (!existing) return jsonResponse({ success: false, error: '分类不存在' }, 404);

    const allowedFields = ['name', 'slug', 'icon', 'sort_order'];
    const fields: string[] = [];
    const values: unknown[] = [];

    for (const key of allowedFields) {
      if (body[key] !== undefined) {
        fields.push(`${key} = ?`);
        values.push(body[key]);
      }
    }
    if (fields.length === 0) return jsonResponse({ success: false, error: '没有提供更新字段' }, 400);

    values.push(id);
    await db.prepare(
      `UPDATE categories SET ${fields.join(', ')} WHERE id = ?`
    ).bind(...values).run();

    return jsonResponse({ success: true, message: '分类更新成功' });
  } catch (err: unknown) {
    return jsonResponse({ success: false, error: (err as Error).message }, 500);
  }
};

export const DELETE: APIRoute = async (context) => {
  try {
    const admin = await requireAdmin(context.request);
    if (!admin) return jsonResponse({ success: false, error: '未授权' }, 401);

    const { id } = context.params;

    const existing = await db.prepare('SELECT id FROM categories WHERE id = ?').bind(id).first();
    if (!existing) return jsonResponse({ success: false, error: '分类不存在' }, 404);

    // Check if any products use this category
    const productCount = await db.prepare(
      'SELECT COUNT(*) as count FROM products WHERE category_id = ?'
    ).bind(id).first() as { count: number } | null;
    if (productCount && productCount.count > 0) {
      return jsonResponse({ success: false, error: '该分类下还有商品，无法删除' }, 409);
    }

    await db.prepare('DELETE FROM categories WHERE id = ?').bind(id).run();

    return jsonResponse({ success: true, message: '分类已删除' });
  } catch (err: unknown) {
    return jsonResponse({ success: false, error: (err as Error).message }, 500);
  }
};

export const OPTIONS: APIRoute = async () => {
  return new Response(null, { status: 204, headers: corsHeaders });
};
