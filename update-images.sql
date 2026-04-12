-- 更新商品圖片為關鍵字相關圖片（loremflickr.com）
-- 格式：https://loremflickr.com/800/800/keyword1,keyword2/all

-- 分類1：廚房用品
UPDATE products SET
  image_url = 'https://loremflickr.com/800/800/steamer,pot,kitchen/all',
  images = '["https://loremflickr.com/800/800/steamer,pot,kitchen/all","https://loremflickr.com/800/800/stainless,kitchen/all","https://loremflickr.com/800/800/cooking,pot/all"]'
WHERE slug = 'stainless-steamer';

UPDATE products SET
  image_url = 'https://loremflickr.com/800/800/silicone,utensils,kitchen/all',
  images = '["https://loremflickr.com/800/800/silicone,utensils,kitchen/all","https://loremflickr.com/800/800/cooking,spatula/all","https://loremflickr.com/800/800/kitchen,tools/all"]'
WHERE slug = 'silicone-kitchen-set';

UPDATE products SET
  image_url = 'https://loremflickr.com/800/800/cutting,board,bamboo/all',
  images = '["https://loremflickr.com/800/800/cutting,board,bamboo/all","https://loremflickr.com/800/800/bamboo,wood,kitchen/all","https://loremflickr.com/800/800/chopping,board/all"]'
WHERE slug = 'bamboo-cutting-board';

UPDATE products SET
  image_url = 'https://loremflickr.com/800/800/glass,container,food/all',
  images = '["https://loremflickr.com/800/800/glass,container,food/all","https://loremflickr.com/800/800/glass,storage,kitchen/all","https://loremflickr.com/800/800/food,container/all"]'
WHERE slug = 'glass-storage-set';

UPDATE products SET
  image_url = 'https://loremflickr.com/800/800/knife,kitchen,blade/all',
  images = '["https://loremflickr.com/800/800/knife,kitchen,blade/all","https://loremflickr.com/800/800/chef,knife,set/all","https://loremflickr.com/800/800/kitchen,cutlery/all"]'
WHERE slug = 'ceramic-knife-set';

UPDATE products SET
  image_url = 'https://loremflickr.com/800/800/spice,rack,kitchen/all',
  images = '["https://loremflickr.com/800/800/spice,rack,kitchen/all","https://loremflickr.com/800/800/seasoning,jar/all","https://loremflickr.com/800/800/spices,cooking/all"]'
WHERE slug = 'seasoning-rack-set';

UPDATE products SET
  image_url = 'https://loremflickr.com/800/800/oven,gloves,kitchen/all',
  images = '["https://loremflickr.com/800/800/oven,gloves,kitchen/all","https://loremflickr.com/800/800/baking,gloves/all","https://loremflickr.com/800/800/kitchen,protection/all"]'
WHERE slug = 'silicone-oven-gloves';

UPDATE products SET
  image_url = 'https://loremflickr.com/800/800/vegetable,slicer,kitchen/all',
  images = '["https://loremflickr.com/800/800/vegetable,slicer,kitchen/all","https://loremflickr.com/800/800/grater,kitchen/all","https://loremflickr.com/800/800/vegetables,cutting/all"]'
WHERE slug = 'vegetable-slicer';

-- 分類2：收納整理
UPDATE products SET
  image_url = 'https://loremflickr.com/800/800/storage,box,organizer/all',
  images = '["https://loremflickr.com/800/800/storage,box,organizer/all","https://loremflickr.com/800/800/clothes,storage/all","https://loremflickr.com/800/800/folding,box/all"]'
WHERE slug = 'folding-storage-box';

UPDATE products SET
  image_url = 'https://loremflickr.com/800/800/shoe,box,clear/all',
  images = '["https://loremflickr.com/800/800/shoe,box,clear/all","https://loremflickr.com/800/800/shoes,storage,plastic/all","https://loremflickr.com/800/800/shoe,organizer/all"]'
WHERE slug = 'transparent-shoe-box';

UPDATE products SET
  image_url = 'https://loremflickr.com/800/800/drawer,organizer,compartment/all',
  images = '["https://loremflickr.com/800/800/drawer,organizer,compartment/all","https://loremflickr.com/800/800/desk,organizer/all","https://loremflickr.com/800/800/storage,divider/all"]'
WHERE slug = 'drawer-organizer-set';

UPDATE products SET
  image_url = 'https://loremflickr.com/800/800/vacuum,bag,clothes/all',
  images = '["https://loremflickr.com/800/800/vacuum,bag,clothes/all","https://loremflickr.com/800/800/compression,bag/all","https://loremflickr.com/800/800/storage,vacuum/all"]'
WHERE slug = 'vacuum-storage-bag';

