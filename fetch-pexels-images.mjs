// 用 Pexels API 抓商品相關圖片，更新 D1 資料庫
import { execSync } from 'child_process';

const API_KEY = process.env.PEXELS_API_KEY;
if (!API_KEY) {
  console.error('❌ 找不到 PEXELS_API_KEY，請先執行：source ~/.zshrc');
  process.exit(1);
}

// 每個商品對應的英文搜尋關鍵字
const products = [
  { slug: 'stainless-steamer',       query: 'stainless steel steamer pot kitchen' },
  { slug: 'silicone-kitchen-set',    query: 'silicone kitchen utensils cooking tools' },
  { slug: 'bamboo-cutting-board',    query: 'bamboo cutting board kitchen' },
  { slug: 'glass-storage-set',       query: 'glass food container storage kitchen' },
  { slug: 'ceramic-knife-set',       query: 'kitchen knife set blade' },
  { slug: 'seasoning-rack-set',      query: 'spice rack seasoning jars kitchen' },
  { slug: 'silicone-oven-gloves',    query: 'oven mitts kitchen gloves baking' },
  { slug: 'vegetable-slicer',        query: 'vegetable slicer grater kitchen tool' },
  { slug: 'folding-storage-box',     query: 'folding storage box clothes organizer' },
  { slug: 'transparent-shoe-box',    query: 'clear shoe box storage plastic' },
  { slug: 'drawer-organizer-set',    query: 'drawer organizer compartment divider' },
  { slug: 'vacuum-storage-bag',      query: 'vacuum storage bag compression clothes' },
  { slug: 'bamboo-charcoal-sponge',  query: 'cleaning sponge kitchen scrubber' },
  { slug: 'spin-mop-set',            query: 'spin mop bucket floor cleaning' },
  { slug: 'nano-dish-cloth',         query: 'dish cloth kitchen cleaning wipe' },
  { slug: 'wall-storage-rack',       query: 'wall mounted storage rack shelf organizer' },
  { slug: 'diatomite-bath-mat',      query: 'bath mat bathroom floor rug' },
  { slug: 'stainless-bathroom-shelf',query: 'bathroom shelf rack stainless steel' },
  { slug: 'cotton-face-towel',       query: 'facial cotton towel soft white' },
  { slug: 'shower-head-set',         query: 'shower head bathroom water spray' },
  { slug: 'toilet-brush-set',        query: 'toilet brush bathroom cleaning holder' },
  { slug: 'toothbrush-holder',       query: 'toothbrush holder bathroom organizer' },
  { slug: 'cotton-towel-set',        query: 'bath towel cotton soft white bathroom' },
  { slug: 'ceramic-tableware-set',   query: 'ceramic tableware plate bowl nordic' },
  { slug: 'insulated-cup-500ml',     query: 'thermos tumbler insulated water bottle stainless' },
  { slug: 'glass-cup-set',           query: 'glass drinking cup clear water' },
  { slug: 'bamboo-placemat',         query: 'bamboo placemat table mat natural' },
  { slug: 'kids-tableware-set',      query: 'children tableware plate bowl colorful' },
  { slug: 'linen-tablecloth',        query: 'linen tablecloth dining table fabric' },
  { slug: 'stainless-cutlery-set',   query: 'cutlery silverware fork spoon stainless' },
  { slug: 'nordic-ceramic-vase',     query: 'ceramic vase flower nordic minimalist' },
  { slug: 'artificial-plant-set',    query: 'artificial plant green pot home decor' },
  { slug: 'led-night-light',         query: 'night light led lamp warm bedroom' },
  { slug: 'soy-candle-gift-box',     query: 'scented candle aromatherapy soy gift' },
  { slug: 'wooden-photo-frame',      query: 'wooden photo frame picture wall decor' },
  { slug: 'linen-pillow-cover',      query: 'pillow cover cushion linen fabric sofa' },
  { slug: 'nordic-wall-clock',       query: 'wall clock minimalist nordic modern' },
  { slug: 'cotton-bedding-set',      query: 'bedding set cotton sheets bedroom white' },
  { slug: 'memory-foam-pillow',      query: 'memory foam pillow sleep bedroom' },
  { slug: 'summer-quilt',            query: 'summer quilt light blanket bedroom' },
  { slug: 'anti-mite-bed-sheet',     query: 'fitted sheet bed cover mattress white' },
  { slug: 'down-pillow-single',      query: 'down pillow fluffy soft white' },
  { slug: 'power-strip-3m',          query: 'power strip extension cord outlet' },
  { slug: 'mosquito-liquid-set',     query: 'mosquito repellent liquid home protection' },
  { slug: 'air-freshener-set',       query: 'air freshener fragrance home scent spray' },
  { slug: 'silica-gel-desiccant',    query: 'silica gel desiccant moisture absorber packet' },
  { slug: 'disposable-gloves',       query: 'disposable gloves rubber latex protection' },
  { slug: 'garbage-bag-set',         query: 'garbage bag trash black waste' },
  { slug: 'kids-chair-cushion',      query: 'baby chair cushion child seat pad' },
  { slug: 'baby-bath-tub',           query: 'baby bath tub infant bathing' },
];

async function searchPexels(query) {
  const url = `https://api.pexels.com/v1/search?query=${encodeURIComponent(query)}&per_page=4&orientation=square`;
  const res = await fetch(url, {
    headers: { Authorization: API_KEY }
  });
  if (!res.ok) throw new Error(`Pexels API error: ${res.status}`);
  const data = await res.json();
  return data.photos || [];
}

function getBestUrl(photo) {
  // 優先用 large2x（800px），fallback 到 large
  return photo.src.large2x || photo.src.large || photo.src.original;
}

async function main() {
  const updates = [];

  for (const product of products) {
    try {
      process.stdout.write(`搜尋: ${product.slug} ... `);
      const photos = await searchPexels(product.query);

      if (photos.length === 0) {
        console.log('⚠️ 無結果，跳過');
        continue;
      }

      const mainUrl = getBestUrl(photos[0]);
      const extraUrls = photos.slice(1, 4).map(p => getBestUrl(p));
      const imagesJson = JSON.stringify([mainUrl, ...extraUrls]).replace(/'/g, "''");
      const mainUrlEscaped = mainUrl.replace(/'/g, "''");

      updates.push(
        `UPDATE products SET image_url = '${mainUrlEscaped}', images = '${imagesJson}' WHERE slug = '${product.slug}';`
      );

      console.log(`✅ ${photos.length} 張圖`);

      // 避免 rate limit（每秒最多 200 requests，這裡適度放慢）
      await new Promise(r => setTimeout(r, 300));
    } catch (err) {
      console.log(`❌ ${err.message}`);
    }
  }

  if (updates.length === 0) {
    console.error('沒有任何更新，結束。');
    process.exit(1);
  }

  // 寫成 SQL 檔案
  const sqlContent = updates.join('\n');
  const fs = await import('fs');
  fs.writeFileSync('./pexels-images.sql', sqlContent);
  console.log(`\n✅ 產生 pexels-images.sql，共 ${updates.length} 筆更新`);

  // 執行 D1 更新
  console.log('\n🚀 更新 D1 資料庫...');
  try {
    const result = execSync(
      'wrangler d1 execute your2ch-shop-db --remote --file pexels-images.sql',
      { encoding: 'utf8', stdio: 'pipe' }
    );
    console.log('✅ D1 更新完成！');
  } catch (err) {
    console.error('❌ D1 更新失敗：', err.message);
    console.log('你可以手動執行：wrangler d1 execute your2ch-shop-db --remote --file pexels-images.sql');
  }
}

main().catch(console.error);
