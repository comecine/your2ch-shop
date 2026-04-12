// 修正 @astrojs/cloudflare 產生的 wrangler.json，移除 Pages 不允許的欄位
import { readFileSync, writeFileSync } from 'fs';

const path = './dist/server/wrangler.json';
const config = JSON.parse(readFileSync(path, 'utf8'));

// Pages 不允許的欄位（Workers 專用）
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

// 移除 SESSION KV（本專案不需要）
if (config.kv_namespaces) {
  config.kv_namespaces = config.kv_namespaces.filter(kv => kv.binding !== 'SESSION');
  if (config.kv_namespaces.length === 0) delete config.kv_namespaces;
}

// 清空空陣列欄位
['durable_objects', 'workflows', 'migrations', 'queues', 'r2_buckets',
 'vectorize', 'hyperdrive', 'services', 'analytics_engine_datasets',
 'dispatch_namespaces', 'mtls_certificates', 'pipelines', 'ratelimits'].forEach(k => {
  const v = config[k];
  if (v && (Array.isArray(v) ? v.length === 0 : Object.values(v).every(x => Array.isArray(x) && x.length === 0))) {
    delete config[k];
  }
});

writeFileSync(path, JSON.stringify(config, null, 2));
console.log('✅ dist/server/wrangler.json patched for Pages deployment');
