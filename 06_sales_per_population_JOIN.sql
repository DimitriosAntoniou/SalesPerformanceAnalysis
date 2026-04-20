-- Query 6: Πωλήσεις ανά κάτοικο για κάθε State (2014-2017)
-- JOIN μεταξύ superstore και population μέσω State
-- Δείχνει ποιες πολιτείες έχουν υψηλές πωλήσεις σχετικά με τον πληθυσμό τους

SELECT 
    s.State,
    ROUND(SUM(s.Sales), 2) AS Total_Sales,
    ROUND(SUM(s.Profit), 2) AS Total_Profit,
    p.Population_2014,
    ROUND(SUM(s.Sales) / p.Population_2014 * 1000, 2) AS Sales_Per_1000_People
FROM superstore s
JOIN population p ON s.State = p.State
GROUP BY s.State
ORDER BY Sales_Per_1000_People DESC
LIMIT 10;

//// τι βλέπουμε:

Delaware → #1 σε πωλήσεις ανά 1000 κατοίκους (29.42) παρόλο που είναι μικρή πολιτεία
New York → τεράστιες πωλήσεις (310K) αλλά λόγω μεγάλου πληθυσμού πέφτει στο #4
Washington → πολύ καλή απόδοση (19.64) με εξαιρετικό profit (33K)////