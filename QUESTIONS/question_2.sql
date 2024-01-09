SELECT 
    EXTRACT("MONTH" FROM TO_DATE(ord.order_date,'YYYY-MM-DD')) AS MONTH,
    COUNT(*) AS TOTAL_ORDERS,
    SUM(prod.sale_price * ord.product_quantity) AS TOTAL_REVENUE
FROM 
    orders AS ord, dim_product AS prod
WHERE 
    ord.product_code = prod.product_code
    -- AND EXTRACT("YEAR" FROM TO_DATE(ord.order_date,'YYYY-MM-DD HH24:MI:SS')) = 2022
    AND EXTRACT("YEAR" FROM TO_DATE(ord.order_date,'YYYY-MM-DD')) = 2022
GROUP BY 
    EXTRACT("MONTH" FROM TO_DATE(ord.order_date,'YYYY-MM-DD'))
ORDER BY 
    TOTAL_REVENUE DESC
LIMIT 1
;