UPDATE products SET
  image_url = 'https://loremflickr.com/800/800/sponge,cleaning,kitchen/all',
  images = '["https://loremflickr.com/800/800/sponge,cleaning,kitchen/all","https://loremflickr.com/800/800/dish,sponge/all","https://loremflickr.com/800/800/cleaning,scrubber/all"]'
WHERE slug = 'bamboo-charcoal-sponge';

UPDATE products SET
  image_url = 'https://loremflickr.com/800/800/mop,cleaning,floor/all',
  images = '["https://loremflickr.com/800/800/mop,cleaning,floor/all","https://loremflickr.com/800/800/spin,mop/all","https://loremflickr.com/800/800/floor,cleaning/all"]'
WHERE slug = 'spin-mop-set';

UPDATE products SET
  image_url = 'https://loremflickr.com/800/800/dish,cloth,cleaning/all',
  images = '["https://loremflickr.com/800/800/dish,cloth,cleaning/all","https://loremflickr.com/800/800/kitchen,cloth/all","https://loremflickr.com/800/800/washing,cloth/all"]'
WHERE slug = 'nano-dish-cloth';

UPDATE products SET
  image_url = 'https://loremflickr.com/800/800/wall,shelf,storage/all',
  images = '["https://loremflickr.com/800/800/wall,shelf,storage/all","https://loremflickr.com/800/800/rack,organizer/all","https://loremflickr.com/800/800/wall,mount,storage/all"]'
WHERE slug = 'wall-storage-rack';

-- 分類3：衛浴用品
UPDATE products SET
  image_url = 'https://loremflickr.com/800/800/bath,mat,bathroom/all',
  images = '["https://loremflickr.com/800/800/bath,mat,bathroom/all","https://loremflickr.com/800/800/bathroom,floor,mat/all","https://loremflickr.com/800/800/bath,rug/all"]'
WHERE slug = 'diatomite-bath-mat';

UPDATE products SET
  image_url = 'https://loremflickr.com/800/800/bathroom,shelf,stainless/all',
  images = '["https://loremflickr.com/800/800/bathroom,shelf,stainless/all","https://loremflickr.com/800/800/shower,shelf/all","https://loremflickr.com/800/800/bathroom,rack/all"]'
WHERE slug = 'stainless-bathroom-shelf';

UPDATE products SET
  image_url = 'https://loremflickr.com/800/800/facial,towel,cotton/all',
  images = '["https://loremflickr.com/800/800/facial,towel,cotton/all","https://loremflickr.com/800/800/face,cloth,soft/all","https://loremflickr.com/800/800/cotton,wipes/all"]'
WHERE slug = 'cotton-face-towel';

UPDATE products SET
  image_url = 'https://loremflickr.com/800/800/shower,head,bathroom/all',
  images = '["https://loremflickr.com/800/800/shower,head,bathroom/all","https://loremflickr.com/800/800/shower,water/all","https://loremflickr.com/800/800/shower,nozzle/all"]'
WHERE slug = 'shower-head-set';

UPDATE products SET
  image_url = 'https://loremflickr.com/800/800/toilet,brush,bathroom/all',
  images = '["https://loremflickr.com/800/800/toilet,brush,bathroom/all","https://loremflickr.com/800/800/bathroom,cleaning/all","https://loremflickr.com/800/800/toilet,clean/all"]'
WHERE slug = 'toilet-brush-set';

UPDATE products SET
  image_url = 'https://loremflickr.com/800/800/toothbrush,holder,bathroom/all',
  images = '["https://loremflickr.com/800/800/toothbrush,holder,bathroom/all","https://loremflickr.com/800/800/bathroom,organizer/all","https://loremflickr.com/800/800/dental,care/all"]'
WHERE slug = 'toothbrush-holder';

UPDATE products SET
  image_url = 'https://loremflickr.com/800/800/towel,cotton,soft/all',
  images = '["https://loremflickr.com/800/800/towel,cotton,soft/all","https://loremflickr.com/800/800/bath,towel/all","https://loremflickr.com/800/800/towel,white/all"]'
WHERE slug = 'cotton-towel-set';

-- 分類4：餐廚
UPDATE products SET
  image_url = 'https://loremflickr.com/800/800/ceramic,tableware,plate/all',
  images = '["https://loremflickr.com/800/800/ceramic,tableware,plate/all","https://loremflickr.com/800/800/dishes,bowl,nordic/all","https://loremflickr.com/800/800/porcelain,tableware/all"]'
WHERE slug = 'ceramic-tableware-set';

UPDATE products SET
  image_url = 'https://loremflickr.com/800/800/thermos,tumbler,stainless/all',
  images = '["https://loremflickr.com/800/800/thermos,tumbler,stainless/all","https://loremflickr.com/800/800/insulated,bottle/all","https://loremflickr.com/800/800/water,bottle/all"]'
