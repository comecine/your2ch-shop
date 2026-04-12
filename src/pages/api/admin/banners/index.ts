import type { APIRoute } from 'astro';
import { env as cfEnv } from "cloudflare:workers";
import { requireAdmin, jsonResponse, corsHeaders } from '../../_helpers';

const { DB: db } = cfEnv as unknown as { DB: D1Database };

export const GET: APIRoute = async (context) => {
  try {
    const admin = await requireAdmin(context.request);
    if (!admin) return jsonResponse({ success: false, error: '未授权' }, 401);

    const banners = await db.prepare(
      'SELECT * FROM banners ORDER BY sort_order ASC, id ASC'
    ).all();

    return jsonResponse({ success: true, data: { banners: banners.results } });
  } catch (err: unknown) {
    return jsonResponse({ success: false, error: (err as Error).message }, 500);
  }
};

export const POST: APIRoute = async (context) => {
  try {
    const admin = await requireAdmin(context.request);
    if (!admin) return jsonResponse({ success: false, error: '未授权' }, 401);

    const body = await context.request.json();
    const { title, subtitle, image_url, link_url, sort_order = 0, status = 'active' } = body;

    if (!title || !image_url) {
      return jsonResponse({ success: false, error: '标题和图片URL为必填项' }, 400);
    }

    const nowTs = Math.floor(Date.now() / 1000);
    const result = await db.prepare(
      'INSERT INTO banners (title, subtitle, image_url, link_url, sort_order, status, created_at) VALUES (?, ?, ?, ?, ?, ?, ?)'
    ).bind(title, subtitle || null, image_url, link_url || null, sort_order, status, nowTs).run();

    return jsonResponse({
      success: true,
      message: 'Banner 创建成功',
      data: { id: result.meta.last_row_id },
    }, 201);
  } catch (err: unknown) {
    return jsonResponse({ success: false, error: (err as Error).message }, 500);
  }
};

export const OPTIONS: APIRoute = async () => {
  return new Response(null, { status: 204, headers: corsHeaders });
};
