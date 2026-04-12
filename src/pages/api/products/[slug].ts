import type { APIRoute } from 'astro';
import { env as cfEnv } from "cloudflare:workers";
import { jsonResponse, corsHeaders } from '../_helpers';

const { DB: db } = cfEnv as unknown as { DB: D1Database };

export const GET: APIRoute = async (context) => {
  try {
    const { slug } = context.params;

    const product = await db.prepare(
      `SELECT p.*, c.name as category_name, c.slug as category_slug
       FROM products p
       LEFT JOIN categories c ON p.category_id = c.id
       WHERE p.slug = ? AND p.status = 'active'`
    ).bind(slug).first() as Record<string, unknown> | null;

    if (!product) {
      return jsonResponse({ success: false, error: '商品不存在' }, 404);
    }

    // Parse images JSON if present
    if (product.images) {
      try { product.images = JSON.parse(product.images as string); } catch { product.images = []; }
    }

    return jsonResponse({ success: true, data: { product } });
  } catch (err: unknown) {
    return jsonResponse({ success: false, error: (err as Error).message }, 500);
  }
};

export const OPTIONS: APIRoute = async () => {
  return new Response(null, { status: 204, headers: corsHeaders });
};
