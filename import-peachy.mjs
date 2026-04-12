// 將 Peachy 抓取的商品資料匯入 your2ch-shop D1 資料庫
import { readFileSync, writeFileSync } from 'fs';
import { execSync } from 'child_process';

const raw = JSON.parse(readFileSync('/tmp/peachy-raw-list.json', 'utf8'));
const items = raw.salePageList || [];

console.log(`共 ${items.length} 個商品`);

// 取前 50 個，過濾掉缺貨商品
const products = items
  .filter(p => !p.isSoldOut && p.title && p.picUrl)
  .slice(0, 50);

console.log(`有效商品: ${products.length} 個`);

// 產生 slug（用 ID 確保唯一）
function toSlug(id) {
  return `product-${id}`;
}

function fixUrl(url) {
  if (!url) return '';
  return url.startsWith('//') ? 'https:' + url : url;
}

// 分類對應（根據商品名稱關鍵字自動分類）
function guessCategory(title) {
  if (/椅|凳|沙發|桌|床/.test(title)) return 5; // 客廳/臥室
  if (/地板|地墊|地毯/.test(title)) return 2;    // 收納整理
  if (/收納|置物|架|掛/.test(title)) return 2;    // 收納整理
  if (/廚房|鍋|刀|砧板|餐/.test(title)) return 1; // 廚房用品
  if (/浴|衛|牙|毛巾|沐浴/.test(title)) return 3; // 衛浴用品
  if (/燈|鐘|畫|裝飾|花|香/.test(title)) return 5; // 家居裝飾
  if (/床|枕|被|寢|席/.test(title)) return 6;     // 床上用品
  if (/兒童|寶寶|嬰/.test(title)) return 8;       // 兒童家居
  return 7; // 日用百貨（預設）
}

const sqlLines = [];

// 清空舊商品（order_items 先刪，再刪 products，避免外鍵約束）
sqlLines.push('DELETE FROM order_items WHERE product_id <= 50;');
sqlLines.push('DELETE FROM products WHERE id <= 50;');

let id = 1;
for (const p of products) {
  const slug = toSlug(p.salePageId);
  const name = p.title.replace(/'/g, "''").trim();
  const price = p.price || 99;
  const originalPrice = p.suggestPrice > p.price ? p.suggestPrice : Math.round(price * 1.2);
  const imageUrl = fixUrl(p.picUrl);
  const imageList = (p.picList || []).slice(0, 4).map(fixUrl);
  if (imageUrl && !imageList.includes(imageUrl)) imageList.unshift(imageUrl);
  const imagesJson = JSON.stringify(imageList.slice(0, 3)).replace(/'/g, "''");
  const desc = `${name}，精選優質生活好物，品質保證，滿意保障。`.replace(/'/g, "''");
  const stock = Math.floor(Math.random() * 200) + 20;
  const sales = p.sellingQty || Math.floor(Math.random() * 500) + 10;
  const categoryId = guessCategory(p.title);
  const createdAt = Math.floor(Date.now() / 1000) - Math.floor(Math.random() * 86400 * 30);

  sqlLines.push(`INSERT OR IGNORE INTO products (id, category_id, name, slug, description, price, original_price, image_url, images, stock, sales, status, created_at, updated_at) VALUES (${id}, ${categoryId}, '${name}', '${slug}', '${desc}', ${price}, ${originalPrice}, '${imageUrl}', '${imagesJson}', ${stock}, ${sales}, 'active', ${createdAt}, ${createdAt});`);
  id++;
}

const sqlContent = sqlLines.join('\n');
writeFileSync('./peachy-import.sql', sqlContent);
console.log(`生成 peachy-import.sql，共 ${id - 1} 筆商品 + 清理語句`);

// 執行更新
console.log('\n🚀 更新 D1 資料庫...');
try {
  execSync('wrangler d1 execute your2ch-shop-db --remote --file peachy-import.sql', {
    encoding: 'utf8', stdio: 'inherit'
  });
  console.log('✅ 匯入完成！');
} catch (err) {
  console.error('❌ 執行失敗，請手動執行：wrangler d1 execute your2ch-shop-db --remote --file peachy-import.sql');
}
