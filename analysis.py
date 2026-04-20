# ============================================
# SUPERSTORE SALES ANALYSIS
# Step 1: Load & Explore Data
# ============================================

import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# Φόρτωση δεδομένων
df = pd.read_csv("Sample - Superstore.csv", encoding="latin1")

# Πρώτη ματιά στα δεδομένα
print("=== SHAPE ===")
print(df.shape)  # Πόσες γραμμές και columns

print("\n=== COLUMNS ===")
print(df.columns.tolist())  # Ονόματα columns

print("\n=== FIRST 5 ROWS ===")
print(df.head())  # Πρώτες 5 γραμμές

print("\n=== MISSING VALUES ===")
print(df.isnull().sum())  # Null values ανά column

# ============================================
# Step 2: Sales & Profit ανά Category
# ============================================

# Ομαδοποίηση ανά Category
category_data = df.groupby("Category")[["Sales", "Profit"]].sum().reset_index()

# Γράφημα
fig, ax = plt.subplots(figsize=(8, 5))
x = range(len(category_data))
bars1 = ax.bar(x, category_data["Sales"], width=0.4, label="Sales", color="steelblue")
bars2 = ax.bar([i + 0.4 for i in x], category_data["Profit"], width=0.4, label="Profit", color="coral")

ax.set_xticks([i + 0.2 for i in x])
ax.set_xticklabels(category_data["Category"])
ax.set_title("Sales vs Profit by Category")
ax.set_ylabel("Amount ($)")
ax.legend()
plt.tight_layout()
plt.savefig("01_category_sales_profit.png")  # Αποθήκευση
plt.show()
print("Chart 1 saved!")


# ============================================
# Step 3: Discount vs Profit (Scatter Plot)
# ============================================

plt.figure(figsize=(8, 5))
plt.scatter(df["Discount"], df["Profit"], alpha=0.3, color="steelblue")
plt.axhline(y=0, color="red", linestyle="--", linewidth=1)  # Γραμμή του 0
plt.title("Discount vs Profit")
plt.xlabel("Discount (%)")
plt.ylabel("Profit ($)")
plt.tight_layout()
plt.savefig("02_discount_vs_profit.png")
plt.show()
print("Chart 2 saved!")


# ============================================
# Step 4: Monthly Sales Trend
# ============================================

# Μετατροπή Order Date σε datetime
df["Order Date"] = pd.to_datetime(df["Order Date"], format="%m/%d/%Y")
df["Year"] = df["Order Date"].dt.year
df["Month"] = df["Order Date"].dt.month

# Ομαδοποίηση ανά Μήνα και Χρόνο
monthly = df.groupby(["Year", "Month"])["Sales"].sum().reset_index()
monthly["Date"] = pd.to_datetime(monthly[["Year", "Month"]].assign(day=1))

# Γράφημα
plt.figure(figsize=(12, 5))
plt.plot(monthly["Date"], monthly["Sales"], color="steelblue", linewidth=2)
plt.fill_between(monthly["Date"], monthly["Sales"], alpha=0.3, color="steelblue")
plt.title("Monthly Sales Trend (2014-2017)")
plt.xlabel("Date")
plt.ylabel("Sales ($)")
plt.tight_layout()
plt.savefig("03_monthly_trend.png")
plt.show()
print("Chart 3 saved!")


# ============================================
# Step 5: Profit Margin Heatmap
# ============================================

# Υπολογισμός Profit Margin ανά Region και Category
heatmap_data = df.groupby(["Region", "Category"]).apply(
    lambda x: round(x["Profit"].sum() / x["Sales"].sum() * 100, 2)
).reset_index()
heatmap_data.columns = ["Region", "Category", "Profit_Margin"]
heatmap_pivot = heatmap_data.pivot(index="Region", columns="Category", values="Profit_Margin")

# Γράφημα
plt.figure(figsize=(8, 5))
sns.heatmap(heatmap_pivot, annot=True, fmt=".1f", cmap="RdYlGn",
            linewidths=0.5, cbar_kws={"label": "Profit Margin (%)"})
plt.title("Profit Margin % by Region and Category")
plt.tight_layout()
plt.savefig("04_profit_margin_heatmap.png")
plt.show()
print("Chart 4 saved!")



# ============================================
# Step 6: RFM Customer Segmentation Chart
# ============================================

# Υπολογισμός RFM
max_date = df["Order Date"].max()

rfm = df.groupby("Customer ID").agg(
    Recency=("Order Date", lambda x: (max_date - x.max()).days),
    Frequency=("Order ID", "nunique"),
    Monetary=("Sales", "sum")
).reset_index()

# Segmentation
def segment(row):
    if row["Recency"] <= 100 and row["Frequency"] >= 5 and row["Monetary"] >= 1000:
        return "Champion"
    elif row["Recency"] <= 200 and row["Frequency"] >= 3 and row["Monetary"] >= 500:
        return "Loyal Customer"
    elif row["Recency"] <= 100 and row["Frequency"] <= 2:
        return "New Customer"
    elif row["Recency"] > 300 and row["Frequency"] >= 3:
        return "At Risk"
    elif row["Recency"] > 400:
        return "Lost Customer"
    else:
        return "Potential Loyal"

rfm["Segment"] = rfm.apply(segment, axis=1)

# Γράφημα
segment_counts = rfm["Segment"].value_counts()
colors = ["#2ecc71", "#3498db", "#f39c12", "#e74c3c", "#9b59b6", "#1abc9c"]

plt.figure(figsize=(8, 8))
plt.pie(segment_counts, labels=segment_counts.index, autopct="%1.1f%%",
        colors=colors, startangle=90)
plt.title("Customer Segmentation (RFM Analysis)")
plt.tight_layout()
plt.savefig("05_RFM_segments.png")
plt.show()
print("Chart 5 saved!")