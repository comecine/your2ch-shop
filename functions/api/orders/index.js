import { requireAuth, jsonResponse, corsHeaders } from '../_helpers.js';

export async function onRequestGet(context) {
  try {
    const user = await requireAuth(context);
    if (!user) return jsonResponse({ success: false, error: '请先登录' }, 401);

    const url = new URL(context.request.url);
    const page = Math.max(1, parseInt(url.searchParams.get('page') || '1', 10));
    const limit = Math.min(50, Math.max(1, parseInt(url.searchParams.get('limit') || '10', 10)));
    const offset = (page - 1) * limit;

    const db = context.env.DB;

    const countRow = await db.prepare(
      'SELECT COUNT(*) as total FROM orders WHERE user_id = ?'
    ).bind(user.userId).first();
    const total = countRow?.total || 0;

    const orders = await db.prepare(
      `SELECT id, order_no, total_amount, status, payment_method, payment_status,
              shipping_name, shipping_phone, shipping_address, remark, created_at
       FROM orders WHERE user_id = ?
       ORDER BY created_at DESC
       LIMIT ? OFFSET ?`
    ).bind(user.userId, limit, offset).all();

    // Attach items to each order
    const orderIds = orders.results.map(o => o.id);
    let itemsMap = {};
    if (orderIds.length > 0) {
      const placeholders = orderIds.map(() => '?').join(',');
      const items = await db.prepare(
        `SELECT * FROM order_items WHERE order_id IN (${placeholders})`
      ).bind(...orderIds).all();
      for (const item of items.results) {
        if (!itemsMap[item.order_id]) itemsMap[item.order_id] = [];
        itemsMap[item.order_id].push(item);
      }
    }

    const result = orders.results.map(o => ({ ...o, items: itemsMap[o.id] || [] }));

    return jsonResponse({ success: true, data: { orders: result, total, page, totalPages: Math.ceil(total / limit) } });
  } catch (err) {
    return jsonResponse({ success: false, error: err.message }, 500);
  }
}

export async function onRequestPost(context) {
  try {
    const user = await requireAuth(context);
    if (!user) return jsonResponse({ success: false, error: '请先登录' }, 401);

    const body = await context.request.json();
    const { address_id, remark } = body;

    if (!address_id) {
      return jsonResponse({ success: false, error: '请选择收货地址' }, 400);
    }

    const db = context.env.DB;

    // Verify address belongs to user
    const address = await db.prepare(
      'SELECT * FROM addresses WHERE id = ? AND user_id = ?'
    ).bind(address_id, user.userId).first();
    if (!address) return jsonResponse({ success: false, error: '地址不存在' }, 404);

    // Get cart items
    const cartItems = await db.prepare(
      `SELECT ci.id as cart_id, ci.quantity,
              p.id as product_id, p.name, p.image_url, p.price, p.stock
       FROM cart_items ci
       JOIN products p ON ci.product_id = p.id
       WHERE ci.user_id = ? AND p.status = 'active'`
    ).bind(user.userId).all();

    if (!cartItems.results.length) {
      return jsonResponse({ success: false, error: '购物车为空' }, 400);
    }

    // Check stock
    for (const item of cartItems.results) {
      if (item.stock < item.quantity) {
        return jsonResponse({ success: false, error: `商品 "${item.name}" 库存不足` }, 400);
      }
    }

    // Generate order_no: YC + yyyymmdd + 4-digit random
    const now = new Date();
    const dateStr = now.toISOString().slice(0, 10).replace(/-/g, '');
    const rand = String(Math.floor(Math.random() * 10000)).padStart(4, '0');
    const orderNo = `YC${dateStr}${rand}`;

    const totalAmount = cartItems.results.reduce((sum, item) => sum + item.price * item.quantity, 0);
    const shippingAddress = `${address.province}${address.city}${address.district}${address.detail}`;
    const nowTs = Math.floor(Date.now() / 1000);

    // Insert order
    const orderResult = await db.prepare(
      `INSERT INTO orders (order_no, user_id, total_amount, shipping_name, shipping_phone,
        shipping_address, remark, created_at, updated_at)
       VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)`
    ).bind(
      orderNo, user.userId, totalAmount,
      address.name, address.phone, shippingAddress,
      remark || null, nowTs, nowTs
    ).run();

    const orderId = orderResult.meta.last_row_id;

    // Insert order items & deduct stock
    for (const item of cartItems.results) {
      const subtotal = item.price * item.quantity;
      await db.prepare(
        `INSERT INTO order_items (order_id, product_id, product_name, product_image, price, quantity, subtotal)
         VALUES (?, ?, ?, ?, ?, ?, ?)`
      ).bind(orderId, item.product_id, item.name, item.image_url, item.price, item.quantity, subtotal).run();

      await db.prepare(
        'UPDATE products SET stock = stock - ?, sales = sales + ?, updated_at = ? WHERE id = ?'
      ).bind(item.quantity, item.quantity, nowTs, item.product_id).run();
    }

    // Clear cart
    await db.prepare('DELETE FROM cart_items WHERE user_id = ?').bind(user.userId).run();

    return jsonResponse({
      success: true,
      message: '订单创建成功',
      data: { order_no: orderNo, order_id: orderId, total_amount: totalAmount },
    }, 201);
  } catch (err) {
    return jsonResponse({ success: false, error: err.message }, 500);
  }
}

export async function onRequestOptions() {
  return new Response(null, { status: 204, headers: corsHeaders });
}
