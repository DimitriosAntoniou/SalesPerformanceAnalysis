-- Query 4: Monthly Sales Trend (διορθωμένο για M/D/YYYY format)
-- Εξάγουμε Year και Month από το format M/D/YYYY

SELECT 
    SUBSTR("Order Date", -4, 4) AS Year,                    -- Παίρνουμε τα τελευταία 4 ψηφία (έτος)
    CASE CAST(SUBSTR("Order Date", 1, INSTR("Order Date", '/') - 1) AS INTEGER)
        WHEN 1 THEN '01' WHEN 2 THEN '02' WHEN 3 THEN '03'
        WHEN 4 THEN '04' WHEN 5 THEN '05' WHEN 6 THEN '06'
        WHEN 7 THEN '07' WHEN 8 THEN '08' WHEN 9 THEN '09'
        WHEN 10 THEN '10' WHEN 11 THEN '11' WHEN 12 THEN '12'
    END AS Month,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    COUNT(DISTINCT "Order ID") AS Total_Orders
FROM superstore
GROUP BY Year, Month
ORDER BY Year, Month;

Monthly Trend → Seasonal patterns ανά μήνα
