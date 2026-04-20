-- Query 3: Ποια περιοχή αποδίδει καλύτερα;
-- Συγκρίνουμε Revenue, Profit και Profit Margin ανά Region
-- Profit Margin = Profit / Sales * 100

SELECT Region,
       COUNT(DISTINCT "Order ID") AS Total_Orders,         -- Συνολικές παραγγελίες
       ROUND(SUM(Sales), 2) AS Total_Sales,                 -- Συνολικές πωλήσεις
       ROUND(SUM(Profit), 2) AS Total_Profit,               -- Συνολικό κέρδος
       ROUND(SUM(Profit)/SUM(Sales)*100, 2) AS Profit_Margin -- Ποσοστό κέρδους
FROM superstore
GROUP BY Region
ORDER BY Total_Profit DESC;


////West → #1 σε Revenue και Profit (108K) ✅
East → δεύτερο σε όλα
South → λιγότερες παραγγελίες αλλά καλό Profit Margin (11.93%)
Central → το πιο αδύναμο — χαμηλό margin μόλις 7.92% 
///////

Regional Performance → West #1, Central το πιο αδύναμο
