import type { APIRoute } from 'astro';
import { env as cfEnv } from "cloudflare:workers";
import { jsonResponse, corsHeaders } from '../_helpers';

const { DB: db } = cfEnv as unknown as { DB: D1Database };

export const GET: APIRoute = async () => {
  try {
    const categories = await db.prepare(
      `SELECT c.id, c.name, c.slug, c.icon, c.sort_order,
              COUNT(p.id) as product_count
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

export const OPTIONS: APIRoute = async () => {
  return new Response(null, { status: 204, headers: corsHeaders });
};
