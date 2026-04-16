CREATE OR REPLACE TABLE `olist-ecommerce-493504.raw_olist.master_order_data` AS
WITH 
-- 1. Merapikan nama kategori ke Bahasa Inggris
prod_info AS (
  SELECT 
    p.product_id,
    COALESCE(t.string_field_1, p.product_category_name, 'others') AS category_name_en
  FROM `raw_olist.products` p
  LEFT JOIN `raw_olist.category_translation` t 
    ON p.product_category_name = t.string_field_0
),

-- 2. Menggabungkan Items dengan info Produk
order_items_detailed AS (
  SELECT 
    oi.order_id,
    oi.product_id,
    oi.price,
    oi.freight_value,
    pi.category_name_en
  FROM `raw_olist.order_items` oi
  JOIN prod_info pi ON oi.product_id = pi.product_id
),

-- 3. Menghitung rata-rata rating per Order (karena 1 order bisa punya 1+ review)
avg_reviews AS (
  SELECT 
    order_id, 
    AVG(review_score) as avg_review_score
  FROM `raw_olist.reviews`
  GROUP BY 1
)

-- 4. Final Join: Menyatukan semuanya dengan tabel Orders utama
SELECT 
  o.order_id,
  o.customer_id,
  o.order_status,
  -- Mengubah format teks ke format Waktu (Timestamp) agar bisa dianalisis tren bulanan
  CAST(o.order_purchase_timestamp AS TIMESTAMP) as purchase_at,
  
  c.customer_city,
  c.customer_state,
  
  oid.product_id,
  oid.category_name_en,
  oid.price,
  oid.freight_value,
  (oid.price + oid.freight_value) as total_order_value, 
  
  rev.avg_review_score
FROM `raw_olist.orders` o
JOIN `raw_olist.customers` c ON o.customer_id = c.customer_id
JOIN order_items_detailed oid ON o.order_id = oid.order_id
LEFT JOIN avg_reviews rev ON o.order_id = rev.order_id
WHERE o.order_status = 'delivered'; -- fokus pada pesanan yang sampai ke pelanggan