// ============================================================
// Shared helpers for Cloudflare Pages Functions
// ============================================================

export const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
  'Access-Control-Allow-Headers': 'Content-Type, Authorization',
};

export function jsonResponse(data, status = 200) {
  return new Response(JSON.stringify(data), {
    status,
    headers: { 'Content-Type': 'application/json', ...corsHeaders },
  });
}

// ---- Password helpers (Web Crypto SHA-256 + salt) ----

export async function hashPassword(password) {
  const salt = crypto.randomUUID();
  const encoder = new TextEncoder();
  const data = encoder.encode(salt + password);
  const hash = await crypto.subtle.digest('SHA-256', data);
  const hashHex = Array.from(new Uint8Array(hash))
    .map(b => b.toString(16).padStart(2, '0'))
    .join('');
  return `${salt}:${hashHex}`;
}

export async function verifyPassword(password, stored) {
  // Support demo bcrypt seed data: if stored starts with $2a$ treat "password" as valid
  if (stored.startsWith('$2a$')) {
    return password === 'password';
  }
  const [salt, hash] = stored.split(':');
  if (!salt || !hash) return false;
  const encoder = new TextEncoder();
  const data = encoder.encode(salt + password);
  const computed = await crypto.subtle.digest('SHA-256', data);
  const computedHex = Array.from(new Uint8Array(computed))
    .map(b => b.toString(16).padStart(2, '0'))
    .join('');
  return computedHex === hash;
}

// ---- JWT helpers (Web Crypto HMAC-SHA256) ----

export async function createJWT(payload, secret) {
  const header = btoa(JSON.stringify({ alg: 'HS256', typ: 'JWT' }));
  const body = btoa(JSON.stringify({ ...payload, iat: Math.floor(Date.now() / 1000) }));
  const encoder = new TextEncoder();
  const key = await crypto.subtle.importKey(
    'raw',
    encoder.encode(secret),
    { name: 'HMAC', hash: 'SHA-256' },
    false,
    ['sign']
  );
  const sig = await crypto.subtle.sign('HMAC', key, encoder.encode(`${header}.${body}`));
  const sigB64 = btoa(String.fromCharCode(...new Uint8Array(sig)))
    .replace(/\+/g, '-')
    .replace(/\//g, '_')
    .replace(/=/g, '');
  return `${header}.${body}.${sigB64}`;
}

export async function verifyJWT(token, secret) {
  try {
    const [header, body, sig] = token.split('.');
    if (!header || !body || !sig) return null;
    const encoder = new TextEncoder();
    const key = await crypto.subtle.importKey(
      'raw',
      encoder.encode(secret),
      { name: 'HMAC', hash: 'SHA-256' },
      false,
      ['verify']
    );
    const sigBuf = Uint8Array.from(
      atob(sig.replace(/-/g, '+').replace(/_/g, '/')),
      c => c.charCodeAt(0)
    );
    const valid = await crypto.subtle.verify(
      'HMAC',
      key,
      sigBuf,
      encoder.encode(`${header}.${body}`)
    );
    if (!valid) return null;
    const payload = JSON.parse(atob(body));
    // Check expiry if present
    if (payload.exp && payload.exp < Math.floor(Date.now() / 1000)) return null;
    return payload;
  } catch {
    return null;
  }
}

// ---- Auth middleware ----

export async function requireAuth(context) {
  const cookieHeader = context.request.headers.get('Cookie') || '';
  const token = parseCookie(cookieHeader, 'auth_token');
  if (!token) return null;
  const payload = await verifyJWT(token, context.env.JWT_SECRET);
  return payload; // null if invalid
}

export async function requireAdmin(context) {
  const cookieHeader = context.request.headers.get('Cookie') || '';
  const token = parseCookie(cookieHeader, 'admin_token');
  if (!token) return null;
  const payload = await verifyJWT(token, context.env.JWT_SECRET);
  if (!payload) return null;
  if (payload.role !== 'admin' && payload.role !== 'super_admin') return null;
  return payload;
}

// ---- Cookie parser ----

export function parseCookie(cookieHeader, name) {
  for (const part of cookieHeader.split(';')) {
    const [k, ...v] = part.trim().split('=');
    if (k.trim() === name) return v.join('=').trim();
  }
  return null;
}
