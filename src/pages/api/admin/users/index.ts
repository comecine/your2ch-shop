import type { APIRoute } from 'astro';
import { env as cfEnv } from "cloudflare:workers";
import { requireAdmin, jsonResponse, corsHeaders } from '../../_helpers';

const { DB: db } = cfEnv as unknown as { DB: D1Database };

export const GET: APIRoute = async (context) => {
  try {
    const admin = await requireAdmin(context.request);
    if (!admin) return jsonResponse({ success: false, error: '未授权' }, 401);

    const url = new URL(context.request.url);
    const page = Math.max(1, parseInt(url.searchParams.get('page') || '1', 10));
    const limit = Math.min(100, Math.max(1, parseInt(url.searchParams.get('limit') || '20', 10)));
    const status = url.searchParams.get('status') || '';
    const search = url.searchParams.get('search') || '';
    const offset = (page - 1) * limit;

    let where = '1=1';
    const params: unknown[] = [];

    if (status) {
      where += ' AND status = ?';
      params.push(status);
    }
    if (search) {
      where += ' AND (email LIKE ? OR username LIKE ?)';
      params.push(`%${search}%`, `%${search}%`);
    }

    const countRow = await db.prepare(
      `SELECT COUNT(*) as total FROM users WHERE ${where}`
    ).bind(...params).first() as { total: number } | null;
    const total = countRow?.total || 0;

    const users = await db.prepare(
      `SELECT id, username, email, phone, status, created_at, updated_at
       FROM users WHERE ${where}
       ORDER BY created_at DESC
       LIMIT ? OFFSET ?`
    ).bind(...params, limit, offset).all();

    return jsonResponse({
      success: true,
      data: { users: users.results, total, page, totalPages: Math.ceil(total / limit) },
    });
  } catch (err: unknown) {
    return jsonResponse({ success: false, error: (err as Error).message }, 500);
  }
};

export const OPTIONS: APIRoute = async () => {
  return new Response(null, { status: 204, headers: corsHeaders });
};
