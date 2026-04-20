-- Query 2: Πώς επηρεάζουν οι εκπτώσεις το κέρδος;
-- Ομαδοποιούμε τις εκπτώσεις σε ranges για να δούμε το pattern
-- CASE WHEN για να δημιουργήσουμε κατηγορίες έκπτωσης

SELECT 
    CASE 
        WHEN Discount = 0 THEN '0% - No Discount'
        WHEN Discount <= 0.2 THEN '1-20% Discount'
        WHEN Discount <= 0.4 THEN '21-40% Discount'
        ELSE 'Over 40% Discount'
    END AS Discount_Range,
    COUNT(*) AS Total_Orders,                    -- Πόσες παραγγελίες
    ROUND(AVG(Profit), 2) AS Avg_Profit,         -- Μέσο κέρδος ανά range
    ROUND(SUM(Profit), 2) AS Total_Profit        -- Συνολικό κέρδος ανά range
FROM superstore
GROUP BY Discount_Range
ORDER BY Avg_Profit DESC;

//////////Αυτό είναι χρυσός! 🎉 Κοίταξε τι βλέπουμε:

0% έκπτωση → μέσο κέρδος +66.9$ ✅
1-20% έκπτωση → μέσο κέρδος +26.5$ (μειώνεται)
21-40% έκπτωση → μέσο κέρδος -77.86$ ❌ ζημία!
Πάνω από 40% → μέσο κέρδος -106.71$ ❌ μεγάλη ζημία!

Συμπέρασμα: Εκπτώσεις πάνω από 20% βγάζουν ζημία — αυτό είναι ένα πολύ δυνατό business insight για το portfolio σου!
///////////////////

Discount Impact → Εκπτώσεις >20% = ζημία
