USE enterprise;

/* I did some with joins and some without just because */

/* what are the 20 top selling models, including their product name */
SELECT product.name,pc.model_id,pc.sales
FROM (SELECT model.product_id,count.model_id,count.sales
	FROM (SELECT model_id,count(model_id) as sales
		FROM product_purchases
		GROUP BY model_id) as count, model
	WHERE count.model_id = model.model_id) as pc, product
WHERE product.product_id = pc.product_id
ORDER BY sales DESC
LIMIT 20;

/* top selling product in each country */
SELECT name,country,MAX(sales)
FROM (SELECT name,country,count(*) as sales
	FROM product_purchases NATURAL LEFT OUTER JOIN model NATURAL LEFT OUTER JOIN product NATURAL LEFT OUTER JOIN checkout NATURAL LEFT OUTER JOIN store
	GROUP BY name,country
	ORDER BY country) as country_sales
GROUP BY country;

/*  helper for verifying previous query
SELECT name,country,count(*)
FROM product_purchases NATURAL LEFT OUTER JOIN model NATURAL LEFT OUTER JOIN product NATURAL LEFT OUTER JOIN checkout NATURAL LEFT OUTER JOIN store
GROUP BY name,country
ORDER BY country;
*/
    
/* what are the 5 stores with the most sales */
SELECT store_id, sum(sc.sales) as count
FROM (SELECT checkout.store_id,sc.sales as sales
	FROM (SELECT checkout_id,count(checkout_id) as sales
		FROM product_purchases
		GROUP BY checkout_id) as sc, checkout
	WHERE checkout.checkout_id = sc.checkout_id) as sc
GROUP BY sc.store_id
ORDER BY count DESC
LIMIT 5;

/* in how many stores does MacBook outsell MacBook Pro */
SELECT count(*) as 'Stores MacBook outsells MacBook Pro'
FROM (SELECT store_id,count(*) as sales
	FROM product_purchases NATURAL LEFT OUTER JOIN model NATURAL LEFT OUTER JOIN product NATURAL LEFT OUTER JOIN checkout
	WHERE name = 'MacBook'
	GROUP BY store_id) AS sales NATURAL LEFT OUTER JOIN (SELECT store_id,count(*) as pro_sales
	FROM product_purchases NATURAL LEFT OUTER JOIN model NATURAL LEFT OUTER JOIN product NATURAL LEFT OUTER JOIN checkout
	WHERE name = 'MacBook Pro'
	GROUP BY store_id) AS pro_sales
WHERE sales > pro_sales OR (sales is NOT NULL AND pro_sales is NULL);

/* helper for verifying previous query
SELECT name,store_id,count(*) as sales
FROM product_purchases NATURAL LEFT OUTER JOIN model NATURAL LEFT OUTER JOIN product NATURAL LEFT OUTER JOIN checkout
WHERE name = 'MacBook' OR name = 'MacBook Pro'
GROUP BY store_id,name
ORDER BY store_id;
*/

/* what are the top 3 products that customers buy in addition to iMac */
SELECT name,count(*) as count
FROM (SELECT checkout_id
	FROM product_purchases NATURAL LEFT OUTER JOIN model NATURAL LEFT OUTER JOIN product NATURAL LEFT OUTER JOIN checkout
	WHERE name = 'iMac') as mac, (SELECT checkout_id,product_id,name
		FROM product_purchases NATURAL LEFT OUTER JOIN model NATURAL LEFT OUTER JOIN product NATURAL LEFT OUTER JOIN checkout
		WHERE name != 'iMac') as other
WHERE mac.checkout_id = other.checkout_id
GROUP BY other.product_id
ORDER BY count DESC
LIMIT 3;

/* what are the top 3 developers with the most in app purchases*/
SELECT developer.name as developer_name,count(*) as in_app_sales
FROM in_app_purchase NATURAL LEFT OUTER JOIN in_app_items JOIN app USING(app_id) JOIN developer USING(dev_id)
GROUP BY dev_id
ORDER BY in_app_sales DESC
LIMIT 3
;

/* Top 10 selling artists */
SELECT name,sales
FROM artist NATURAL LEFT OUTER JOIN (SELECT artist_id,count(artist_id) as sales
	FROM song_purchases NATURAL LEFT OUTER JOIN song
	GROUP BY artist_id) AS id_counts
ORDER BY sales DESC
LIMIT 10;





