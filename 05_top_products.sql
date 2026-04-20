-- Query 5: Ποια είναι τα Top 10 προϊόντα με το μεγαλύτερο κέρδος;
-- Χρησιμοποιούμε LIMIT για να πάρουμε μόνο τα 10 καλύτερα

SELECT "Product Name",
       Category,
       ROUND(SUM(Sales), 2) AS Total_Sales,
       ROUND(SUM(Profit), 2) AS Total_Profit,
       COUNT(*) AS Times_Ordered                -- Πόσες φορές παραγγέλθηκε
FROM superstore
GROUP BY "Product Name"
ORDER BY Total_Profit DESC
LIMIT 10;


//////////Βλέπουμε ότι τα Technology προϊόντα κυριαρχούν στα top 10 — Canon, Hewlett Packard, HP όλα Technology!
//////////


Top 10 Products → Technology κυριαρχεί