WHERE slug = 'insulated-cup-500ml';

UPDATE products SET
  image_url = 'https://loremflickr.com/800/800/glass,cup,drinking/all',
  images = '["https://loremflickr.com/800/800/glass,cup,drinking/all","https://loremflickr.com/800/800/glass,water,cup/all","https://loremflickr.com/800/800/drinking,glass/all"]'
WHERE slug = 'glass-cup-set';

UPDATE products SET
  image_url = 'https://loremflickr.com/800/800/placemat,bamboo,table/all',
  images = '["https://loremflickr.com/800/800/placemat,bamboo,table/all","https://loremflickr.com/800/800/table,mat,natural/all","https://loremflickr.com/800/800/bamboo,coaster/all"]'
WHERE slug = 'bamboo-placemat';

UPDATE products SET
  image_url = 'https://loremflickr.com/800/800/children,tableware,colorful/all',
  images = '["https://loremflickr.com/800/800/children,tableware,colorful/all","https://loremflickr.com/800/800/kids,plate,bowl/all","https://loremflickr.com/800/800/baby,feeding,dish/all"]'
WHERE slug = 'kids-tableware-set';

UPDATE products SET
  image_url = 'https://loremflickr.com/800/800/tablecloth,linen,dining/all',
  images = '["https://loremflickr.com/800/800/tablecloth,linen,dining/all","https://loremflickr.com/800/800/table,cloth,fabric/all","https://loremflickr.com/800/800/dining,table,cloth/all"]'
WHERE slug = 'linen-tablecloth';

UPDATE products SET
  image_url = 'https://loremflickr.com/800/800/cutlery,silverware,stainless/all',
  images = '["https://loremflickr.com/800/800/cutlery,silverware,stainless/all","https://loremflickr.com/800/800/spoon,fork,chopsticks/all","https://loremflickr.com/800/800/flatware,dining/all"]'
WHERE slug = 'stainless-cutlery-set';

-- 分類5：家居裝飾
UPDATE products SET
  image_url = 'https://loremflickr.com/800/800/vase,ceramic,flower/all',
  images = '["https://loremflickr.com/800/800/vase,ceramic,flower/all","https://loremflickr.com/800/800/nordic,vase,decor/all","https://loremflickr.com/800/800/pottery,vase/all"]'
WHERE slug = 'nordic-ceramic-vase';

UPDATE products SET
  image_url = 'https://loremflickr.com/800/800/plant,green,pot/all',
  images = '["https://loremflickr.com/800/800/plant,green,pot/all","https://loremflickr.com/800/800/artificial,plant,decor/all","https://loremflickr.com/800/800/indoor,plant/all"]'
WHERE slug = 'artificial-plant-set';

UPDATE products SET
  image_url = 'https://loremflickr.com/800/800/night,light,lamp/all',
  images = '["https://loremflickr.com/800/800/night,light,lamp/all","https://loremflickr.com/800/800/led,light,warm/all","https://loremflickr.com/800/800/bedside,lamp/all"]'
WHERE slug = 'led-night-light';

UPDATE products SET
  image_url = 'https://loremflickr.com/800/800/candle,aromatherapy,soy/all',
  images = '["https://loremflickr.com/800/800/candle,aromatherapy,soy/all","https://loremflickr.com/800/800/scented,candle/all","https://loremflickr.com/800/800/candle,gift/all"]'
WHERE slug = 'soy-candle-gift-box';

UPDATE products SET
  image_url = 'https://loremflickr.com/800/800/photo,frame,wood/all',
  images = '["https://loremflickr.com/800/800/photo,frame,wood/all","https://loremflickr.com/800/800/picture,frame,wooden/all","https://loremflickr.com/800/800/frame,decoration/all"]'
WHERE slug = 'wooden-photo-frame';

UPDATE products SET
  image_url = 'https://loremflickr.com/800/800/pillow,cover,linen/all',
  images = '["https://loremflickr.com/800/800/pillow,cover,linen/all","https://loremflickr.com/800/800/cushion,cover,fabric/all","https://loremflickr.com/800/800/sofa,pillow/all"]'
WHERE slug = 'linen-pillow-cover';

UPDATE products SET
  image_url = 'https://loremflickr.com/800/800/wall,clock,nordic/all',
  images = '["https://loremflickr.com/800/800/wall,clock,nordic/all","https://loremflickr.com/800/800/clock,minimalist/all","https://loremflickr.com/800/800/modern,wall,clock/all"]'
WHERE slug = 'nordic-wall-clock';

