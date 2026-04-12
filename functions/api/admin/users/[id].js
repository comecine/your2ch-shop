import { requireAdmin, jsonResponse, corsHeaders } from '../../_helpers.js';

const VALID_STATUSES = ['active', 'disabled', 'pending'];

export async function onRequestPut(context) {
  try {
    const admin = await requireAdmin(context);
    if (!admin) return jsonResponse({ success: false, error: '未授权' }, 401);

    const { id } = context.params;
    const body = await context.request.json();
    const { status } = body;

    if (!status) return jsonResponse({ success: false, error: '请提供用户状态' }, 400);
    if (!VALID_STATUSES.includes(status)) {
      return jsonResponse({ success: false, error: '无效的状态值' }, 400);
    }

    const db = context.env.DB;
    const nowTs = Math.floor(Date.now() / 1000);

    const existing = await db.prepare('SELECT id FROM users WHERE id = ?').bind(id).first();
    if (!existing) return jsonResponse({ success: false, error: '用户不存在' }, 404);

    await db.prepare(
      'UPDATE users SET status = ?, updated_at = ? WHERE id = ?'
    ).bind(status, nowTs, id).run();

    return jsonResponse({ success: true, message: '用户状态已更新' });
  } catch (err) {
    return jsonResponse({ success: false, error: err.message }, 500);
  }
}

export async function onRequestOptions() {
  return new Response(null, { status: 204, headers: corsHeaders });
}
