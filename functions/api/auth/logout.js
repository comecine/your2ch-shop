import { jsonResponse, corsHeaders } from '../_helpers.js';

export async function onRequestPost() {
  const headers = new Headers({
    'Content-Type': 'application/json',
    ...corsHeaders,
    'Set-Cookie': 'auth_token=; HttpOnly; Path=/; Max-Age=0; SameSite=Lax',
  });
  return new Response(JSON.stringify({ success: true, message: '已退出登录' }), { status: 200, headers });
}

export async function onRequestOptions() {
  return new Response(null, { status: 204, headers: corsHeaders });
}
