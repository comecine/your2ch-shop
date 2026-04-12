import type { APIRoute } from 'astro';
import { corsHeaders } from '../_helpers';

export const POST: APIRoute = async () => {
  const headers = new Headers({
    'Content-Type': 'application/json',
    ...corsHeaders,
    'Set-Cookie': 'auth_token=; HttpOnly; Path=/; Max-Age=0; SameSite=Lax',
  });
  return new Response(JSON.stringify({ success: true, message: '已退出登录' }), { status: 200, headers });
};

export const OPTIONS: APIRoute = async () => {
  return new Response(null, { status: 204, headers: corsHeaders });
};
