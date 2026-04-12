import type { APIRoute } from 'astro';
import { env as cfEnv } from "cloudflare:workers";
import { jsonResponse, corsHeaders } from '../_helpers';

const { DB: db } = cfEnv as unknown as { DB: D1Database };

export const GET: APIRoute = async () => {
  try {
    const banners = await db.prepare(
      `SELECT id, title, subtitle, image_url, link_url, sort_order
       FROM banners
       WHERE status = 'active'
       ORDER BY sort_order ASC, id ASC`
    ).all();

    return jsonResponse({ success: true, data: { banners: banners.results } });
  } catch (err: unknown) {
    return jsonResponse({ success: false, error: (err as Error).message }, 500);
  }
};

export const OPTIONS: APIRoute = async () => {
  return new Response(null, { status: 204, headers: corsHeaders });
};
