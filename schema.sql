-- ============================================================
-- 绿巢生活館 Cloudflare D1 Database Schema
-- Created: 2026-04-12
-- ============================================================

PRAGMA foreign_keys = ON;

-- ------------------------------------------------------------
-- 1. admin_users - 後台管理員
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS admin_users (
    id           INTEGER PRIMARY KEY AUTOINCREMENT,
    username     TEXT    NOT NULL UNIQUE,
    password_hash TEXT   NOT NULL,
    role         TEXT    NOT NULL DEFAULT 'admin' CHECK (role IN ('super_admin', 'admin')),
    created_at   INTEGER NOT NULL DEFAULT (strftime('%s', 'now'))
);

-- ------------------------------------------------------------
-- 2. users - 前台會員
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS users (
    id                 INTEGER PRIMARY KEY AUTOINCREMENT,
    username           TEXT    NOT NULL UNIQUE,
    email              TEXT    NOT NULL UNIQUE,
    password_hash      TEXT    NOT NULL,
    phone              TEXT,
    avatar             TEXT,
    status             TEXT    NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'active', 'disabled')),
    activation_token   TEXT,
    activation_expires INTEGER,
    created_at         INTEGER NOT NULL DEFAULT (strftime('%s', 'now')),
    updated_at         INTEGER NOT NULL DEFAULT (strftime('%s', 'now'))
);

CREATE INDEX IF NOT EXISTS idx_users_email    ON users(email);
CREATE INDEX IF NOT EXISTS idx_users_status   ON users(status);
CREATE INDEX IF NOT EXISTS idx_users_username ON users(username);

-- ------------------------------------------------------------
-- 3. categories - 商品分類
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS categories (
    id         INTEGER PRIMARY KEY AUTOINCREMENT,
    name       TEXT    NOT NULL,
    slug       TEXT    NOT NULL UNIQUE,
    icon       TEXT,
    sort_order INTEGER NOT NULL DEFAULT 0,
    created_at INTEGER NOT NULL DEFAULT (strftime('%s', 'now'))
);

CREATE INDEX IF NOT EXISTS idx_categories_sort ON categories(sort_order);

-- ------------------------------------------------------------
-- 4. products - 商品
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS products (
    id             INTEGER PRIMARY KEY AUTOINCREMENT,
    category_id    INTEGER NOT NULL REFERENCES categories(id) ON DELETE RESTRICT,
    name           TEXT    NOT NULL,
    slug           TEXT    NOT NULL UNIQUE,
    description    TEXT,
    price          REAL    NOT NULL CHECK (price >= 0),
    original_price REAL    CHECK (original_price >= 0),
    image_url      TEXT,
    images         TEXT,   -- JSON array of image URLs
    stock          INTEGER NOT NULL DEFAULT 0 CHECK (stock >= 0),
    sales          INTEGER NOT NULL DEFAULT 0 CHECK (sales >= 0),
    status         TEXT    NOT NULL DEFAULT 'active' CHECK (status IN ('active', 'inactive')),
    created_at     INTEGER NOT NULL DEFAULT (strftime('%s', 'now')),
    updated_at     INTEGER NOT NULL DEFAULT (strftime('%s', 'now'))
);

CREATE INDEX IF NOT EXISTS idx_products_category ON products(category_id);
CREATE INDEX IF NOT EXISTS idx_products_status   ON products(status);
CREATE INDEX IF NOT EXISTS idx_products_slug     ON products(slug);
CREATE INDEX IF NOT EXISTS idx_products_price    ON products(price);

-- ------------------------------------------------------------
-- 5. cart_items - 購物車
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS cart_items (
    id         INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id    INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    product_id INTEGER NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    quantity   INTEGER NOT NULL DEFAULT 1 CHECK (quantity > 0),
    created_at INTEGER NOT NULL DEFAULT (strftime('%s', 'now')),
    UNIQUE (user_id, product_id)
);

CREATE INDEX IF NOT EXISTS idx_cart_user ON cart_items(user_id);

-- ------------------------------------------------------------
-- 6. addresses - 收貨地址
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS addresses (
    id         INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id    INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    name       TEXT    NOT NULL,
    phone      TEXT    NOT NULL,
    province   TEXT    NOT NULL,
    city       TEXT    NOT NULL,
    district   TEXT    NOT NULL,
    detail     TEXT    NOT NULL,
    is_default INTEGER NOT NULL DEFAULT 0 CHECK (is_default IN (0, 1)),
    created_at INTEGER NOT NULL DEFAULT (strftime('%s', 'now'))
);

CREATE INDEX IF NOT EXISTS idx_addresses_user ON addresses(user_id);

-- ------------------------------------------------------------
-- 7. orders - 訂單
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS orders (
    id               INTEGER PRIMARY KEY AUTOINCREMENT,
    order_no         TEXT    NOT NULL UNIQUE,
    user_id          INTEGER NOT NULL REFERENCES users(id) ON DELETE RESTRICT,
    total_amount     REAL    NOT NULL CHECK (total_amount >= 0),
    status           TEXT    NOT NULL DEFAULT 'pending'
                             CHECK (status IN ('pending', 'confirmed', 'shipped', 'completed', 'cancelled')),
    payment_method   TEXT    NOT NULL DEFAULT 'offline' CHECK (payment_method IN ('offline')),
    payment_status   TEXT    NOT NULL DEFAULT 'unpaid' CHECK (payment_status IN ('unpaid', 'paid')),
    shipping_name    TEXT    NOT NULL,
    shipping_phone   TEXT    NOT NULL,
    shipping_address TEXT    NOT NULL,
    remark           TEXT,
    created_at       INTEGER NOT NULL DEFAULT (strftime('%s', 'now')),
    updated_at       INTEGER NOT NULL DEFAULT (strftime('%s', 'now'))
);

CREATE INDEX IF NOT EXISTS idx_orders_user       ON orders(user_id);
CREATE INDEX IF NOT EXISTS idx_orders_status     ON orders(status);
CREATE INDEX IF NOT EXISTS idx_orders_order_no   ON orders(order_no);
CREATE INDEX IF NOT EXISTS idx_orders_created_at ON orders(created_at);

-- ------------------------------------------------------------
-- 8. order_items - 訂單明細
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS order_items (
    id            INTEGER PRIMARY KEY AUTOINCREMENT,
    order_id      INTEGER NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
    product_id    INTEGER NOT NULL REFERENCES products(id) ON DELETE RESTRICT,
    product_name  TEXT    NOT NULL,
    product_image TEXT,
    price         REAL    NOT NULL CHECK (price >= 0),
    quantity      INTEGER NOT NULL CHECK (quantity > 0),
    subtotal      REAL    NOT NULL CHECK (subtotal >= 0)
);

CREATE INDEX IF NOT EXISTS idx_order_items_order   ON order_items(order_id);
CREATE INDEX IF NOT EXISTS idx_order_items_product ON order_items(product_id);

-- ------------------------------------------------------------
-- 9. banners - 首頁輪播
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS banners (
    id         INTEGER PRIMARY KEY AUTOINCREMENT,
    title      TEXT    NOT NULL,
    subtitle   TEXT,
    image_url  TEXT    NOT NULL,
    link_url   TEXT,
    sort_order INTEGER NOT NULL DEFAULT 0,
    status     TEXT    NOT NULL DEFAULT 'active' CHECK (status IN ('active', 'inactive')),
    created_at INTEGER NOT NULL DEFAULT (strftime('%s', 'now'))
);

CREATE INDEX IF NOT EXISTS idx_banners_sort ON banners(sort_order);
