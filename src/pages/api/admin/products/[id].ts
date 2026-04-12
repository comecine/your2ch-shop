import type { APIRoute } from 'astro';
import { env as cfEnv } from "cloudflare:workers";
import { requireAdmin, jsonResponse, corsHeaders } from '../../_helpers';

const { DB: db } = cfEnv as unknown as { DB: D1Database };

export const GET: APIRoute = async (context) => {
  try {
    const admin = await requireAdmin(context.request);
    if (!admin) return jsonResponse({ success: false, error: '未授权' }, 401);

    const { id } = context.params;
    const product = await db.prepare(
      `SELECT p.*, c.name as category_name
       FROM products p
       LEFT JOIN categories c ON p.category_id = c.id
       WHERE p.id = ?`
    ).bind(id).first() as Record<string, unknown> | null;

    if (!product) return jsonResponse({ success: false, error: '商品不存在' }, 404);
    if (product.images) {
      try { product.images = JSON.parse(product.images as string); } catch { product.images = []; }
    }

    return jsonResponse({ success: true, data: { product } });
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

    const existing = await db.prepare('SELECT id FROM products WHERE id = ?').bind(id).first();
    if (!existing) return jsonResponse({ success: false, error: '商品不存在' }, 404);

    const allowedFields = ['category_id', 'name', 'slug', 'description', 'price', 'original_price',
      'image_url', 'images', 'stock', 'status'];
    const fields: string[] = [];
    const values: unknown[] = [];
    const nowTs = Math.floor(Date.now() / 1000);

    for (const key of allowedFields) {
      if (body[key] !== undefined) {
        fields.push(`${key} = ?`);
        values.push(key === 'images' ? JSON.stringify(body[key]) : body[key]);
      }
    }
    if (fields.length === 0) return jsonResponse({ success: false, error: '没有提供更新字段' }, 400);

    fields.push('updated_at = ?');
    values.push(nowTs, id);

    await db.prepare(
      `UPDATE products SET ${fields.join(', ')} WHERE id = ?`
    ).bind(...values).run();

    return jsonResponse({ success: true, message: '商品更新成功' });
  } catch (err: unknown) {
    return jsonResponse({ success: false, error: (err as Error).message }, 500);
  }
};

export const DELETE: APIRoute = async (context) => {
  try {
    const admin = await requireAdmin(context.request);
    if (!admin) return jsonResponse({ success: false, error: '未授权' }, 401);

    const { id } = context.params;
    const nowTs = Math.floor(Date.now() / 1000);

    const existing = await db.prepare('SELECT id FROM products WHERE id = ?').bind(id).first();
    if (!existing) return jsonResponse({ success: false, error: '商品不存在' }, 404);

    // Soft delete
    await db.prepare(
      "UPDATE products SET status = 'inactive', updated_at = ? WHERE id = ?"
    ).bind(nowTs, id).run();

    return jsonResponse({ success: true, message: '商品已下架' });
  } catch (err: unknown) {
    return jsonResponse({ success: false, error: (err as Error).message }, 500);
  }
};

export const OPTIONS: APIRoute = async () => {
  return new Response(null, { status: 204, headers: corsHeaders });
};
