#  Sales Performance Analysis
**Tools:** Python (pandas, matplotlib, seaborn) · SQL (SQLite) · Power BI

An end-to-end data analysis project on 10,000+ retail transactions from the Kaggle Superstore dataset, enriched with US population data to enable per-capita insights.

---

##  Business Questions Answered

| # | Question |
|---|----------|
| 1 | Which product categories generate the most profit? |
| 2 | How do discounts affect profitability? |
| 3 | Which regions perform best? |
| 4 | What are the monthly sales trends? |
| 5 | Which are the top 10 most profitable products? |
| 6 | Which states have the highest sales per capita? |
| 7 | Which states are most profit-efficient relative to population? |
| 8 | How can we segment customers using RFM analysis? |

---

##  Key Findings

- **Discounts above 20% consistently produce negative profit margins** — orders with 21–40% discounts averaged a loss of $77.86 per transaction
- **Furniture** has high revenue ($741K) but extremely low profit ($18K) — the most problematic category
- **Technology** dominates both top products and profitability (145K total profit)
- **West region** leads in total profit; **Central** has the weakest margin (7.92%)
- **Delaware** ranks #1 in both sales and profit per 1,000 residents despite being a small state — highest profit margin at 36.35%
- **RFM segmentation** identified high-value "At Risk" customers (e.g. $19K lifetime value, 400+ days inactive) requiring targeted retention campaigns

---

##  Project Structure

```
├── analysis.py                      # Python: data cleaning, EDA, visualizations, RFM
├── 01_category_profit.sql           # Sales & profit by product category
├── 02_discount_impact.sql           # Discount range vs profit impact
├── 03_regional_performance.sql      # Revenue, profit & margin by region
├── 04_monthly_trend.sql             # Monthly sales trend (2014–2017)
├── 05_top_products.sql              # Top 10 most profitable products
├── 06_sales_per_population_JOIN.sql # Sales per 1,000 people by state (JOIN)
├── 07_profit_efficiency_JOIN.sql    # Profit efficiency by state (JOIN)
├── 08_RFM_segmentation.sql          # RFM customer segmentation
├── SuperstoreProject.pbix           # Power BI dashboard
├── Sample - Superstore.csv          # Primary dataset (Kaggle)
└── us_population_2014_2017.csv      # Population data for per-capita analysis
```

---

##  Power BI Dashboard

The `.pbix` file includes:
- KPI cards (Total Sales, Total Profit, Profit Margin, Total Orders)
- Regional map with sales & profit breakdown
- Discount impact bar chart
- Monthly trend line chart
- Customer RFM segment distribution

---

##  How to Run

1. Clone the repo
2. Install dependencies: `pip install pandas matplotlib seaborn`
3. Run `analysis.py` to generate all charts
4. Open `SuperstoreProject.pbix` in Power BI Desktop to explore the dashboard
5. SQL files can be run in any SQLite client (e.g. DB Browser for SQLite)

---

---

*Portfolio project by Dimitrios Antoniou | April 2026*  
*🔗 [LinkedIn](https://www.linkedin.com/in/dimitrios-antoniou-ba0342298/) | [GitHub](https://github.com/DimitriosAntoniou)*

## 📁 Data Sources

- [Kaggle Superstore Dataset](https://www.kaggle.com/datasets/vivek468/superstore-dataset-final)
- US Population data (2014–2017) — manually compiled and joined via State field
