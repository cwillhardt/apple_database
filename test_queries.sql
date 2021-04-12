USE enterprise;

SELECT * FROM stock;
SELECT * FROM store;
SELECT * FROM product;
SELECT * FROM vendor;
SELECT * FROM configurables;
SELECT * FROM model_configurations;
SELECT * FROM model;
SELECT * FROM product_purchases;
SELECT * FROM checkout;
SELECT * FROM apple_account;
SELECT * FROM device;
SELECT * FROM developer;
SELECT * FROM app;
SELECT * FROM app_purchase;
SELECT * FROM in_app_items;
SELECT * FROM in_app_purchase;
SELECT * FROM consumable_ownership;
SELECT * FROM artist;
SELECT * FROM song;
SELECT * FROM song_purchases;

SELECT * FROM model NATURAL LEFT OUTER JOIN product;
SELECT * FROM model NATURAL LEFT OUTER JOIN model_configurations NATURAL LEFT OUTER JOIN configurables;
SELECT * FROM app JOIN in_app_items USING(app_id);
SELECT * FROM song JOIN artist USING(artist_id);
SELECT * FROM stock NATURAL LEFT OUTER JOIN store;
SELECT * FROM product_purchases NATURAL LEFT OUTER JOIN checkout; /* some nulls in apple_id to be expected */