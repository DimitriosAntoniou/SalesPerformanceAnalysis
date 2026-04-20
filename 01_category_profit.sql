-- Query 1: Ποιες κατηγορίες προϊόντων έχουν το μεγαλύτερο κέρδος;
-- Χρησιμοποιούμε SUM για να αθροίσουμε Profit και Sales ανά κατηγορία
-- GROUP BY για να ομαδοποιήσουμε ανά Category
-- ORDER BY DESC για να δούμε πρώτα την πιο κερδοφόρα

SELECT Category,
       ROUND(SUM(Profit), 2) AS Total_Profit,   -- Συνολικό κέρδος ανά κατηγορία
       ROUND(SUM(Sales), 2) AS Total_Sales        -- Συνολικές πωλήσεις ανά κατηγορία
FROM superstore
GROUP BY Category
ORDER BY Total_Profit DESC;


//// Technology → το πιο κερδοφόρο (145K profit)
Office Supplies → δεύτερο (122K profit)
Furniture → τεράστιες πωλήσεις (741K) αλλά ελάχιστο κέρδος (18K) ///////////

Category Profit → Technology το πιο κερδοφόρο