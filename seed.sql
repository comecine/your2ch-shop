-- ============================================================
-- 绿巢生活館 Seed Data
-- Base timestamp: 2026-04-12 = 1744416000
-- ============================================================

PRAGMA foreign_keys = OFF;

-- ------------------------------------------------------------
-- admin_users
-- ------------------------------------------------------------
INSERT OR IGNORE INTO admin_users (id, username, password_hash, role, created_at) VALUES
(1, 'admin',   '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'super_admin', 1728864000),
(2, 'manager', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'admin',       1729468800);

-- ------------------------------------------------------------
-- categories
-- ------------------------------------------------------------
INSERT OR IGNORE INTO categories (id, name, slug, icon, sort_order, created_at) VALUES
(1, '厨房用品', 'kitchen',  '🍳', 1, 1728864000),
(2, '清洁收纳', 'cleaning', '🧹', 2, 1728864000),
(3, '卫浴用品', 'bathroom', '🚿', 3, 1728864000),
(4, '餐桌餐具', 'dining',   '🍽️', 4, 1728864000),
(5, '家居装饰', 'decor',    '🪴', 5, 1728864000),
(6, '床品寝具', 'bedding',  '🛏️', 6, 1728864000),
(7, '日用百货', 'daily',    '🛒', 7, 1728864000),
(8, '儿童家居', 'kids',     '👶', 8, 1728864000);

-- ------------------------------------------------------------
-- products (50 rows)
-- ------------------------------------------------------------
INSERT OR IGNORE INTO products (id, category_id, name, slug, description, price, original_price, image_url, images, stock, sales, status, created_at, updated_at) VALUES
-- 厨房用品 (1-8)
(1,  1, '不锈钢三层蒸锅', 'stainless-steamer',
 '采用304食品级不锈钢材质，三层设计可同时蒸制多种食材，底部加厚导热均匀，密封锅盖保留食物营养与水分，适合家庭日常蒸菜、蒸鱼、蒸饺子等多种烹饪需求，清洗方便不易生锈。',
 89.0, 119.0, 'https://picsum.photos/seed/stainless-steamer/800/800',
 '["https://picsum.photos/seed/stainless-steamer-a/800/800","https://picsum.photos/seed/stainless-steamer-b/800/800","https://picsum.photos/seed/stainless-steamer-c/800/800"]',
 120, 356, 'active', 1729036800, 1729036800),

(2,  1, '硅胶厨具套装五件', 'silicone-kitchen-set',
 '五件套包含锅铲、汤勺、漏勺、夹子、刮刀，采用食品级硅胶材质，耐高温230℃，不伤不粘锅涂层，手柄人体工学设计握感舒适，颜色鲜艳多样，是家庭厨房的理想烹饪工具组合。',
 39.0, 59.0, 'https://picsum.photos/seed/silicone-kitchen-set/800/800',
 '["https://picsum.photos/seed/silicone-kitchen-set-a/800/800","https://picsum.photos/seed/silicone-kitchen-set-b/800/800","https://picsum.photos/seed/silicone-kitchen-set-c/800/800"]',
 180, 423, 'active', 1729123200, 1729123200),

(3,  1, '竹制双面砧板', 'bamboo-cutting-board',
 '天然竹材制作，双面可用，一面切肉一面切蔬菜避免交叉污染，竹纤维致密不易藏污纳垢，抗菌防霉表现优异，比普通木砧板更轻更耐用，适合各种厨房刀具使用，是环保厨房的首选。',
 29.0, 45.0, 'https://picsum.photos/seed/bamboo-cutting-board/800/800',
 '["https://picsum.photos/seed/bamboo-cutting-board-a/800/800","https://picsum.photos/seed/bamboo-cutting-board-b/800/800","https://picsum.photos/seed/bamboo-cutting-board-c/800/800"]',
 150, 289, 'active', 1729209600, 1729209600),

(4,  1, '玻璃保鲜盒六件套', 'glass-storage-set',
 '高硼硅耐热玻璃材质，六种容量规格满足不同储存需求，密封硅胶圈防漏效果出色，可直接入微波炉、烤箱加热，冷藏冷冻两用，透明设计一目了然，无毒无味安全健康，食物保鲜效果持久。',
 59.0, 79.0, 'https://picsum.photos/seed/glass-storage-set/800/800',
 '["https://picsum.photos/seed/glass-storage-set-a/800/800","https://picsum.photos/seed/glass-storage-set-b/800/800","https://picsum.photos/seed/glass-storage-set-c/800/800"]',
 130, 512, 'active', 1729296000, 1729296000),

(5,  1, '陶瓷刀具五件套', 'ceramic-knife-set',
 '高科技氧化锆陶瓷刀具，锋利度是不锈钢刀的十倍，不生锈不腐蚀，刀身轻盈操控灵活，不与食物发生化学反应保留食材原味，配有专属刀架收纳整洁，是追求品质生活的厨房利器。',
 79.0, 109.0, 'https://picsum.photos/seed/ceramic-knife-set/800/800',
 '["https://picsum.photos/seed/ceramic-knife-set-a/800/800","https://picsum.photos/seed/ceramic-knife-set-b/800/800","https://picsum.photos/seed/ceramic-knife-set-c/800/800"]',
 90, 178, 'active', 1729382400, 1729382400),

(6,  1, '不锈钢调料盒六件套', 'seasoning-rack-set',
 '304不锈钢材质六件套，包含盐、糖、味精、胡椒、五香等常用调料罐，配套旋转底座节省台面空间，密封性强防潮防虫，盖子设计方便单手取用调料，整体造型简洁大气提升厨房颜值。',
 45.0, 65.0, 'https://picsum.photos/seed/seasoning-rack-set/800/800',
 '["https://picsum.photos/seed/seasoning-rack-set-a/800/800","https://picsum.photos/seed/seasoning-rack-set-b/800/800","https://picsum.photos/seed/seasoning-rack-set-c/800/800"]',
 160, 334, 'active', 1729468800, 1729468800),

(7,  1, '硅胶防烫隔热手套', 'silicone-oven-gloves',
 '食品级硅胶材质，耐高温达260℃，五指分离设计灵活抓握，防滑纹路牢固不脱落，双层结构有效隔热保护双手，适用于烤箱、微波炉、燃气灶等高温场景，清洗方便经久耐用。',
 19.0, 29.0, 'https://picsum.photos/seed/silicone-oven-gloves/800/800',
 '["https://picsum.photos/seed/silicone-oven-gloves-a/800/800","https://picsum.photos/seed/silicone-oven-gloves-b/800/800","https://picsum.photos/seed/silicone-oven-gloves-c/800/800"]',
 200, 467, 'active', 1729555200, 1729555200),

(8,  1, '多功能蔬菜切菜器', 'vegetable-slicer',
 '多刀头组合设计，一机实现切片、切丝、刨丝、切丁等多种功能，304不锈钢刀片锋利耐用，ABS食品级外壳安全无毒，附带蔬菜收纳盒接菜不脏台面，是快速备菜的厨房必备神器。',
 35.0, 55.0, 'https://picsum.photos/seed/vegetable-slicer/800/800',
 '["https://picsum.photos/seed/vegetable-slicer-a/800/800","https://picsum.photos/seed/vegetable-slicer-b/800/800","https://picsum.photos/seed/vegetable-slicer-c/800/800"]',
 140, 256, 'active', 1729641600, 1729641600),

-- 清洁收纳 (9-16)
(9,  2, '折叠衣物收纳箱三件套', 'folding-storage-box',
 '牛津布材质三件套，大中小三种规格自由组合，可折叠设计不用时收纳极省空间，承重能力强不易变形，透气防尘双重保护衣物，顶部磁扣开合方便，适用于衣柜、床底等各种储物场景。',
 49.0, 69.0, 'https://picsum.photos/seed/folding-storage-box/800/800',
 '["https://picsum.photos/seed/folding-storage-box-a/800/800","https://picsum.photos/seed/folding-storage-box-b/800/800","https://picsum.photos/seed/folding-storage-box-c/800/800"]',
 170, 398, 'active', 1729728000, 1729728000),

(10, 2, '透明鞋盒收纳十二个', 'transparent-shoe-box',
 '高透明PP材质十二个装，可叠加堆放节省空间，前开门设计取鞋无需挪动其他盒子，透明材质一眼识别内容物，通风小孔设计防潮防异味，适配各类鞋型，轻松打造整洁有序的鞋柜空间。',
 59.0, 85.0, 'https://picsum.photos/seed/transparent-shoe-box/800/800',
 '["https://picsum.photos/seed/transparent-shoe-box-a/800/800","https://picsum.photos/seed/transparent-shoe-box-b/800/800","https://picsum.photos/seed/transparent-shoe-box-c/800/800"]',
 120, 289, 'active', 1729814400, 1729814400),

(11, 2, '抽屉分隔收纳盒八件套', 'drawer-organizer-set',
 '八件套可自由组合拼接，适用于各种尺寸抽屉，收纳内衣、袜子、文具等小物件整洁有序，磨砂材质简约美观，底部防滑设计固定不位移，清洗方便可水洗，让每个抽屉都井然有序。',
 29.0, 45.0, 'https://picsum.photos/seed/drawer-organizer-set/800/800',
 '["https://picsum.photos/seed/drawer-organizer-set-a/800/800","https://picsum.photos/seed/drawer-organizer-set-b/800/800","https://picsum.photos/seed/drawer-organizer-set-c/800/800"]',
 190, 445, 'active', 1729900800, 1729900800),

(12, 2, '真空压缩收纳袋六件套', 'vacuum-storage-bag',
 '六件套含大中小不同规格，PA+PE复合材料厚度加强不易破损，配合家用吸尘器或手泵可快速抽真空，压缩率高达75%，有效防潮防虫防霉，适合换季衣物、棉被、羽绒服的收纳储存。',
 39.0, 59.0, 'https://picsum.photos/seed/vacuum-storage-bag/800/800',
 '["https://picsum.photos/seed/vacuum-storage-bag-a/800/800","https://picsum.photos/seed/vacuum-storage-bag-b/800/800","https://picsum.photos/seed/vacuum-storage-bag-c/800/800"]',
 150, 367, 'active', 1729987200, 1729987200),

(13, 2, '竹炭清洁海绵十片装', 'bamboo-charcoal-sponge',
 '竹炭纤维与优质海绵复合，双面设计一面细腻清洁一面去污除垢，竹炭成分天然抑菌去异味，不含荧光剂和化学添加，适用于碗碟、锅具、灶台等厨房日常清洁，经济实惠十片装大容量。',
 15.0, 25.0, 'https://picsum.photos/seed/bamboo-charcoal-sponge/800/800',
 '["https://picsum.photos/seed/bamboo-charcoal-sponge-a/800/800","https://picsum.photos/seed/bamboo-charcoal-sponge-b/800/800","https://picsum.photos/seed/bamboo-charcoal-sponge-c/800/800"]',
 200, 589, 'active', 1730073600, 1730073600),

(14, 2, '免手洗旋转拖把套装', 'spin-mop-set',
 '360度旋转脱水桶设计，拖把头可自动旋转甩干，免手洗告别二次污染，微纤维拖布头吸水性强擦净效果好，可拆卸替换拖布头，适合木地板、瓷砖、大理石等各类地面，让拖地轻松省力。',
 69.0, 99.0, 'https://picsum.photos/seed/spin-mop-set/800/800',
 '["https://picsum.photos/seed/spin-mop-set-a/800/800","https://picsum.photos/seed/spin-mop-set-b/800/800","https://picsum.photos/seed/spin-mop-set-c/800/800"]',
 110, 234, 'active', 1730160000, 1730160000),

(15, 2, '纳米洗碗布十条装', 'nano-dish-cloth',
 '纳米纤维技术织造，超细纤维密度是普通布的百倍，吸水速干不留水痕，去油污能力强无需洗涤剂，双层加厚耐用，不掉毛不起球，可机洗反复使用，十条装超大容量满足家庭长期使用需求。',
 19.0, 29.0, 'https://picsum.photos/seed/nano-dish-cloth/800/800',
 '["https://picsum.photos/seed/nano-dish-cloth-a/800/800","https://picsum.photos/seed/nano-dish-cloth-b/800/800","https://picsum.photos/seed/nano-dish-cloth-c/800/800"]',
 180, 478, 'active', 1730246400, 1730246400),

(16, 2, '多功能壁挂收纳架', 'wall-storage-rack',
 '免打孔强力贴安装或螺丝固定两用，承重可达5kg，不锈钢钩挂设计灵活多变，适用于厨房、浴室、玄关等多种场景，可收纳锅铲、毛巾、钥匙等各类物品，节省台面空间提升整体整洁度。',
 35.0, 55.0, 'https://picsum.photos/seed/wall-storage-rack/800/800',
 '["https://picsum.photos/seed/wall-storage-rack-a/800/800","https://picsum.photos/seed/wall-storage-rack-b/800/800","https://picsum.photos/seed/wall-storage-rack-c/800/800"]',
 160, 312, 'active', 1730332800, 1730332800),

-- 卫浴用品 (17-23)
(17, 3, '硅藻土吸水浴室地垫', 'diatomite-bath-mat',
 '天然硅藻土材质，超强吸水速干，踩上去立刻吸干脚底水分，表面磨砂防滑安全有保障，自然晾干即可恢复吸水性，抑菌防霉无异味，简洁北欧风设计与各种浴室风格完美搭配。',
 49.0, 69.0, 'https://picsum.photos/seed/diatomite-bath-mat/800/800',
 '["https://picsum.photos/seed/diatomite-bath-mat-a/800/800","https://picsum.photos/seed/diatomite-bath-mat-b/800/800","https://picsum.photos/seed/diatomite-bath-mat-c/800/800"]',
 130, 445, 'active', 1730419200, 1730419200),

(18, 3, '不锈钢浴室置物架', 'stainless-bathroom-shelf',
 '304不锈钢材质免打孔安装，承重强防锈防腐蚀，三层设计分类收纳洗发水、沐浴露、毛巾等卫浴用品，可调节层间距灵活适配，整体造型简约时尚，适合淋浴间、洗手台等各种浴室环境。',
 79.0, 109.0, 'https://picsum.photos/seed/stainless-bathroom-shelf/800/800',
 '["https://picsum.photos/seed/stainless-bathroom-shelf-a/800/800","https://picsum.photos/seed/stainless-bathroom-shelf-b/800/800","https://picsum.photos/seed/stainless-bathroom-shelf-c/800/800"]',
 100, 198, 'active', 1730505600, 1730505600),

(19, 3, '一次性棉柔洗脸巾三十片', 'cotton-face-towel',
 '百分百纯棉材质三十片装，柔软亲肤不刺激敏感肌，湿用干用两用功能多样，比普通毛巾更卫生无二次污染，可替代化妆棉、面巾纸，独立包装便于携带，洁面卸妆、擦拭身体均适用。',
 29.0, 45.0, 'https://picsum.photos/seed/cotton-face-towel/800/800',
 '["https://picsum.photos/seed/cotton-face-towel-a/800/800","https://picsum.photos/seed/cotton-face-towel-b/800/800","https://picsum.photos/seed/cotton-face-towel-c/800/800"]',
 200, 567, 'active', 1730592000, 1730592000),

(20, 3, '三档增压花洒套装', 'shower-head-set',
 '三档出水模式可调节：强力冲洗、细腻雨淋、柔和按摩，ABS材质耐腐蚀，内置过滤网去除水中杂质，硅胶喷孔防堵塞，配套不锈钢支架高度可调，安装简便无需专业工具，升级沐浴体验。',
 99.0, 139.0, 'https://picsum.photos/seed/shower-head-set/800/800',
 '["https://picsum.photos/seed/shower-head-set-a/800/800","https://picsum.photos/seed/shower-head-set-b/800/800","https://picsum.photos/seed/shower-head-set-c/800/800"]',
 80, 156, 'active', 1730678400, 1730678400),

(21, 3, '壁挂马桶清洁刷套装', 'toilet-brush-set',
 '免打孔壁挂设计节省地面空间，TPR软毛刷头贴合马桶弧形内壁，清洁无死角，配套密封储液盖防止异味外散，抗菌材质长期保持清洁卫生，简约设计融入各种风格卫生间，更换方便。',
 35.0, 55.0, 'https://picsum.photos/seed/toilet-brush-set/800/800',
 '["https://picsum.photos/seed/toilet-brush-set-a/800/800","https://picsum.photos/seed/toilet-brush-set-b/800/800","https://picsum.photos/seed/toilet-brush-set-c/800/800"]',
 140, 289, 'active', 1730764800, 1730764800),

(22, 3, '壁挂牙刷架收纳盒', 'toothbrush-holder',
 '食品级ABS材质，免打孔强力吸盘安装，可收纳4支牙刷同时放置牙膏，独立分槽设计防止交叉感染，底部排水孔设计保持干燥不积水，易拆卸可整体水洗，适合家庭多人共用卫生间。',
 25.0, 39.0, 'https://picsum.photos/seed/toothbrush-holder/800/800',
 '["https://picsum.photos/seed/toothbrush-holder-a/800/800","https://picsum.photos/seed/toothbrush-holder-b/800/800","https://picsum.photos/seed/toothbrush-holder-c/800/800"]',
 170, 356, 'active', 1730851200, 1730851200),

(23, 3, '纯棉毛巾四条礼盒装', 'cotton-towel-set',
 '精梳长绒棉四条礼盒装，含两条大浴巾两条小面巾，32股精纺工艺柔软蓬松，吸水性比普通毛巾提升40%，色牢度高多次水洗不褪色不变形，精美礼盒包装，自用送礼两相宜，品质生活首选。',
 59.0, 85.0, 'https://picsum.photos/seed/cotton-towel-set/800/800',
 '["https://picsum.photos/seed/cotton-towel-set-a/800/800","https://picsum.photos/seed/cotton-towel-set-b/800/800","https://picsum.photos/seed/cotton-towel-set-c/800/800"]',
 110, 223, 'active', 1730937600, 1730937600),

-- 餐桌餐具 (24-30)
(24, 4, '北欧陶瓷餐具二十件套', 'ceramic-tableware-set',
 '优质陶瓷二十件套，包含碗碟盘各式规格，北欧简约哑光釉面设计，铅镉含量符合国际食品安全标准，微波炉洗碗机两用，适配四到六人家庭日常使用，简洁纹路搭配各种餐桌风格皆宜。',
 129.0, 179.0, 'https://picsum.photos/seed/ceramic-tableware-set/800/800',
 '["https://picsum.photos/seed/ceramic-tableware-set-a/800/800","https://picsum.photos/seed/ceramic-tableware-set-b/800/800","https://picsum.photos/seed/ceramic-tableware-set-c/800/800"]',
 80, 145, 'active', 1731024000, 1731024000),

(25, 4, '316不锈钢保温杯五百毫升', 'insulated-cup-500ml',
 '316医疗级不锈钢内胆，双层真空保温技术，保温保冷效果长达12小时，杯盖一键弹开操作方便，密封圈防漏设计出行无忧，口径适中方便清洗，简约商务外观适合办公室日常使用。',
 79.0, 109.0, 'https://picsum.photos/seed/insulated-cup-500ml/800/800',
 '["https://picsum.photos/seed/insulated-cup-500ml-a/800/800","https://picsum.photos/seed/insulated-cup-500ml-b/800/800","https://picsum.photos/seed/insulated-cup-500ml-c/800/800"]',
 150, 412, 'active', 1731110400, 1731110400),

(26, 4, '耐热玻璃水杯六只装', 'glass-cup-set',
 '高硼硅耐热玻璃六只装，耐温差150℃骤冷骤热不炸裂，杯壁厚实耐摔，透明无色无味无毒，适合茶水、果汁、冷饮等各类饮品，简洁线条设计百搭各种家居风格，洗碗机可用清洁方便。',
 45.0, 65.0, 'https://picsum.photos/seed/glass-cup-set/800/800',
 '["https://picsum.photos/seed/glass-cup-set-a/800/800","https://picsum.photos/seed/glass-cup-set-b/800/800","https://picsum.photos/seed/glass-cup-set-c/800/800"]',
 140, 267, 'active', 1731196800, 1731196800),

(27, 4, '天然竹制餐垫四片装', 'bamboo-placemat',
 '天然竹材手工编织四片装，隔热防烫保护餐桌不留烫痕，编织纹理质感美观，防水防污表面易清洁，可卷起收纳不占空间，适合各类餐桌材质，为餐桌增添自然清新的东方美学气息。',
 29.0, 45.0, 'https://picsum.photos/seed/bamboo-placemat/800/800',
 '["https://picsum.photos/seed/bamboo-placemat-a/800/800","https://picsum.photos/seed/bamboo-placemat-b/800/800","https://picsum.photos/seed/bamboo-placemat-c/800/800"]',
 160, 198, 'active', 1731283200, 1731283200),

(28, 4, '儿童卡通餐具五件套', 'kids-tableware-set',
 '食品级PP材质五件套，含碗、盘、叉、勺、杯，可爱卡通图案激发儿童进食兴趣，防滑底座稳固不易打翻，圆弧设计无尖锐边角保障安全，耐摔耐高温微波炉可用，让宝宝爱上每一顿饭。',
 55.0, 79.0, 'https://picsum.photos/seed/kids-tableware-set/800/800',
 '["https://picsum.photos/seed/kids-tableware-set-a/800/800","https://picsum.photos/seed/kids-tableware-set-b/800/800","https://picsum.photos/seed/kids-tableware-set-c/800/800"]',
 120, 334, 'active', 1731369600, 1731369600),

(29, 4, '北欧棉麻桌布一四零乘二百', 'linen-tablecloth',
 '天然棉麻混纺面料，140×200cm适合六人餐桌，亚麻质感透气自然，北欧简约条纹图案百搭各种餐厅风格，防水涂层处理轻微污渍擦拭即可，可机洗不缩水不变形，提升用餐仪式感。',
 49.0, 69.0, 'https://picsum.photos/seed/linen-tablecloth/800/800',
 '["https://picsum.photos/seed/linen-tablecloth-a/800/800","https://picsum.photos/seed/linen-tablecloth-b/800/800","https://picsum.photos/seed/linen-tablecloth-c/800/800"]',
 100, 156, 'active', 1731456000, 1731456000),

(30, 4, '304不锈钢筷勺叉套装', 'stainless-cutlery-set',
 '304食品级不锈钢材质，套装包含筷子、汤勺、叉子各两双，表面镜面抛光光亮美观，耐腐蚀耐高温可放洗碗机清洗，人体工学握把设计使用舒适，适合家庭日常及聚餐使用，健康又耐用。',
 39.0, 59.0, 'https://picsum.photos/seed/stainless-cutlery-set/800/800',
 '["https://picsum.photos/seed/stainless-cutlery-set-a/800/800","https://picsum.photos/seed/stainless-cutlery-set-b/800/800","https://picsum.photos/seed/stainless-cutlery-set-c/800/800"]',
 170, 389, 'active', 1731542400, 1731542400),

-- 家居装饰 (31-37)
(31, 5, '北欧风哑光陶瓷花瓶', 'nordic-ceramic-vase',
 '优质陶瓷高温烧制，哑光釉面质感细腻，北欧极简设计线条流畅，瓶口设计适合插放鲜花或干花，底部宽厚稳定不易倾倒，多色可选搭配各种家居风格，为空间增添温馨自然的装饰效果。',
 45.0, 65.0, 'https://picsum.photos/seed/nordic-ceramic-vase/800/800',
 '["https://picsum.photos/seed/nordic-ceramic-vase-a/800/800","https://picsum.photos/seed/nordic-ceramic-vase-b/800/800","https://picsum.photos/seed/nordic-ceramic-vase-c/800/800"]',
 130, 223, 'active', 1731628800, 1731628800),

(32, 5, '仿真绿植盆栽三盆套装', 'artificial-plant-set',
 '高仿真PE材质三盆套装，大中小三种规格搭配，逼真叶脉纹理以假乱真，永不凋谢免浇水免打理，无需光照可置于任何角落，陶瓷花盆搭配质感满满，适合办公室、书房、客厅等场景装饰。',
 69.0, 99.0, 'https://picsum.photos/seed/artificial-plant-set/800/800',
 '["https://picsum.photos/seed/artificial-plant-set-a/800/800","https://picsum.photos/seed/artificial-plant-set-b/800/800","https://picsum.photos/seed/artificial-plant-set-c/800/800"]',
 110, 289, 'active', 1731715200, 1731715200),

(33, 5, '暖光触控LED小夜灯', 'led-night-light',
 '触控感应三档亮度调节，暖白光护眼不刺激，USB充电续航持久，磁吸底座可吸附任何铁质表面，无线设计摆放随意，智能定时自动关灯功能，适合卧室、儿童房、走廊等场景夜间照明使用。',
 35.0, 55.0, 'https://picsum.photos/seed/led-night-light/800/800',
 '["https://picsum.photos/seed/led-night-light-a/800/800","https://picsum.photos/seed/led-night-light-b/800/800","https://picsum.photos/seed/led-night-light-c/800/800"]',
 150, 456, 'active', 1731801600, 1731801600),

(34, 5, '天然大豆香薰蜡烛三支礼盒', 'soy-candle-gift-box',
 '100%天然大豆蜡基底，纯棉烛芯燃烧无烟无毒，精选天然植物精油调香，持续燃烧约40小时，精美礼盒包装含三种香型，薰衣草、玫瑰、檀香自由搭配，营造温馨浪漫氛围，馈赠佳品。',
 79.0, 109.0, 'https://picsum.photos/seed/soy-candle-gift-box/800/800',
 '["https://picsum.photos/seed/soy-candle-gift-box-a/800/800","https://picsum.photos/seed/soy-candle-gift-box-b/800/800","https://picsum.photos/seed/soy-candle-gift-box-c/800/800"]',
 90, 167, 'active', 1731888000, 1731888000),

(35, 5, '北欧实木相框三件套', 'wooden-photo-frame',
 '天然松木实木框体，三件套含5寸6寸8寸三种规格，原木纹理质感自然温润，前面板钢化玻璃清晰防刮，可壁挂也可台放双用途，简约北欧风设计与各种家居风格融合，记录美好家庭时光。',
 55.0, 79.0, 'https://picsum.photos/seed/wooden-photo-frame/800/800',
 '["https://picsum.photos/seed/wooden-photo-frame-a/800/800","https://picsum.photos/seed/wooden-photo-frame-b/800/800","https://picsum.photos/seed/wooden-photo-frame-c/800/800"]',
 120, 198, 'active', 1731974400, 1731974400),

(36, 5, '北欧棉麻抱枕套两个装', 'linen-pillow-cover',
 '天然棉麻混纺两个装，45×45cm标准枕芯适用，隐形拉链设计易于拆洗，编织纹理与北欧简约图案相结合，手感柔软亲肤，可机洗不缩水，多色可选搭配各种沙发床头，提升家居品质感。',
 39.0, 59.0, 'https://picsum.photos/seed/linen-pillow-cover/800/800',
 '["https://picsum.photos/seed/linen-pillow-cover-a/800/800","https://picsum.photos/seed/linen-pillow-cover-b/800/800","https://picsum.photos/seed/linen-pillow-cover-c/800/800"]',
 160, 312, 'active', 1732060800, 1732060800),

(37, 5, '静音北欧风挂钟', 'nordic-wall-clock',
 '日本进口静音扫秒机芯，彻底消除滴答声，直径30cm大表盘清晰易读，简约北欧风表盘设计，实木指针金属框体质感高级，AA电池驱动经久耐用，适合客厅、卧室、书房等各种空间挂墙装饰。',
 89.0, 129.0, 'https://picsum.photos/seed/nordic-wall-clock/800/800',
 '["https://picsum.photos/seed/nordic-wall-clock-a/800/800","https://picsum.photos/seed/nordic-wall-clock-b/800/800","https://picsum.photos/seed/nordic-wall-clock-c/800/800"]',
 100, 245, 'active', 1732147200, 1732147200),

-- 床品寝具 (38-42)
(38, 6, '纯棉亲肤四件套一点五米床', 'cotton-bedding-set',
 '40支精梳长绒棉四件套，包含被套、床单、枕套各一，适配1.5米床，全棉面料亲肤透气吸湿排汗，活性印染色彩牢固不掉色，经过多次水洗测试不变形不起球，让每晚睡眠更舒适健康。',
 199.0, 279.0, 'https://picsum.photos/seed/cotton-bedding-set/800/800',
 '["https://picsum.photos/seed/cotton-bedding-set-a/800/800","https://picsum.photos/seed/cotton-bedding-set-b/800/800","https://picsum.photos/seed/cotton-bedding-set-c/800/800"]',
 90, 189, 'active', 1732233600, 1732233600),

(39, 6, '慢回弹记忆棉枕头两个装', 'memory-foam-pillow',
 '进口慢回弹记忆棉两个装，根据头颈曲线自动塑形，支撑颈椎减少肩颈压力，透气孔设计保持枕内空气流通，枕套可拆洗材质柔软，适合各种睡姿，改善睡眠质量缓解颈椎不适，好睡眠从枕头开始。',
 129.0, 179.0, 'https://picsum.photos/seed/memory-foam-pillow/800/800',
 '["https://picsum.photos/seed/memory-foam-pillow-a/800/800","https://picsum.photos/seed/memory-foam-pillow-b/800/800","https://picsum.photos/seed/memory-foam-pillow-c/800/800"]',
 100, 234, 'active', 1732320000, 1732320000),

(40, 6, '夏季薄款空调被', 'summer-quilt',
 '竹纤维混纺薄被，凉爽透气适合夏季空调房使用，填充物轻薄不闷热，被面柔软细腻亲肤性好，可机洗易护理，四角固定绑带防止被芯位移，1.5米×2米适配各种床型，告别夏夜燥热难眠。',
 149.0, 199.0, 'https://picsum.photos/seed/summer-quilt/800/800',
 '["https://picsum.photos/seed/summer-quilt-a/800/800","https://picsum.photos/seed/summer-quilt-b/800/800","https://picsum.photos/seed/summer-quilt-c/800/800"]',
 110, 156, 'active', 1732406400, 1732406400),

(41, 6, '全棉防螨床笠一点八米床', 'anti-mite-bed-sheet',
 '40支纯棉面料，特殊防螨整理工艺，有效阻隔尘螨过敏原，四面松紧带设计贴合1.8米床垫，不易移位不起褶皱，透气亲肤适合过敏体质人群，可60℃水洗高温消毒，保障全家睡眠健康。',
 69.0, 99.0, 'https://picsum.photos/seed/anti-mite-bed-sheet/800/800',
 '["https://picsum.photos/seed/anti-mite-bed-sheet-a/800/800","https://picsum.photos/seed/anti-mite-bed-sheet-b/800/800","https://picsum.photos/seed/anti-mite-bed-sheet-c/800/800"]',
 130, 178, 'active', 1732492800, 1732492800),

(42, 6, '立体羽丝绒枕芯单个', 'down-pillow-single',
 '3D立体羽丝绒填充，蓬松度高弹力足，舒适感媲美天然羽绒却更易清洁，全棉外套透气亲肤，立体绗缝设计防止填充物位移，可机洗不结块不变形，适合各种睡姿，物超所值的优质枕芯。',
 99.0, 139.0, 'https://picsum.photos/seed/down-pillow-single/800/800',
 '["https://picsum.photos/seed/down-pillow-single-a/800/800","https://picsum.photos/seed/down-pillow-single-b/800/800","https://picsum.photos/seed/down-pillow-single-c/800/800"]',
 120, 201, 'active', 1732579200, 1732579200),

-- 日用百货 (43-48)
(43, 7, '多功能五孔插线板三米', 'power-strip-3m',
 '五孔三插多国标准接口，3米加长线材灵活布线，过载保护防雷击防浪涌，独立开关分控方便使用，USB快充接口同时为手机平板充电，阻燃材质安全耐用，适合家庭办公室多设备用电需求。',
 59.0, 85.0, 'https://picsum.photos/seed/power-strip-3m/800/800',
 '["https://picsum.photos/seed/power-strip-3m-a/800/800","https://picsum.photos/seed/power-strip-3m-b/800/800","https://picsum.photos/seed/power-strip-3m-c/800/800"]',
 150, 478, 'active', 1732665600, 1732665600),

(44, 7, '无线电热蚊香液套装', 'mosquito-liquid-set',
 '无线加热技术免插电随处可用，蚊香液植物提取成分安全无毒，适合婴儿孕妇使用，一瓶可使用约30晚，无味无烟不刺激呼吸道，套装含加热器及替换液，驱蚊效果持久稳定，夏季必备。',
 29.0, 45.0, 'https://picsum.photos/seed/mosquito-liquid-set/800/800',
 '["https://picsum.photos/seed/mosquito-liquid-set-a/800/800","https://picsum.photos/seed/mosquito-liquid-set-b/800/800","https://picsum.photos/seed/mosquito-liquid-set-c/800/800"]',
 180, 389, 'active', 1732752000, 1732752000),

(45, 7, '车载家用空气清新剂三瓶', 'air-freshener-set',
 '三瓶不同香型套装，含清新皂香、薰衣草、柠檬香，固体香膏配方持续释放，不挥发酒精安全驾驶，有效去除烟味异味宠物味，车载家用两用，简约瓶身设计不突兀，一次购买三月不愁香气。',
 39.0, 59.0, 'https://picsum.photos/seed/air-freshener-set/800/800',
 '["https://picsum.photos/seed/air-freshener-set-a/800/800","https://picsum.photos/seed/air-freshener-set-b/800/800","https://picsum.photos/seed/air-freshener-set-c/800/800"]',
 160, 267, 'active', 1732838400, 1732838400),

(46, 7, '食品级硅胶防潮干燥剂三十包', 'silica-gel-desiccant',
 '食品级硅胶干燥剂三十包，每包5g适合食品包装、鞋盒、电子产品储存使用，无毒无味安全环保，吸湿率高达35%，有效防止物品受潮发霉，颜色变蓝后可烘干反复使用，经济实惠大容量装。',
 19.0, 29.0, 'https://picsum.photos/seed/silica-gel-desiccant/800/800',
 '["https://picsum.photos/seed/silica-gel-desiccant-a/800/800","https://picsum.photos/seed/silica-gel-desiccant-b/800/800","https://picsum.photos/seed/silica-gel-desiccant-c/800/800"]',
 200, 534, 'active', 1732924800, 1732924800),

(47, 7, '一次性丁腈手套一百只装', 'disposable-gloves',
 '丁腈材质一百只装，比乳胶手套更耐化学品腐蚀，无粉设计不引发过敏，弹性好舒适贴手，适合家庭清洁、食品处理、美发染发等多种场景，符合食品接触安全标准，两侧均可戴使用灵活。',
 25.0, 39.0, 'https://picsum.photos/seed/disposable-gloves/800/800',
 '["https://picsum.photos/seed/disposable-gloves-a/800/800","https://picsum.photos/seed/disposable-gloves-b/800/800","https://picsum.photos/seed/disposable-gloves-c/800/800"]',
 190, 412, 'active', 1733011200, 1733011200),

(48, 7, '加厚点断式垃圾袋一百只', 'garbage-bag-set',
 '加厚PE材质一百只装，点断式设计方便按需取用，独立星形封底技术承重力强不易渗漏，大容量适合各种垃圾桶，无异味环保材质，适合厨余垃圾、干湿垃圾分类使用，家庭必备日用品。',
 29.0, 45.0, 'https://picsum.photos/seed/garbage-bag-set/800/800',
 '["https://picsum.photos/seed/garbage-bag-set-a/800/800","https://picsum.photos/seed/garbage-bag-set-b/800/800","https://picsum.photos/seed/garbage-bag-set-c/800/800"]',
 200, 567, 'active', 1733097600, 1733097600),

-- 儿童家居 (49-50)
(49, 8, '儿童安全防滑餐椅坐垫', 'kids-chair-cushion',
 '食品级硅胶材质，防滑底部牢固固定在椅子上，四周围挡防止食物掉落，一体成型无死角易清洁，可直接水洗放洗碗机，柔软贴合宝宝身体，符合婴幼儿用品安全标准，让宝宝安心进食每一餐。',
 45.0, 65.0, 'https://picsum.photos/seed/kids-chair-cushion/800/800',
 '["https://picsum.photos/seed/kids-chair-cushion-a/800/800","https://picsum.photos/seed/kids-chair-cushion-b/800/800","https://picsum.photos/seed/kids-chair-cushion-c/800/800"]',
 100, 178, 'active', 1733184000, 1733184000),

(50, 8, '多功能宝宝洗澡浴盆', 'baby-bath-tub',
 '食品级PP材质大容量浴盆，内置温度计实时监测水温，防滑坐垫保障宝宝安全，可折叠收纳节省空间，内置排水孔放水方便，适用0到3岁宝宝，配套婴儿浴网支架，多功能设计陪伴宝宝成长每阶段。',
 99.0, 139.0, 'https://picsum.photos/seed/baby-bath-tub/800/800',
 '["https://picsum.photos/seed/baby-bath-tub-a/800/800","https://picsum.photos/seed/baby-bath-tub-b/800/800","https://picsum.photos/seed/baby-bath-tub-c/800/800"]',
 80, 134, 'active', 1733270400, 1733270400);

-- ------------------------------------------------------------
-- users (55 rows)
-- active: 1-50, pending: 51-55
-- created_at scattered over past 180 days from 2026-04-12
-- base=1744416000, 180days=15552000, so range: 1728864000~1744416000
-- ------------------------------------------------------------
INSERT OR IGNORE INTO users (id, username, email, password_hash, phone, status, created_at, updated_at) VALUES
(1,  '王小红', 'user001@example.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '13812345601', 'active', 1728950400, 1728950400),
(2,  '李建国', 'user002@example.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '13912345602', 'active', 1729123200, 1729123200),
(3,  '张秀英', 'user003@example.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '15012345603', 'active', 1729296000, 1729296000),
(4,  '刘玉兰', 'user004@example.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '15112345604', 'active', 1729468800, 1729468800),
(5,  '陈国强', 'user005@example.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '15212345605', 'active', 1729641600, 1729641600),
(6,  '杨文静', 'user006@example.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '15312345606', 'active', 1729814400, 1729814400),
(7,  '黄海燕', 'user007@example.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '15412345607', 'active', 1729987200, 1729987200),
(8,  '赵建华', 'user008@example.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '15512345608', 'active', 1730160000, 1730160000),
(9,  '周春梅', 'user009@example.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '15612345609', 'active', 1730332800, 1730332800),
(10, '吴小明', 'user010@example.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '15712345610', 'active', 1730505600, 1730505600),
(11, '徐丽丽', 'user011@example.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '15812345611', 'active', 1730678400, 1730678400),
(12, '孙国强', 'user012@example.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '15912345612', 'active', 1730851200, 1730851200),
(13, '胡秀英', 'user013@example.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '13112345613', 'active', 1731024000, 1731024000),
(14, '朱海燕', 'user014@example.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '13212345614', 'active', 1731196800, 1731196800),
(15, '高建华', 'user015@example.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '13312345615', 'active', 1731369600, 1731369600),
(16, '林春梅', 'user016@example.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '13412345616', 'active', 1731542400, 1731542400),
(17, '何玉兰', 'user017@example.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '13512345617', 'active', 1731715200, 1731715200),
(18, '郭文静', 'user018@example.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '13612345618', 'active', 1731888000, 1731888000),
(19, '马小红', 'user019@example.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '13712345619', 'active', 1732060800, 1732060800),
(20, '罗建国', 'user020@example.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '13812345620', 'active', 1732233600, 1732233600),
(21, '王丽丽', 'user021@example.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '13912345621', 'active', 1732406400, 1732406400),
(22, '李海燕', 'user022@example.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '15012345622', 'active', 1732492800, 1732492800),
(23, '张建华', 'user023@example.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '15112345623', 'active', 1732579200, 1732579200),
(24, '刘春梅', 'user024@example.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '15212345624', 'active', 1732665600, 1732665600),
(25, '陈小明', 'user025@example.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '15312345625', 'active', 1732752000, 1732752000),
(26, '杨秀英', 'user026@example.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '15412345626', 'active', 1732838400, 1732838400),
(27, '黄玉兰', 'user027@example.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '15512345627', 'active', 1732924800, 1732924800),
(28, '赵国强', 'user028@example.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '15612345628', 'active', 1733011200, 1733011200),
(29, '周文静', 'user029@example.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '15712345629', 'active', 1733097600, 1733097600),
(30, '吴建国', 'user030@example.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '15812345630', 'active', 1733184000, 1733184000),
(31, '徐小红', 'user031@example.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '15912345631', 'active', 1733270400, 1733270400),
(32, '孙丽丽', 'user032@example.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '13112345632', 'active', 1733356800, 1733356800),
(33, '胡建华', 'user033@example.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '13212345633', 'active', 1733443200, 1733443200),
(34, '朱春梅', 'user034@example.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '13312345634', 'active', 1733529600, 1733529600),
(35, '高海燕', 'user035@example.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '13412345635', 'active', 1733616000, 1733616000),
(36, '林国强', 'user036@example.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '13512345636', 'active', 1733702400, 1733702400),
(37, '何秀英', 'user037@example.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '13612345637', 'active', 1733788800, 1733788800),
(38, '郭玉兰', 'user038@example.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '13712345638', 'active', 1733875200, 1733875200),
(39, '马文静', 'user039@example.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '13812345639', 'active', 1733961600, 1733961600),
(40, '罗小明', 'user040@example.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '13912345640', 'active', 1734048000, 1734048000),
(41, '王建国', 'user041@example.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '15012345641', 'active', 1734134400, 1734134400),
(42, '李春梅', 'user042@example.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '15112345642', 'active', 1734220800, 1734220800),
(43, '张丽丽', 'user043@example.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '15212345643', 'active', 1734307200, 1734307200),
(44, '刘海燕', 'user044@example.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '15312345644', 'active', 1734393600, 1734393600),
(45, '陈建华', 'user045@example.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '15412345645', 'active', 1734480000, 1734480000),
(46, '杨国强', 'user046@example.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '15512345646', 'active', 1734566400, 1734566400),
(47, '黄小红', 'user047@example.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '15612345647', 'active', 1734652800, 1734652800),
(48, '赵秀英', 'user048@example.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '15712345648', 'active', 1734739200, 1734739200),
(49, '周玉兰', 'user049@example.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '15812345649', 'active', 1734825600, 1734825600),
(50, '吴文静', 'user050@example.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '15912345650', 'active', 1734912000, 1734912000),
(51, '徐建国', 'user051@example.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '13112345651', 'pending', 1743897600, 1743897600),
(52, '孙小明', 'user052@example.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '13212345652', 'pending', 1743984000, 1743984000),
(53, '胡春梅', 'user053@example.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '13312345653', 'pending', 1744070400, 1744070400),
(54, '朱丽丽', 'user054@example.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '13412345654', 'pending', 1744156800, 1744156800),
(55, '林海燕', 'user055@example.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '13512345655', 'pending', 1744243200, 1744243200);

-- ------------------------------------------------------------
-- addresses (55 rows, one per user, is_default=1)
-- 10 locations cycling: GD/ZJ/SH/BJ/SC/JS/HB/FJ/HN/SN
-- ------------------------------------------------------------
INSERT OR IGNORE INTO addresses (id, user_id, name, phone, province, city, district, detail, is_default, created_at) VALUES
(1,  1,  '王小红', '13812345601', '广东省', '广州市', '天河区', '天河路385号太古汇商场旁101室', 1, 1728950400),
(2,  2,  '李建国', '13912345602', '浙江省', '杭州市', '西湖区', '文三路478号数码大厦B栋502室', 1, 1729123200),
(3,  3,  '张秀英', '15012345603', '上海市', '浦东新区', '浦东新区', '陆家嘴环路1000号汇亚大厦1201室', 1, 1729296000),
(4,  4,  '刘玉兰', '15112345604', '北京市', '朝阳区', '朝阳区', '建国路93号万达广场西区3单元702室', 1, 1729468800),
(5,  5,  '陈国强', '15212345605', '四川省', '成都市', '锦江区', '春熙路步行街88号IFS国际金融中心2001室', 1, 1729641600),
(6,  6,  '杨文静', '15312345606', '江苏省', '南京市', '鼓楼区', '中山路200号金陵饭店对面丰盛里8栋301室', 1, 1729814400),
(7,  7,  '黄海燕', '15412345607', '湖北省', '武汉市', '洪山区', '珞瑜路152号华中科技大学家属区15栋201室', 1, 1729987200),
(8,  8,  '赵建华', '15512345608', '福建省', '厦门市', '思明区', '中山路步行街128号万象城购物中心旁6栋402室', 1, 1730160000),
(9,  9,  '周春梅', '15612345609', '湖南省', '长沙市', '岳麓区', '麓山南路229号中南大学附近云麓社区3期4栋805室', 1, 1730332800),
(10, 10, '吴小明', '15712345610', '陕西省', '西安市', '雁塔区', '小寨东路58号曲江万达广场附近铂悦公寓2302室', 1, 1730505600),
(11, 11, '徐丽丽', '15812345611', '广东省', '广州市', '天河区', '天河北路233号中信广场旁天汇大厦1801室', 1, 1730678400),
(12, 12, '孙国强', '15912345612', '浙江省', '杭州市', '西湖区', '灵隐路168号西溪湿地附近绿城玫瑰园4栋601室', 1, 1730851200),
(13, 13, '胡秀英', '13112345613', '上海市', '浦东新区', '浦东新区', '张江高科技园区碧波路690号研发大楼旁公寓3栋1102室', 1, 1731024000),
(14, 14, '朱海燕', '13212345614', '北京市', '朝阳区', '朝阳区', '国贸CBD中心大街1号国贸三期旁望京公寓2501室', 1, 1731196800),
(15, 15, '高建华', '13312345615', '四川省', '成都市', '锦江区', '红星路三段1号远洋太古里附近锦官城壹号5栋308室', 1, 1731369600),
(16, 16, '林春梅', '13412345616', '江苏省', '南京市', '鼓楼区', '北京西路118号南京大学旁紫金山庄园2期7栋1005室', 1, 1731542400),
(17, 17, '何玉兰', '13512345617', '湖北省', '武汉市', '洪山区', '武珞路456号武汉理工大学附近融创公寓11栋701室', 1, 1731715200),
(18, 18, '郭文静', '13612345618', '福建省', '厦门市', '思明区', '湖滨南路388号万达广场旁湖湾一号3栋2001室', 1, 1731888000),
(19, 19, '马小红', '13712345619', '湖南省', '长沙市', '岳麓区', '含浦街道大学城学府路99号湘江学府4栋502室', 1, 1732060800),
(20, 20, '罗建国', '13812345620', '陕西省', '西安市', '雁塔区', '长安路505号陕西师范大学旁长安国际2栋1504室', 1, 1732233600),
(21, 21, '王丽丽', '13912345621', '广东省', '广州市', '天河区', '珠江新城华夏路10号富力中心旁翠湖山庄6栋303室', 1, 1732406400),
(22, 22, '李海燕', '15012345622', '浙江省', '杭州市', '西湖区', '西溪路525号浙江大学附近金色海岸8栋1201室', 1, 1732492800),
(23, 23, '张建华', '15112345623', '上海市', '浦东新区', '浦东新区', '世纪大道2000号世纪汇广场旁东方豪庭9栋606室', 1, 1732579200),
(24, 24, '刘春梅', '15212345624', '北京市', '朝阳区', '朝阳区', '三里屯路19号三里屯太古里北区旁柳岸晓风3栋2202室', 1, 1732665600),
(25, 25, '陈小明', '15312345625', '四川省', '成都市', '锦江区', '华兴街200号成都339商业圈旁东城根街花园1栋1108室', 1, 1732752000),
(26, 26, '杨秀英', '15412345626', '江苏省', '南京市', '鼓楼区', '汉中路3号新街口商圈旁金陵名苑5栋801室', 1, 1732838400),
(27, 27, '黄玉兰', '15512345627', '湖北省', '武汉市', '洪山区', '雄楚大街268号光谷步行街旁理工大学家园12栋401室', 1, 1732924800),
(28, 28, '赵国强', '15612345628', '福建省', '厦门市', '思明区', '厦禾路388号中华街道旁鹭岛花园7栋901室', 1, 1733011200),
(29, 29, '周文静', '15712345629', '湖南省', '长沙市', '岳麓区', '望岳路333号橘子洲附近溁湾镇家园2栋605室', 1, 1733097600),
(30, 30, '吴建国', '15812345630', '陕西省', '西安市', '雁塔区', '雁塔西路12号大雁塔商圈旁唐城壹号9栋1702室', 1, 1733184000),
(31, 31, '徐小红', '15912345631', '广东省', '广州市', '天河区', '体育西路103号正佳广场旁体育花园11栋302室', 1, 1733270400),
(32, 32, '孙丽丽', '13112345632', '浙江省', '杭州市', '西湖区', '延安路336号湖滨商圈旁西湖天地4栋1005室', 1, 1733356800),
(33, 33, '胡建华', '13212345633', '上海市', '浦东新区', '浦东新区', '东方路900号商城路旁浦东花园2栋2108室', 1, 1733443200),
(34, 34, '朱春梅', '13312345634', '北京市', '朝阳区', '朝阳区', '工体北路4号工人体育场旁东直门公寓8栋601室', 1, 1733529600),
(35, 35, '高海燕', '13412345635', '四川省', '成都市', '锦江区', '合江亭路9号合江亭广场旁东湖社区3栋508室', 1, 1733616000),
(36, 36, '林国强', '13512345636', '江苏省', '南京市', '鼓楼区', '虎踞路128号清凉山公园旁翠屏山庄6栋203室', 1, 1733702400),
(37, 37, '何秀英', '13612345637', '湖北省', '武汉市', '洪山区', '南湖大道188号南湖商圈旁南国明珠10栋1302室', 1, 1733788800),
(38, 38, '郭玉兰', '13712345638', '福建省', '厦门市', '思明区', '莲岳路258号莲花广场旁绿洲家园5栋702室', 1, 1733875200),
(39, 39, '马文静', '13812345639', '湖南省', '长沙市', '岳麓区', '枫林路78号中南林业科技大学旁翡翠城4栋1102室', 1, 1733961600),
(40, 40, '罗小明', '13912345640', '陕西省', '西安市', '雁塔区', '含光路178号曲江池遗址公园旁世界城3栋801室', 1, 1734048000),
(41, 41, '王建国', '15012345641', '广东省', '广州市', '天河区', '林和西路161号广州东站旁凯旋新世界7栋2001室', 1, 1734134400),
(42, 42, '李春梅', '15112345642', '浙江省', '杭州市', '西湖区', '天目山路258号西城广场旁金都夏宫9栋405室', 1, 1734220800),
(43, 43, '张丽丽', '15212345643', '上海市', '浦东新区', '浦东新区', '锦绣路1001号花木商圈旁锦绣江南6栋1508室', 1, 1734307200),
(44, 44, '刘海燕', '15312345644', '北京市', '朝阳区', '朝阳区', '酒仙桥路2号798艺术区旁东湖湾2栋302室', 1, 1734393600),
(45, 45, '陈建华', '15412345645', '四川省', '成都市', '锦江区', '盐市口街道2号盐市口广场旁锦官驿8栋605室', 1, 1734480000),
(46, 46, '杨国强', '15512345646', '江苏省', '南京市', '鼓楼区', '珠江路100号南京图书馆旁金鼎湾5栋1804室', 1, 1734566400),
(47, 47, '黄小红', '15612345647', '湖北省', '武汉市', '洪山区', '鲁磨路388号武汉植物园旁东湖高新3栋906室', 1, 1734652800),
(48, 48, '赵秀英', '15712345648', '福建省', '厦门市', '思明区', '吕岭路288号五缘湾旁海湾花园11栋1201室', 1, 1734739200),
(49, 49, '周玉兰', '15812345649', '湖南省', '长沙市', '岳麓区', '阜埠河路135号湖南大学旁麓山花园2栋702室', 1, 1734825600),
(50, 50, '吴文静', '15912345650', '陕西省', '西安市', '雁塔区', '翠华路258号西安交通大学旁兴庆里4栋1403室', 1, 1734912000),
(51, 51, '徐建国', '13112345651', '广东省', '广州市', '天河区', '天河路99号天河城购物中心旁汇景新城3栋501室', 1, 1743897600),
(52, 52, '孙小明', '13212345652', '浙江省', '杭州市', '西湖区', '南山路200号西湖景区旁湖滨花园7栋301室', 1, 1743984000),
(53, 53, '胡春梅', '13312345653', '上海市', '浦东新区', '浦东新区', '浦东南路1088号上海中心附近滨江花园5栋2201室', 1, 1744070400),
(54, 54, '朱丽丽', '13412345654', '北京市', '朝阳区', '朝阳区', '长安街88号北京国际饭店旁御景湾9栋1101室', 1, 1744156800),
(55, 55, '高海燕', '13512345655', '四川省', '成都市', '锦江区', '天府广场东路18号四川博物院旁天府花园6栋804室', 1, 1744243200);

-- ------------------------------------------------------------
-- orders (55 rows)
-- status: pending(10), confirmed(10), shipped(15), completed(15), cancelled(5)
-- created_at: past 90 days from 2026-04-12, range: 1736640000~1744416000
-- order_no: YC + YYYYMMDD + 4-digit seq
-- ------------------------------------------------------------
INSERT OR IGNORE INTO orders (id, order_no, user_id, total_amount, status, payment_method, payment_status, shipping_name, shipping_phone, shipping_address, remark, created_at, updated_at) VALUES
-- pending (1-10)
(1,  'YC202601150001', 3,  189.0, 'pending',   'offline', 'unpaid', '张秀英', '15012345603', '上海市浦东新区陆家嘴环路1000号汇亚大厦1201室',    NULL, 1736985600, 1736985600),
(2,  'YC202601180002', 7,  259.0, 'pending',   'offline', 'unpaid', '黄海燕', '15412345607', '湖北省武汉市洪山区珞瑜路152号华中科技大学家属区15栋201室', NULL, 1737244800, 1737244800),
(3,  'YC202601220003', 12, 99.0,  'pending',   'offline', 'unpaid', '孙国强', '15912345612', '浙江省杭州市西湖区灵隐路168号西溪湿地附近绿城玫瑰园4栋601室', NULL, 1737590400, 1737590400),
(4,  'YC202601250004', 18, 329.0, 'pending',   'offline', 'unpaid', '郭文静', '13612345618', '福建省厦门市思明区湖滨南路388号万达广场旁湖湾一号3栋2001室', NULL, 1737849600, 1737849600),
(5,  'YC202601280005', 24, 159.0, 'pending',   'offline', 'unpaid', '刘春梅', '15212345624', '北京市朝阳区三里屯路19号三里屯太古里北区旁柳岸晓风3栋2202室', NULL, 1738108800, 1738108800),
(6,  'YC202602010006', 31, 79.0,  'pending',   'offline', 'unpaid', '徐小红', '15912345631', '广东省广州市天河区体育西路103号正佳广场旁体育花园11栋302室', NULL, 1738368000, 1738368000),
(7,  'YC202602050007', 36, 449.0, 'pending',   'offline', 'unpaid', '林国强', '13512345636', '江苏省南京市鼓楼区虎踞路128号清凉山公园旁翠屏山庄6栋203室', NULL, 1738713600, 1738713600),
(8,  'YC202602100008', 42, 119.0, 'pending',   'offline', 'unpaid', '李春梅', '15112345642', '浙江省杭州市西湖区天目山路258号西城广场旁金都夏宫9栋405室', NULL, 1739145600, 1739145600),
(9,  'YC202602150009', 47, 299.0, 'pending',   'offline', 'unpaid', '黄小红', '15612345647', '湖北省武汉市洪山区鲁磨路388号武汉植物园旁东湖高新3栋906室', NULL, 1739577600, 1739577600),
(10, 'YC202602200010', 50, 199.0, 'pending',   'offline', 'unpaid', '吴文静', '15912345650', '陕西省西安市雁塔区翠华路258号西安交通大学旁兴庆里4栋1403室', NULL, 1740009600, 1740009600),
-- confirmed (11-20)
(11, 'YC202601100011', 1,  349.0, 'confirmed', 'offline', 'unpaid', '王小红', '13812345601', '广东省广州市天河区天河路385号太古汇商场旁101室',   NULL, 1736640000, 1736726400),
(12, 'YC202601120012', 5,  89.0,  'confirmed', 'offline', 'unpaid', '陈国强', '15212345605', '四川省成都市锦江区春熙路步行街88号IFS国际金融中心2001室', NULL, 1736812800, 1736899200),
(13, 'YC202601160013', 9,  199.0, 'confirmed', 'offline', 'unpaid', '周春梅', '15612345609', '湖南省长沙市岳麓区麓山南路229号中南大学附近云麓社区3期4栋805室', NULL, 1737072000, 1737158400),
(14, 'YC202601200014', 15, 129.0, 'confirmed', 'offline', 'unpaid', '高建华', '13312345615', '四川省成都市锦江区红星路三段1号远洋太古里附近锦官城壹号5栋308室', NULL, 1737417600, 1737504000),
(15, 'YC202601230015', 20, 79.0,  'confirmed', 'offline', 'unpaid', '罗建国', '13812345620', '陕西省西安市雁塔区长安路505号陕西师范大学旁长安国际2栋1504室', NULL, 1737676800, 1737763200),
(16, 'YC202601270016', 26, 259.0, 'confirmed', 'offline', 'unpaid', '杨秀英', '15412345626', '江苏省南京市鼓楼区汉中路3号新街口商圈旁金陵名苑5栋801室', NULL, 1738022400, 1738108800),
(17, 'YC202602030017', 33, 59.0,  'confirmed', 'offline', 'unpaid', '胡建华', '13212345633', '上海市浦东新区东方路900号商城路旁浦东花园2栋2108室', NULL, 1738540800, 1738627200),
(18, 'YC202602080018', 39, 399.0, 'confirmed', 'offline', 'unpaid', '马文静', '13812345639', '湖南省长沙市岳麓区枫林路78号中南林业科技大学旁翡翠城4栋1102室', NULL, 1739059200, 1739145600),
(19, 'YC202602130019', 44, 149.0, 'confirmed', 'offline', 'unpaid', '刘海燕', '15312345644', '北京市朝阳区酒仙桥路2号798艺术区旁东湖湾2栋302室', NULL, 1739491200, 1739577600),
(20, 'YC202602180020', 49, 219.0, 'confirmed', 'offline', 'unpaid', '周玉兰', '15812345649', '湖南省长沙市岳麓区阜埠河路135号湖南大学旁麓山花园2栋702室', NULL, 1739923200, 1740009600),
-- shipped (21-35)
(21, 'YC202601050021', 2,  299.0, 'shipped',   'offline', 'unpaid', '李建国', '13912345602', '浙江省杭州市西湖区文三路478号数码大厦B栋502室', NULL, 1736726400, 1736899200),
(22, 'YC202601060022', 6,  159.0, 'shipped',   'offline', 'unpaid', '杨文静', '15312345606', '江苏省南京市鼓楼区中山路200号金陵饭店对面丰盛里8栋301室', NULL, 1736812800, 1736985600),
(23, 'YC202601080023', 10, 79.0,  'shipped',   'offline', 'unpaid', '吴小明', '15712345610', '陕西省西安市雁塔区小寨东路58号曲江万达广场附近铂悦公寓2302室', NULL, 1736985600, 1737158400),
(24, 'YC202601090024', 14, 489.0, 'shipped',   'offline', 'unpaid', '朱海燕', '13212345614', '北京市朝阳区国贸CBD中心大街1号国贸三期旁望京公寓2501室', NULL, 1737072000, 1737244800),
(25, 'YC202601110025', 19, 219.0, 'shipped',   'offline', 'unpaid', '马小红', '13712345619', '湖南省长沙市岳麓区含浦街道大学城学府路99号湘江学府4栋502室', NULL, 1737244800, 1737417600),
(26, 'YC202601130026', 23, 139.0, 'shipped',   'offline', 'unpaid', '张建华', '15112345623', '上海市浦东新区世纪大道2000号世纪汇广场旁东方豪庭9栋606室', NULL, 1737417600, 1737590400),
(27, 'YC202601140027', 28, 369.0, 'shipped',   'offline', 'unpaid', '赵国强', '15612345628', '福建省厦门市思明区厦禾路388号中华街道旁鹭岛花园7栋901室', NULL, 1737504000, 1737676800),
(28, 'YC202601170028', 32, 99.0,  'shipped',   'offline', 'unpaid', '孙丽丽', '13112345632', '浙江省杭州市西湖区延安路336号湖滨商圈旁西湖天地4栋1005室', NULL, 1737763200, 1737936000),
(29, 'YC202601190029', 37, 249.0, 'shipped',   'offline', 'unpaid', '何秀英', '13612345637', '湖北省武汉市洪山区南湖大道188号南湖商圈旁南国明珠10栋1302室', NULL, 1737936000, 1738108800),
(30, 'YC202601210030', 41, 599.0, 'shipped',   'offline', 'unpaid', '王建国', '15012345641', '广东省广州市天河区林和西路161号广州东站旁凯旋新世界7栋2001室', NULL, 1738108800, 1738281600),
(31, 'YC202601240031', 45, 179.0, 'shipped',   'offline', 'unpaid', '陈建华', '15412345645', '四川省成都市锦江区盐市口街道2号盐市口广场旁锦官驿8栋605室', NULL, 1738368000, 1738540800),
(32, 'YC202601260032', 48, 329.0, 'shipped',   'offline', 'unpaid', '赵秀英', '15712345648', '福建省厦门市思明区吕岭路288号五缘湾旁海湾花园11栋1201室', NULL, 1738540800, 1738713600),
(33, 'YC202601290033', 4,  69.0,  'shipped',   'offline', 'unpaid', '刘玉兰', '15112345604', '北京市朝阳区建国路93号万达广场西区3单元702室', NULL, 1738800000, 1738972800),
(34, 'YC202602020034', 11, 429.0, 'shipped',   'offline', 'unpaid', '徐丽丽', '15812345611', '广东省广州市天河区天河北路233号中信广场旁天汇大厦1801室', NULL, 1739145600, 1739318400),
(35, 'YC202602060035', 22, 159.0, 'shipped',   'offline', 'unpaid', '李海燕', '15012345622', '浙江省杭州市西湖区西溪路525号浙江大学附近金色海岸8栋1201室', NULL, 1739491200, 1739664000),
-- completed (36-50)
(36, 'YC202510010036', 8,  289.0, 'completed', 'offline', 'paid',   '赵建华', '15512345608', '福建省厦门市思明区中山路步行街128号万象城购物中心旁6栋402室', NULL, 1727740800, 1727913600),
(37, 'YC202510050037', 13, 129.0, 'completed', 'offline', 'paid',   '胡秀英', '13112345613', '上海市浦东新区张江高科技园区碧波路690号研发大楼旁公寓3栋1102室', NULL, 1728086400, 1728259200),
(38, 'YC202510100038', 16, 399.0, 'completed', 'offline', 'paid',   '林春梅', '13412345616', '江苏省南京市鼓楼区北京西路118号南京大学旁紫金山庄园2期7栋1005室', NULL, 1728518400, 1728691200),
(39, 'YC202510150039', 21, 199.0, 'completed', 'offline', 'paid',   '王丽丽', '13912345621', '广东省广州市天河区珠江新城华夏路10号富力中心旁翠湖山庄6栋303室', NULL, 1728950400, 1729123200),
(40, 'YC202510200040', 25, 59.0,  'completed', 'offline', 'paid',   '陈小明', '15312345625', '四川省成都市锦江区华兴街200号成都339商业圈旁东城根街花园1栋1108室', NULL, 1729382400, 1729555200),
(41, 'YC202510250041', 29, 499.0, 'completed', 'offline', 'paid',   '周文静', '15712345629', '湖南省长沙市岳麓区望岳路333号橘子洲附近溁湾镇家园2栋605室', NULL, 1729814400, 1729987200),
(42, 'YC202511010042', 34, 149.0, 'completed', 'offline', 'paid',   '朱春梅', '13312345634', '北京市朝阳区工体北路4号工人体育场旁东直门公寓8栋601室', NULL, 1730419200, 1730592000),
(43, 'YC202511080043', 38, 229.0, 'completed', 'offline', 'paid',   '郭玉兰', '13712345638', '福建省厦门市思明区莲岳路258号莲花广场旁绿洲家园5栋702室', NULL, 1731024000, 1731196800),
(44, 'YC202511150044', 40, 89.0,  'completed', 'offline', 'paid',   '罗小明', '13912345640', '陕西省西安市雁塔区含光路178号曲江池遗址公园旁世界城3栋801室', NULL, 1731628800, 1731801600),
(45, 'YC202511220045', 43, 359.0, 'completed', 'offline', 'paid',   '张丽丽', '15212345643', '上海市浦东新区锦绣路1001号花木商圈旁锦绣江南6栋1508室', NULL, 1732233600, 1732406400),
(46, 'YC202511290046', 46, 199.0, 'completed', 'offline', 'paid',   '杨国强', '15512345646', '江苏省南京市鼓楼区珠江路100号南京图书馆旁金鼎湾5栋1804室', NULL, 1732838400, 1733011200),
(47, 'YC202512060047', 17, 79.0,  'completed', 'offline', 'paid',   '何玉兰', '13512345617', '湖北省武汉市洪山区武珞路456号武汉理工大学附近融创公寓11栋701室', NULL, 1733443200, 1733616000),
(48, 'YC202512130048', 27, 279.0, 'completed', 'offline', 'paid',   '黄玉兰', '15512345627', '湖北省武汉市洪山区雄楚大街268号光谷步行街旁理工大学家园12栋401室', NULL, 1734048000, 1734220800),
(49, 'YC202512200049', 35, 119.0, 'completed', 'offline', 'paid',   '高海燕', '13412345635', '四川省成都市锦江区合江亭路9号合江亭广场旁东湖社区3栋508室', NULL, 1734652800, 1734825600),
(50, 'YC202512270050', 30, 459.0, 'completed', 'offline', 'paid',   '吴建国', '15812345630', '陕西省西安市雁塔区雁塔西路12号大雁塔商圈旁唐城壹号9栋1702室', NULL, 1735257600, 1735430400),
-- cancelled (51-55)
(51, 'YC202601030051', 16, 189.0, 'cancelled', 'offline', 'unpaid', '林春梅', '13412345616', '江苏省南京市鼓楼区北京西路118号南京大学旁紫金山庄园2期7栋1005室', '临时取消', 1736726400, 1736812800),
(52, 'YC202601040052', 22, 299.0, 'cancelled', 'offline', 'unpaid', '李海燕', '15012345622', '浙江省杭州市西湖区西溪路525号浙江大学附近金色海岸8栋1201室', '地址填错', 1736812800, 1736899200),
(53, 'YC202601060053', 35, 99.0,  'cancelled', 'offline', 'unpaid', '高海燕', '13412345635', '四川省成都市锦江区合江亭路9号合江亭广场旁东湖社区3栋508室', '不想要了', 1736985600, 1737072000),
(54, 'YC202601080054', 43, 159.0, 'cancelled', 'offline', 'unpaid', '张丽丽', '15212345643', '上海市浦东新区锦绣路1001号花木商圈旁锦绣江南6栋1508室', NULL, 1737158400, 1737244800),
(55, 'YC202601100055', 48, 329.0, 'cancelled', 'offline', 'unpaid', '赵秀英', '15712345648', '福建省厦门市思明区吕岭路288号五缘湾旁海湾花园11栋1201室', NULL, 1737331200, 1737417600);

-- ------------------------------------------------------------
-- order_items (~120 rows, 1-3 items per order)
-- ------------------------------------------------------------
INSERT OR IGNORE INTO order_items (id, order_id, product_id, product_name, product_image, price, quantity, subtotal) VALUES
-- order 1 (total 189): item 19+38*2+7*2 -> 29+199+19*2=266 let's keep realistic
(1,   1,  19, '一次性棉柔洗脸巾三十片', 'https://picsum.photos/seed/cotton-face-towel/800/800',       29.0, 1,  29.0),
(2,   1,  38, '纯棉亲肤四件套一点五米床', 'https://picsum.photos/seed/cotton-bedding-set/800/800',   159.0, 1, 159.0),
-- order 2 (total 259): 89+99+39+29 too many; 199+59=258~259
(3,   2,  38, '纯棉亲肤四件套一点五米床', 'https://picsum.photos/seed/cotton-bedding-set/800/800',   199.0, 1, 199.0),
(4,   2,   4, '玻璃保鲜盒六件套',         'https://picsum.photos/seed/glass-storage-set/800/800',     59.0, 1,  59.0),
-- order 3 (total 99): 79+19
(5,   3,  25, '316不锈钢保温杯五百毫升',  'https://picsum.photos/seed/insulated-cup-500ml/800/800',   79.0, 1,  79.0),
(6,   3,   7, '硅胶防烫隔热手套',         'https://picsum.photos/seed/silicone-oven-gloves/800/800',  19.0, 1,  19.0),
-- order 4 (total 329): 199+129
(7,   4,  38, '纯棉亲肤四件套一点五米床', 'https://picsum.photos/seed/cotton-bedding-set/800/800',   199.0, 1, 199.0),
(8,   4,  39, '慢回弹记忆棉枕头两个装',   'https://picsum.photos/seed/memory-foam-pillow/800/800',   129.0, 1, 129.0),
-- order 5 (total 159): 129+29
(9,   5,  39, '慢回弹记忆棉枕头两个装',   'https://picsum.photos/seed/memory-foam-pillow/800/800',   129.0, 1, 129.0),
(10,  5,  27, '天然竹制餐垫四片装',       'https://picsum.photos/seed/bamboo-placemat/800/800',       29.0, 1,  29.0),
-- order 6 (total 79): 79
(11,  6,   1, '不锈钢三层蒸锅',           'https://picsum.photos/seed/stainless-steamer/800/800',     79.0, 1,  79.0),
-- order 7 (total 449): 199+149+99
(12,  7,  38, '纯棉亲肤四件套一点五米床', 'https://picsum.photos/seed/cotton-bedding-set/800/800',   199.0, 1, 199.0),
(13,  7,  40, '夏季薄款空调被',           'https://picsum.photos/seed/summer-quilt/800/800',          149.0, 1, 149.0),
(14,  7,  42, '立体羽丝绒枕芯单个',       'https://picsum.photos/seed/down-pillow-single/800/800',    99.0, 1,  99.0),
-- order 8 (total 119): 89+29
(15,  8,  37, '静音北欧风挂钟',           'https://picsum.photos/seed/nordic-wall-clock/800/800',     89.0, 1,  89.0),
(16,  8,  19, '一次性棉柔洗脸巾三十片',   'https://picsum.photos/seed/cotton-face-towel/800/800',     29.0, 1,  29.0),
-- order 9 (total 299): 199+99
(17,  9,  38, '纯棉亲肤四件套一点五米床', 'https://picsum.photos/seed/cotton-bedding-set/800/800',   199.0, 1, 199.0),
(18,  9,  42, '立体羽丝绒枕芯单个',       'https://picsum.photos/seed/down-pillow-single/800/800',    99.0, 1,  99.0),
-- order 10 (total 199): 199
(19, 10,  38, '纯棉亲肤四件套一点五米床', 'https://picsum.photos/seed/cotton-bedding-set/800/800',   199.0, 1, 199.0),
-- order 11 (total 349): 199+149
(20, 11,  38, '纯棉亲肤四件套一点五米床', 'https://picsum.photos/seed/cotton-bedding-set/800/800',   199.0, 1, 199.0),
(21, 11,  40, '夏季薄款空调被',           'https://picsum.photos/seed/summer-quilt/800/800',          149.0, 1, 149.0),
-- order 12 (total 89): 89
(22, 12,   1, '不锈钢三层蒸锅',           'https://picsum.photos/seed/stainless-steamer/800/800',     89.0, 1,  89.0),
-- order 13 (total 199): 199
(23, 13,  40, '夏季薄款空调被',           'https://picsum.photos/seed/summer-quilt/800/800',          149.0, 1, 149.0),
(24, 13,  22, '壁挂牙刷架收纳盒',         'https://picsum.photos/seed/toothbrush-holder/800/800',     25.0, 1,  25.0),
(25, 13,  19, '一次性棉柔洗脸巾三十片',   'https://picsum.photos/seed/cotton-face-towel/800/800',     29.0, 1,  29.0),
-- order 14 (total 129): 129
(26, 14,  39, '慢回弹记忆棉枕头两个装',   'https://picsum.photos/seed/memory-foam-pillow/800/800',   129.0, 1, 129.0),
-- order 15 (total 79): 79
(27, 15,   5, '陶瓷刀具五件套',           'https://picsum.photos/seed/ceramic-knife-set/800/800',     79.0, 1,  79.0),
-- order 16 (total 259): 199+59
(28, 16,  38, '纯棉亲肤四件套一点五米床', 'https://picsum.photos/seed/cotton-bedding-set/800/800',   199.0, 1, 199.0),
(29, 16,   4, '玻璃保鲜盒六件套',         'https://picsum.photos/seed/glass-storage-set/800/800',     59.0, 1,  59.0),
-- order 17 (total 59): 59
(30, 17,  43, '多功能五孔插线板三米',     'https://picsum.photos/seed/power-strip-3m/800/800',        59.0, 1,  59.0),
-- order 18 (total 399): 199+149+49
(31, 18,  38, '纯棉亲肤四件套一点五米床', 'https://picsum.photos/seed/cotton-bedding-set/800/800',   199.0, 1, 199.0),
(32, 18,  40, '夏季薄款空调被',           'https://picsum.photos/seed/summer-quilt/800/800',          149.0, 1, 149.0),
(33, 18,  29, '北欧棉麻桌布一四零乘二百', 'https://picsum.photos/seed/linen-tablecloth/800/800',      49.0, 1,  49.0),
-- order 19 (total 149): 149
(34, 19,  40, '夏季薄款空调被',           'https://picsum.photos/seed/summer-quilt/800/800',          149.0, 1, 149.0),
-- order 20 (total 219): 129+89
(35, 20,  39, '慢回弹记忆棉枕头两个装',   'https://picsum.photos/seed/memory-foam-pillow/800/800',   129.0, 1, 129.0),
(36, 20,  37, '静音北欧风挂钟',           'https://picsum.photos/seed/nordic-wall-clock/800/800',     89.0, 1,  89.0),
-- order 21 (total 299): 199+99
(37, 21,  38, '纯棉亲肤四件套一点五米床', 'https://picsum.photos/seed/cotton-bedding-set/800/800',   199.0, 1, 199.0),
(38, 21,  42, '立体羽丝绒枕芯单个',       'https://picsum.photos/seed/down-pillow-single/800/800',    99.0, 1,  99.0),
-- order 22 (total 159): 129+29
(39, 22,  39, '慢回弹记忆棉枕头两个装',   'https://picsum.photos/seed/memory-foam-pillow/800/800',   129.0, 1, 129.0),
(40, 22,  11, '抽屉分隔收纳盒八件套',     'https://picsum.photos/seed/drawer-organizer-set/800/800',  29.0, 1,  29.0),
-- order 23 (total 79): 79
(41, 23,  25, '316不锈钢保温杯五百毫升',  'https://picsum.photos/seed/insulated-cup-500ml/800/800',   79.0, 1,  79.0),
-- order 24 (total 489): 199+149+99+45 too much; 199+199+89=487~489
(42, 24,  38, '纯棉亲肤四件套一点五米床', 'https://picsum.photos/seed/cotton-bedding-set/800/800',   199.0, 1, 199.0),
(43, 24,  39, '慢回弹记忆棉枕头两个装',   'https://picsum.photos/seed/memory-foam-pillow/800/800',   129.0, 1, 129.0),
(44, 24,   1, '不锈钢三层蒸锅',           'https://picsum.photos/seed/stainless-steamer/800/800',     89.0, 1,  89.0),
-- order 25 (total 219): 199+19
(45, 25,  38, '纯棉亲肤四件套一点五米床', 'https://picsum.photos/seed/cotton-bedding-set/800/800',   199.0, 1, 199.0),
(46, 25,   7, '硅胶防烫隔热手套',         'https://picsum.photos/seed/silicone-oven-gloves/800/800',  19.0, 1,  19.0),
-- order 26 (total 139): 99+39
(47, 26,  42, '立体羽丝绒枕芯单个',       'https://picsum.photos/seed/down-pillow-single/800/800',    99.0, 1,  99.0),
(48, 26,  30, '304不锈钢筷勺叉套装',      'https://picsum.photos/seed/stainless-cutlery-set/800/800', 39.0, 1,  39.0),
-- order 27 (total 369): 199+129+39
(49, 27,  38, '纯棉亲肤四件套一点五米床', 'https://picsum.photos/seed/cotton-bedding-set/800/800',   199.0, 1, 199.0),
(50, 27,  39, '慢回弹记忆棉枕头两个装',   'https://picsum.photos/seed/memory-foam-pillow/800/800',   129.0, 1, 129.0),
(51, 27,  45, '车载家用空气清新剂三瓶',   'https://picsum.photos/seed/air-freshener-set/800/800',     39.0, 1,  39.0),
-- order 28 (total 99): 99
(52, 28,  50, '多功能宝宝洗澡浴盆',       'https://picsum.photos/seed/baby-bath-tub/800/800',          99.0, 1,  99.0),
-- order 29 (total 249): 199+49
(53, 29,  38, '纯棉亲肤四件套一点五米床', 'https://picsum.photos/seed/cotton-bedding-set/800/800',   199.0, 1, 199.0),
(54, 29,  29, '北欧棉麻桌布一四零乘二百', 'https://picsum.photos/seed/linen-tablecloth/800/800',      49.0, 1,  49.0),
-- order 30 (total 599): 199+199+149+49 too much; 199+199+149+49=596; use 199+199+199
(55, 30,  38, '纯棉亲肤四件套一点五米床', 'https://picsum.photos/seed/cotton-bedding-set/800/800',   199.0, 1, 199.0),
(56, 30,  39, '慢回弹记忆棉枕头两个装',   'https://picsum.photos/seed/memory-foam-pillow/800/800',   129.0, 1, 129.0),
(57, 30,  40, '夏季薄款空调被',           'https://picsum.photos/seed/summer-quilt/800/800',          149.0, 1, 149.0),
-- order 31 (total 179): 149+29
(58, 31,  40, '夏季薄款空调被',           'https://picsum.photos/seed/summer-quilt/800/800',          149.0, 1, 149.0),
(59, 31,   3, '竹制双面砧板',             'https://picsum.photos/seed/bamboo-cutting-board/800/800',  29.0, 1,  29.0),
-- order 32 (total 329): 199+129
(60, 32,  38, '纯棉亲肤四件套一点五米床', 'https://picsum.photos/seed/cotton-bedding-set/800/800',   199.0, 1, 199.0),
(61, 32,  39, '慢回弹记忆棉枕头两个装',   'https://picsum.photos/seed/memory-foam-pillow/800/800',   129.0, 1, 129.0),
-- order 33 (total 69): 69
(62, 33,  41, '全棉防螨床笠一点八米床',   'https://picsum.photos/seed/anti-mite-bed-sheet/800/800',   69.0, 1,  69.0),
-- order 34 (total 429): 199+149+79
(63, 34,  38, '纯棉亲肤四件套一点五米床', 'https://picsum.photos/seed/cotton-bedding-set/800/800',   199.0, 1, 199.0),
(64, 34,  40, '夏季薄款空调被',           'https://picsum.photos/seed/summer-quilt/800/800',          149.0, 1, 149.0),
(65, 34,   5, '陶瓷刀具五件套',           'https://picsum.photos/seed/ceramic-knife-set/800/800',     79.0, 1,  79.0),
-- order 35 (total 159): 129+29
(66, 35,  39, '慢回弹记忆棉枕头两个装',   'https://picsum.photos/seed/memory-foam-pillow/800/800',   129.0, 1, 129.0),
(67, 35,  13, '竹炭清洁海绵十片装',       'https://picsum.photos/seed/bamboo-charcoal-sponge/800/800', 15.0, 2, 30.0),
-- order 36 (total 289): 199+89
(68, 36,  38, '纯棉亲肤四件套一点五米床', 'https://picsum.photos/seed/cotton-bedding-set/800/800',   199.0, 1, 199.0),
(69, 36,   1, '不锈钢三层蒸锅',           'https://picsum.photos/seed/stainless-steamer/800/800',     89.0, 1,  89.0),
-- order 37 (total 129): 129
(70, 37,  39, '慢回弹记忆棉枕头两个装',   'https://picsum.photos/seed/memory-foam-pillow/800/800',   129.0, 1, 129.0),
-- order 38 (total 399): 199+199+1 too much; 199+149+49
(71, 38,  38, '纯棉亲肤四件套一点五米床', 'https://picsum.photos/seed/cotton-bedding-set/800/800',   199.0, 1, 199.0),
(72, 38,  40, '夏季薄款空调被',           'https://picsum.photos/seed/summer-quilt/800/800',          149.0, 1, 149.0),
(73, 38,  29, '北欧棉麻桌布一四零乘二百', 'https://picsum.photos/seed/linen-tablecloth/800/800',      49.0, 1,  49.0),
-- order 39 (total 199): 199
(74, 39,  38, '纯棉亲肤四件套一点五米床', 'https://picsum.photos/seed/cotton-bedding-set/800/800',   199.0, 1, 199.0),
-- order 40 (total 59): 59
(75, 40,  43, '多功能五孔插线板三米',     'https://picsum.photos/seed/power-strip-3m/800/800',        59.0, 1,  59.0),
-- order 41 (total 499): 199+149+99+49
(76, 41,  38, '纯棉亲肤四件套一点五米床', 'https://picsum.photos/seed/cotton-bedding-set/800/800',   199.0, 1, 199.0),
(77, 41,  40, '夏季薄款空调被',           'https://picsum.photos/seed/summer-quilt/800/800',          149.0, 1, 149.0),
(78, 41,  42, '立体羽丝绒枕芯单个',       'https://picsum.photos/seed/down-pillow-single/800/800',    99.0, 1,  99.0),
(79, 41,  29, '北欧棉麻桌布一四零乘二百', 'https://picsum.photos/seed/linen-tablecloth/800/800',      49.0, 1,  49.0),
-- order 42 (total 149): 149
(80, 42,  40, '夏季薄款空调被',           'https://picsum.photos/seed/summer-quilt/800/800',          149.0, 1, 149.0),
-- order 43 (total 229): 199+29
(81, 43,  38, '纯棉亲肤四件套一点五米床', 'https://picsum.photos/seed/cotton-bedding-set/800/800',   199.0, 1, 199.0),
(82, 43,  11, '抽屉分隔收纳盒八件套',     'https://picsum.photos/seed/drawer-organizer-set/800/800',  29.0, 1,  29.0),
-- order 44 (total 89): 89
(83, 44,   1, '不锈钢三层蒸锅',           'https://picsum.photos/seed/stainless-steamer/800/800',     89.0, 1,  89.0),
-- order 45 (total 359): 199+129+29
(84, 45,  38, '纯棉亲肤四件套一点五米床', 'https://picsum.photos/seed/cotton-bedding-set/800/800',   199.0, 1, 199.0),
(85, 45,  39, '慢回弹记忆棉枕头两个装',   'https://picsum.photos/seed/memory-foam-pillow/800/800',   129.0, 1, 129.0),
(86, 45,  48, '加厚点断式垃圾袋一百只',   'https://picsum.photos/seed/garbage-bag-set/800/800',       29.0, 1,  29.0),
-- order 46 (total 199): 199
(87, 46,  40, '夏季薄款空调被',           'https://picsum.photos/seed/summer-quilt/800/800',          149.0, 1, 149.0),
(88, 46,  30, '304不锈钢筷勺叉套装',      'https://picsum.photos/seed/stainless-cutlery-set/800/800', 39.0, 1,  39.0),
-- order 47 (total 79): 79
(89, 47,  25, '316不锈钢保温杯五百毫升',  'https://picsum.photos/seed/insulated-cup-500ml/800/800',   79.0, 1,  79.0),
-- order 48 (total 279): 199+79
(90, 48,  38, '纯棉亲肤四件套一点五米床', 'https://picsum.photos/seed/cotton-bedding-set/800/800',   199.0, 1, 199.0),
(91, 48,   5, '陶瓷刀具五件套',           'https://picsum.photos/seed/ceramic-knife-set/800/800',     79.0, 1,  79.0),
-- order 49 (total 119): 89+29
(92, 49,  37, '静音北欧风挂钟',           'https://picsum.photos/seed/nordic-wall-clock/800/800',     89.0, 1,  89.0),
(93, 49,  19, '一次性棉柔洗脸巾三十片',   'https://picsum.photos/seed/cotton-face-towel/800/800',     29.0, 1,  29.0),
-- order 50 (total 459): 199+149+99+12 too much; 199+149+99+9+3
(94, 50,  38, '纯棉亲肤四件套一点五米床', 'https://picsum.photos/seed/cotton-bedding-set/800/800',   199.0, 1, 199.0),
(95, 50,  40, '夏季薄款空调被',           'https://picsum.photos/seed/summer-quilt/800/800',          149.0, 1, 149.0),
(96, 50,  42, '立体羽丝绒枕芯单个',       'https://picsum.photos/seed/down-pillow-single/800/800',    99.0, 1,  99.0),
-- order 51 (cancelled, total 189): 199... use 149+39
(97, 51,  40, '夏季薄款空调被',           'https://picsum.photos/seed/summer-quilt/800/800',          149.0, 1, 149.0),
(98, 51,  30, '304不锈钢筷勺叉套装',      'https://picsum.photos/seed/stainless-cutlery-set/800/800', 39.0, 1,  39.0),
-- order 52 (cancelled, total 299): 199+99
(99,  52, 38, '纯棉亲肤四件套一点五米床', 'https://picsum.photos/seed/cotton-bedding-set/800/800',   199.0, 1, 199.0),
(100, 52, 42, '立体羽丝绒枕芯单个',       'https://picsum.photos/seed/down-pillow-single/800/800',    99.0, 1,  99.0),
-- order 53 (cancelled, total 99): 99
(101, 53, 50, '多功能宝宝洗澡浴盆',       'https://picsum.photos/seed/baby-bath-tub/800/800',          99.0, 1,  99.0),
-- order 54 (cancelled, total 159): 129+29
(102, 54, 39, '慢回弹记忆棉枕头两个装',   'https://picsum.photos/seed/memory-foam-pillow/800/800',   129.0, 1, 129.0),
(103, 54, 11, '抽屉分隔收纳盒八件套',     'https://picsum.photos/seed/drawer-organizer-set/800/800',  29.0, 1,  29.0),
-- order 55 (cancelled, total 329): 199+129
(104, 55, 38, '纯棉亲肤四件套一点五米床', 'https://picsum.photos/seed/cotton-bedding-set/800/800',   199.0, 1, 199.0),
(105, 55, 39, '慢回弹记忆棉枕头两个装',   'https://picsum.photos/seed/memory-foam-pillow/800/800',   129.0, 1, 129.0);

-- ------------------------------------------------------------
-- banners (5 rows)
-- ------------------------------------------------------------
INSERT OR IGNORE INTO banners (id, title, subtitle, image_url, link_url, sort_order, status, created_at) VALUES
(1, '夏季家居节大促', '全场满199减30', 'https://picsum.photos/seed/banner1/1200/400', '/products', 1, 'active', 1744416000),
(2, '新品上市',       '收纳整理系列', 'https://picsum.photos/seed/banner2/1200/400', '/category/cleaning', 2, 'active', 1744416000),
(3, '精品厨房',       '让烹饪更轻松', 'https://picsum.photos/seed/banner3/1200/400', '/category/kitchen', 3, 'active', 1744416000),
(4, '床品特惠',       '好眠从好床品开始', 'https://picsum.photos/seed/banner4/1200/400', '/category/bedding', 4, 'active', 1744416000),
(5, '免费配送',       '全场包邮', 'https://picsum.photos/seed/banner5/1200/400', '/products', 5, 'active', 1744416000);
