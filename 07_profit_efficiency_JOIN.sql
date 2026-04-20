-- Query 7: Profit per 1000 people ανά State
-- Συνδυάζουμε superstore + population
-- Βρίσκουμε ποιες πολιτείες είναι πιο "efficient" σε κέρδος

SELECT 
    s.State,
    s.Region,
    ROUND(SUM(s.Sales), 2) AS Total_Sales,
    ROUND(SUM(s.Profit), 2) AS Total_Profit,
    ROUND(SUM(s.Profit)/SUM(s.Sales)*100, 2) AS Profit_Margin,
    p.Population_2014,
    ROUND(SUM(s.Profit) / p.Population_2014 * 1000, 2) AS Profit_Per_1000_People
FROM superstore s
JOIN population p ON s.State = p.State
GROUP BY s.State
ORDER BY Profit_Per_1000_People DESC
LIMIT 10;


////Delaware → #1 σε Profit per 1000 people (10.69) ΚΑΙ υψηλότατο Profit Margin (36.35%) — η πιο efficient πολιτεία!
Rhode Island → μικρή πολιτεία αλλά πολύ καλή απόδοση (32.2% margin)
Washington → μεγάλες πωλήσεις (138K) με καλό profit margin (24%)
New York → τεράστιες πωλήσεις αλλά λόγω πληθυσμού πέφτει στο #4

Το συμπέρασμα: Οι μικρές πολιτείες της East region είναι πιο efficient — αξίζει να επενδύσεις εκεί!//////