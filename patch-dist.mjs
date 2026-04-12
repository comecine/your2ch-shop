// 修正 @astrojs/cloudflare Pages SSR 部署結構
// Cloudflare Pages 需要 _worker.js 在靜態資源根目錄
import { readFileSync, writeFileSync, copyFileSync, mkdirSync, readdirSync, statSync } from 'fs';
import { join, relative } from 'path';

// 遞迴複製目錄
function copyDir(src, dest) {
  mkdirSync(dest, { recursive: true });
  for (const entry of readdirSync(src, { withFileTypes: true })) {
    const srcPath = join(src, entry.name);
    const destPath = join(dest, entry.name);
    if (entry.isDirectory()) {
      copyDir(srcPath, destPath);
    } else {
      copyFileSync(srcPath, destPath);
    }
  }
}

// 1. 把 dist/server/chunks/ 複製到 dist/client/chunks/
copyDir('./dist/server/chunks', './dist/client/chunks');
console.log('✅ Copied server chunks to client/');

// 2. 把 dist/server/entry.mjs 複製為 dist/client/_worker.js
copyFileSync('./dist/server/entry.mjs', './dist/client/_worker.js');
console.log('✅ Copied entry.mjs → client/_worker.js');

// 3. 也要複製其他 server 產生的 .mjs 檔（如果有的話）
try {
  const serverFiles = readdirSync('./dist/server').filter(f => f.endsWith('.mjs') && f !== 'entry.mjs');
  for (const f of serverFiles) {
    copyFileSync(`./dist/server/${f}`, `./dist/client/${f}`);
  }
} catch {}

// 4. 修正 dist/server/wrangler.json（備用，部署時讀 wrangler.toml）
const wranglerPath = './dist/server/wrangler.json';
const config = JSON.parse(readFileSync(wranglerPath, 'utf8'));
delete config.assets;
delete config.main;
delete config.rules;
delete config.ai_search_namespaces;
delete config.ai_search;
delete config.vpc_networks;
delete config.triggers;
delete config.jsx_factory;
delete config.jsx_fragment;
delete config.no_bundle;
delete config.logfwdr;
delete config.python_modules;
delete config.unsafe_hello_world;
delete config.worker_loaders;
delete config.vpc_services;
delete config.secrets_store_secrets;
delete config.send_email;
delete config.cloudchamber;
delete config.images;
delete config.dev;
if (config.kv_namespaces) {
  config.kv_namespaces = config.kv_namespaces.filter(kv => kv.binding !== 'SESSION');
  if (config.kv_namespaces.length === 0) delete config.kv_namespaces;
}
// 移除已設為 Pages Secret 的變數（避免衝突）
if (config.vars) {
  delete config.vars.JWT_SECRET;
}
writeFileSync(wranglerPath, JSON.stringify(config, null, 2));

console.log('✅ dist patched — deploy with: wrangler pages deploy dist/client');
