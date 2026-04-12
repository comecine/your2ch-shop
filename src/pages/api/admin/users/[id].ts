import type { APIRoute } from 'astro';
import { env as cfEnv } from "cloudflare:workers";
import { requireAdmin, jsonResponse, corsHeaders } from '../../_helpers';

const { DB: db } = cfEnv as unknown as { DB: D1Database };

const VALID_STATUSES = ['active', 'disabled', 'pending'];

export const PUT: APIRoute = async (context) => {
  try {
    const admin = await requireAdmin(context.request);
    if (!admin) return jsonResponse({ success: false, error: '未授权' }, 401);

    const { id } = context.params;
    const body = await context.request.json();
    const { status } = body;

    if (!status) return jsonResponse({ success: false, error: '请提供用户状态' }, 400);
    if (!VALID_STATUSES.includes(status)) {
      return jsonResponse({ success: false, error: '无效的状态值' }, 400);
    }

    const nowTs = Math.floor(Date.now() / 1000);

    const existing = await db.prepare('SELECT id FROM users WHERE id = ?').bind(id).first();
    if (!existing) return jsonResponse({ success: false, error: '用户不存在' }, 404);

    await db.prepare(
      'UPDATE users SET status = ?, updated_at = ? WHERE id = ?'
    ).bind(status, nowTs, id).run();

    return jsonResponse({ success: true, message: '用户状态已更新' });
  } catch (err: unknown) {
    return jsonResponse({ success: false, error: (err as Error).message }, 500);
  }
};

export const OPTIONS: APIRoute = async () => {
  return new Response(null, { status: 204, headers: corsHeaders });
};
