import type { APIRoute } from 'astro';
import { env as cfEnv } from "cloudflare:workers";
import { requireAdmin, jsonResponse, corsHeaders } from '../../_helpers';

const { DB: db } = cfEnv as unknown as { DB: D1Database };

export const GET: APIRoute = async (context) => {
  try {
    const admin = await requireAdmin(context.request);
    if (!admin) return jsonResponse({ success: false, error: '未授权' }, 401);

    const categories = await db.prepare(
      `SELECT c.*, COUNT(p.id) as product_count
       FROM categories c
       LEFT JOIN products p ON p.category_id = c.id AND p.status = 'active'
       GROUP BY c.id
       ORDER BY c.sort_order ASC, c.id ASC`
    ).all();

    return jsonResponse({ success: true, data: { categories: categories.results } });
  } catch (err: unknown) {
    return jsonResponse({ success: false, error: (err as Error).message }, 500);
  }
};

export const POST: APIRoute = async (context) => {
  try {
    const admin = await requireAdmin(context.request);
    if (!admin) return jsonResponse({ success: false, error: '未授权' }, 401);

    const body = await context.request.json();
    const { name, slug, icon, sort_order = 0 } = body;

    if (!name || !slug) {
      return jsonResponse({ success: false, error: '名称和slug为必填项' }, 400);
    }

    const nowTs = Math.floor(Date.now() / 1000);
    const result = await db.prepare(
      'INSERT INTO categories (name, slug, icon, sort_order, created_at) VALUES (?, ?, ?, ?, ?)'
    ).bind(name, slug, icon || null, sort_order, nowTs).run();

    return jsonResponse({
      success: true,
      message: '分类创建成功',
      data: { id: result.meta.last_row_id },
    }, 201);
  } catch (err: unknown) {
    if ((err as Error).message?.includes('UNIQUE')) {
      return jsonResponse({ success: false, error: 'slug 已存在' }, 409);
    }
    return jsonResponse({ success: false, error: (err as Error).message }, 500);
  }
};

export const OPTIONS: APIRoute = async () => {
  return new Response(null, { status: 204, headers: corsHeaders });
};
