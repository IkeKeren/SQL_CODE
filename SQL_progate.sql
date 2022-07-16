-- dapatkan nilai rata-rata umur semua pengguna
SELECT AVG(age) FROM users;

-- dapatkan semua pengguna pria yang berumur dibawah 20 tahun
SELECT * FROM users WHERE gender=0  AND age < 20 ORDER by id ASC;

/* 
dapatkan jumlah total usia unik pengguna dan
kelompokan pengguna tersebut berdasarkan usia
*/
SELECT age, COUNT(*) 
FROM users
GROUP BY age;

-- dapatkan setiap nama barang unik (tanpa duplikat)
SELECT DISTINCT name FROM items;

/*
dapatkan nama dan harga setiap produk dan
tampilkan secara mengecil berdasarkan harga
*/
SELECT name, price FROM items ORDER by price DESC;

-- dapatkan semua baris dengan nilai string "kaos"
SELECT *
FROM items
WHERE items.name LIKE "%kaos%";

--JAWABAN PROGATE: petik nya 1 aja
-- dapatkan semua baris dengan nilai string "kaos"            
SELECT * FROM items WHERE name LIKE '%kaos%';

-- dapatkan nama, harga dan laba semua produk
SELECT name, price , price - cost
FROM items;

-- dapatkan laba rata-rata dari semua produk
SELECT AVG(price - cost)
FROM items;

-- dapatkan nama dan laba dari 5 barang dengan laba tertinggi
SELECT name, price - cost
FROM items
ORDER By price - cost DESC
LIMIT 5;

-- dapatkan semua produk yang harganya lebih tinggi dari harga "hoodie abu-abu"
SELECT name, price FROm items 
WHERE price > (
SELECT price FROm items WHERE name = "hoodie abu-abu");

-- dapatkan semua produk yang labanya lebih tinggi dari laba "hoodie abu-abu"
SELECT name, price-cost
FROM ITEMS
WHERE price <= 70 AND price-cost> (
SELECT price-cost FROm items WHERE name = "hoodie abu-abu");

-- dapatkan jumlah berapa kali setiap jenis item terjual berdasarkan id item
SELECT item_id, COUNT(*) FROM sales_records GROUP by item_id;

/*
dapatkan id dan jumlah penjualan per unitnya dari 5 barang paling populer.
Susun hasilnya secara menurun
*/
-- dapatkan jumlah berapa kali setiap jenis item terjual berdasarkan id item
SELECT item_id, COUNT(*) FROM sales_records GROUP by item_id ORDER BY  COUNT(*) DESC LIMIT 5;

-- dapatkan nama dan jumlah penjualan unit untuk 5 barang dengan penjualan tertinggi
SELECT Items.id, Items.name, COunt(*) FROM sales_records 
JOIN Items ON sales_records.item_id = items.id
GROUP BY Items.id
ORDER BY COunt(*) DESC
LIMIT 5;

--JAWABAN PROGATE: Group by nya 2
-- dapatkan nama dan jumlah penjualan unit untuk 5 barang dengan penjualan tertinggi            
SELECT items.id, items.name, COUNT(*)            
FROM sales_records            
JOIN items            
ON sales_records.item_id = items.id            
GROUP BY items.id, items.name            
ORDER BY COUNT(*) DESC            
LIMIT 5

-- dapatkan total penjualan dan total laba untuk seluruh site
SELECT SUM(items.price) AS "total penjualan", SUM(price-cost) AS "total laba"
FROM items
JOIN sales_records ON sales_records.item_id = items.id
;

-- dapatkan berapa kali penjualan terjadi untuk setiap harinya
SELECT purchased_at, Count(*) AS "penjualan" FROM sales_records
GROUP by purchased_at;

-- dapatkan total harga penjualan dan kelompokan berdasarkan tanggal pembelianya
SELECT purchased_at, SUM(items.price) AS "total penjualan" FROM sales_records
JOIN items ON items.id = sales_records.item_id
GROUP by purchased_at;

--JAWABAN PROGATE:
-- dapatkan total harga penjualan dan kelompokan berdasarkan tanggal pembelianya
SELECT sales_records.purchased_at, SUM(items.price) AS "total penjualan"
FROM sales_records
JOIN items
ON sales_records.item_id = items.id
GROUP BY purchased_at
ORDER BY purchased_at ASC;

/*
dapatkan nama dan jumlah barang untuk pengguna
yang sudah membeli lebih dari 10 barang
*/
SELECT users.id, users.name, COUNT(*) AS "jumlah" FROM sales_records
JOIN users ON users.id = sales_records.user_id
GROUP BY users.id HAVING jumlah >= 10;

--JAWAB PROGATE:
SELECT users.id, users.name, count(*) AS "jumlah"
FROM sales_records
JOIN users
ON sales_records.user_id = users.id
GROUP BY users.id, users.name
HAVING count(*) >= 10;

-- dapatkan id dan nama pengguna yang membeli "sandal"
SELECT users.id, users.name FROM users
JOIN sales_records ON users.id = sales_records.user_id
LEFT JOIN items
ON items.id = sales_records.item_id
WHERE items.name LIKE "sandal"
GROUP BY users.id;

-- dapatkan data total penjualan untuk gender pria, wanita, dan netral
SELECT items.gender, SUM(items.price) AS "total penjualan"
FROM items
JOIN sales_records
ON sales_records.item_id = items.id
GROUP BY items.gender;

--JAWAB PROGATE:
-- dapatkan data total penjualan untuk gender pria, wanita, dan netral
SELECT items.gender, SUM(items.price) AS "total penjualan"
FROM sales_records
JOIN items
ON sales_records.item_id = items.id
GROUP BY items.gender;

-- dapatkan data untuk 5 produk dengan penjualan tertinggi 
SELECT items.id , items.name , SUM(items.price) AS "total penjualan"
FROM sales_records 
JOIN items
ON sales_records.item_id = items.id
GROUP BY items.id
ORDER BY  SUM(items.price) DESC
LIMIT 5;

--JAWAB PROGATE:
-- dapatkan data untuk 5 produk dengan penjualan tertinggi 
SELECT items.id, items.name, items.price * COUNT(*) AS "total penjualan"
FROM sales_records
JOIN items
ON sales_records.item_id = items.id
GROUP BY items.id, items.name, items.price
ORDER BY COUNT(*) * items.price DESC
LIMIT 5;

-- dapatkan semua barang dengan total penjualan yang lebih besar dari "hoodie abu-abu"
SELECT items.id , items.name , SUM(items.price) AS "total penjualan"
FROM sales_records 
JOIN items
ON sales_records.item_id = items.id
GROUP BY items.id HAVING SUM(items.price) > 1596
ORDER BY  items.id ASC;

--JAWABAN PROGATE:
-- dapatkan semua barang dengan total penjualan yang lebih besar dari "hoodie abu-abu"
SELECT items.id, items.name, items.price * COUNT(*) AS "total penjualan"
FROM sales_records
JOIN items
ON sales_records.item_id = items.id
GROUP BY items.id, items.name, items.price
HAVING (COUNT(*) * items.price) > (
SELECT COUNT(*) * items.price
FROM sales_records
JOIN items
ON sales_records.item_id = items.id
WHERE items.name = "hoodie abu-abu"
);