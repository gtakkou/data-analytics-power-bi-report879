
SELECT 
    dim_product.category,
    SUM((dim_product.sale_price - dim_product.cost_price) * orders.product_quantity) AS total_profit
    FROM orders
JOIN dim_store on dim_store.store_code = orders.store_code
JOIN dim_product on dim_product.product_code = orders.product_code
WHERE dim_store.full_region = 'Wiltshire, UK'
AND EXTRACT("YEAR" FROM TO_DATE(orders.order_date,'YYYY-MM-DD')) = 2021
GROUP BY dim_product.category 
ORDER BY total_profit DESC
;