-- 分類6：床上用品
UPDATE products SET
  image_url = 'https://loremflickr.com/800/800/bedding,cotton,bedroom/all',
  images = '["https://loremflickr.com/800/800/bedding,cotton,bedroom/all","https://loremflickr.com/800/800/bed,sheets,white/all","https://loremflickr.com/800/800/bedroom,linen/all"]'
WHERE slug = 'cotton-bedding-set';

UPDATE products SET
  image_url = 'https://loremflickr.com/800/800/pillow,memory,foam/all',
  images = '["https://loremflickr.com/800/800/pillow,memory,foam/all","https://loremflickr.com/800/800/sleeping,pillow/all","https://loremflickr.com/800/800/pillow,bed/all"]'
WHERE slug = 'memory-foam-pillow';

UPDATE products SET
  image_url = 'https://loremflickr.com/800/800/quilt,blanket,summer/all',
  images = '["https://loremflickr.com/800/800/quilt,blanket,summer/all","https://loremflickr.com/800/800/light,blanket,bedroom/all","https://loremflickr.com/800/800/comforter,bed/all"]'
WHERE slug = 'summer-quilt';

UPDATE products SET
  image_url = 'https://loremflickr.com/800/800/bed,sheet,fitted/all',
  images = '["https://loremflickr.com/800/800/bed,sheet,fitted/all","https://loremflickr.com/800/800/mattress,cover/all","https://loremflickr.com/800/800/bed,protector/all"]'
WHERE slug = 'anti-mite-bed-sheet';

UPDATE products SET
  image_url = 'https://loremflickr.com/800/800/pillow,down,soft/all',
  images = '["https://loremflickr.com/800/800/pillow,down,soft/all","https://loremflickr.com/800/800/goose,down,pillow/all","https://loremflickr.com/800/800/fluffy,pillow/all"]'
WHERE slug = 'down-pillow-single';

-- 分類7：日用百貨
UPDATE products SET
  image_url = 'https://loremflickr.com/800/800/power,strip,outlet/all',
  images = '["https://loremflickr.com/800/800/power,strip,outlet/all","https://loremflickr.com/800/800/electrical,strip/all","https://loremflickr.com/800/800/extension,cord/all"]'
WHERE slug = 'power-strip-3m';

UPDATE products SET
  image_url = 'https://loremflickr.com/800/800/mosquito,repellent,home/all',
  images = '["https://loremflickr.com/800/800/mosquito,repellent,home/all","https://loremflickr.com/800/800/insect,repellent/all","https://loremflickr.com/800/800/mosquito,liquid/all"]'
WHERE slug = 'mosquito-liquid-set';

UPDATE products SET
  image_url = 'https://loremflickr.com/800/800/air,freshener,fragrance/all',
  images = '["https://loremflickr.com/800/800/air,freshener,fragrance/all","https://loremflickr.com/800/800/room,spray,scent/all","https://loremflickr.com/800/800/car,freshener/all"]'
WHERE slug = 'air-freshener-set';

UPDATE products SET
  image_url = 'https://loremflickr.com/800/800/desiccant,silica,gel/all',
  images = '["https://loremflickr.com/800/800/desiccant,silica,gel/all","https://loremflickr.com/800/800/humidity,absorber/all","https://loremflickr.com/800/800/moisture,packet/all"]'
WHERE slug = 'silica-gel-desiccant';

UPDATE products SET
  image_url = 'https://loremflickr.com/800/800/gloves,disposable,rubber/all',
  images = '["https://loremflickr.com/800/800/gloves,disposable,rubber/all","https://loremflickr.com/800/800/latex,gloves/all","https://loremflickr.com/800/800/protective,gloves/all"]'
WHERE slug = 'disposable-gloves';

UPDATE products SET
  image_url = 'https://loremflickr.com/800/800/trash,bag,garbage/all',
  images = '["https://loremflickr.com/800/800/trash,bag,garbage/all","https://loremflickr.com/800/800/garbage,bag,black/all","https://loremflickr.com/800/800/waste,bag/all"]'
WHERE slug = 'garbage-bag-set';

-- 分類8：兒童家居
UPDATE products SET
  image_url = 'https://loremflickr.com/800/800/baby,chair,cushion/all',
  images = '["https://loremflickr.com/800/800/baby,chair,cushion/all","https://loremflickr.com/800/800/children,seat,pad/all","https://loremflickr.com/800/800/infant,highchair/all"]'
WHERE slug = 'kids-chair-cushion';

UPDATE products SET
  image_url = 'https://loremflickr.com/800/800/baby,bath,tub/all',
  images = '["https://loremflickr.com/800/800/baby,bath,tub/all","https://loremflickr.com/800/800/infant,bathtub/all","https://loremflickr.com/800/800/baby,bathing/all"]'
WHERE slug = 'baby-bath-tub';
