-- Query 8: RFM Customer Segmentation
-- Recency: πόσες μέρες από την τελευταία αγορά
-- Frequency: πόσες μοναδικές παραγγελίες
-- Monetary: συνολικά έσοδα ανά πελάτη

WITH rfm AS (
    SELECT 
        "Customer ID",
        "Customer Name",
        -- Recency: μέρες από τελευταία αγορά
        ROUND(JULIANDAY('2017-12-31') - JULIANDAY(
            SUBSTR("Order Date", -4) || '-' ||
            PRINTF('%02d', CAST(SUBSTR("Order Date", 1, INSTR("Order Date", '/') - 1) AS INT)) || '-' ||
            PRINTF('%02d', CAST(SUBSTR("Order Date", INSTR("Order Date", '/') + 1, 
            INSTR(SUBSTR("Order Date", INSTR("Order Date", '/') + 1), '/') - 1) AS INT))
        ), 0) AS Recency_Days,
        -- Frequency: αριθμός παραγγελιών
        COUNT(DISTINCT "Order ID") AS Frequency,
        -- Monetary: συνολικές πωλήσεις
        ROUND(SUM(Sales), 2) AS Monetary
    FROM superstore
    GROUP BY "Customer ID"
)
SELECT *,
    CASE 
        WHEN Recency_Days <= 100 AND Frequency >= 5 AND Monetary >= 1000 THEN 'Champion'
        WHEN Recency_Days <= 200 AND Frequency >= 3 AND Monetary >= 500 THEN 'Loyal Customer'
        WHEN Recency_Days <= 100 AND Frequency <= 2 THEN 'New Customer'
        WHEN Recency_Days > 300 AND Frequency >= 3 THEN 'At Risk'
        WHEN Recency_Days > 400 THEN 'Lost Customer'
        ELSE 'Potential Loyal'
    END AS Segment
FROM rfm
ORDER BY Monetary DESC
LIMIT 20;


///////τι βλέπουμε:

Sean Miller → Champion! Αγόρασε πρόσφατα (80 μέρες), 5 παραγγελίες, 25K έσοδα 🥇
Tamara Chand → At Risk! 19K έσοδα αλλά 400 μέρες χωρίς αγορά ⚠️
Raymond Buch → At Risk! 6 παραγγελίες αλλά 639 μέρες εξαφανισμένος ⚠️
Adrian Barton → At Risk! 10 παραγγελίες (πιστός πελάτης) αλλά 462 μέρες χωρίς αγορά ❌

Business Insight: Υπάρχουν πολύτιμοι πελάτες που κινδυνεύουν να χαθούν — η εταιρεία πρέπει να τους στείλει targeted offers! /////////