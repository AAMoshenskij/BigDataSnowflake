INSERT INTO customers (first_name, last_name, age, email, country, postal_code)
SELECT 
    customer_first_name,
    customer_last_name,
    customer_age,
    customer_email,
    customer_country,
    customer_postal_code
FROM mock_data;

INSERT INTO pets (customer_id, type, name, breed)
SELECT 
    c.id,
    m.customer_pet_type,
    m.customer_pet_name,
    m.customer_pet_breed
FROM mock_data m
JOIN customers c
ON c.first_name = m.customer_first_name
AND c.last_name = m.customer_last_name
AND c.email = m.customer_email;

INSERT INTO sellers (first_name, last_name, email, country, postal_code)
SELECT 
    seller_first_name,
    seller_last_name,
    seller_email,
    seller_country,
    seller_postal_code
FROM mock_data;

INSERT INTO products (name, category, price, weight, color, size, brand, material, description, rating, reviews, release_date, expiry_date, pet_category)
SELECT 
    product_name,
    product_category,
    product_price,
    product_weight,
    product_color,
    product_size,
    product_brand,
    product_material,
    product_description,
    product_rating,
    product_reviews,
    product_release_date,
    product_expiry_date,
    pet_category
FROM mock_data;

INSERT INTO stores (name, location, city, state, country, phone, email)
SELECT 
    store_name,
    store_location,
    store_city,
    store_state,
    store_country,
    store_phone,
    store_email
FROM mock_data;

INSERT INTO suppliers (name, contact, email, phone, address, city, country)
SELECT 
    supplier_name,
    supplier_contact,
    supplier_email,
    supplier_phone,
    supplier_address,
    supplier_city,
    supplier_country
FROM mock_data;

-- В sales мы привязываем покупателя, продавца, товар и магазин.
-- Но так как ID новых таблиц не совпадают с исходными ID в mock_data,
-- пока для простоты мы вставим NULL вместо внешних ключей, а потом обновим.

-- Вставка данных в таблицу sales с supplier_id
INSERT INTO sales (sale_date, quantity, total_price, supplier_id)
SELECT 
    sale_date,
    sale_quantity,
    sale_total_price,
    (SELECT id FROM suppliers WHERE name = m.supplier_name LIMIT 1) -- связь с поставщиком
FROM mock_data m;


UPDATE sales s
SET customer_id = c.id
FROM customers c
JOIN mock_data m ON
    c.first_name = m.customer_first_name
    AND c.last_name = m.customer_last_name
    AND c.email = m.customer_email
WHERE s.id = m.id;

UPDATE sales s
SET seller_id = sel.id
FROM sellers sel
JOIN mock_data m ON
    sel.first_name = m.seller_first_name
    AND sel.last_name = m.seller_last_name
    AND sel.email = m.seller_email
WHERE s.id = m.id;

UPDATE sales s
SET product_id = p.id
FROM products p
JOIN mock_data m ON
    p.name = m.product_name
    AND p.price = m.product_price
WHERE s.id = m.id;

UPDATE sales s
SET store_id = st.id
FROM stores st
JOIN mock_data m ON
    st.name = m.store_name
    AND st.email = m.store_email
WHERE s.id = m.id;

