🚀 E-Commerce Sales Dashboard (Power BI)
📌 Project Overview

This project presents an interactive E-Commerce Sales Dashboard built using Power BI to analyze business performance and generate actionable insights.

🎯 Problem Statement

The goal of this project is to analyze e-commerce sales data to identify:

Revenue trends over time
Top-performing cities and customers
Customer payment behavior
Operational issues like late deliveries

This helps businesses make data-driven decisions to improve performance.

📸 Dashboard Preview Section
## 📸 Dashboard Preview

### 🔹 Overview Dashboard
![Overview Dashboard](images/dashboard1.png)

### 🔹 Detailed Analysis
![Detailed Analysis](images/dashboard2.png)

🧩 Data Model Section
## 🧩 Data Model
![Data Model](images/model.png)

📊 Dashboard Features
🔹 KPIs
Total Revenue
Total Customers
Total Orders
Late Delivery %
Avg Spend per Order

🔹 Visualizations
📈 Sales Trend
📊 Order Volume Trend
🏙️ Top Cities by Revenue
💳 Payment Method Distribution
📦 Order Status Distribution
🌍 Geographic Analysis
🧾 Top Customers

📐 DAX Measures
Total Revenue = SUM(payments[payment_value])

Total Orders = COUNT(orders[order_id])

Avg Spend per Order = DIVIDE([Total Revenue], [Total Orders])

🎯 Key Insights
📉 Revenue dropped sharply in September (~60%)
📍 São Paulo contributes highest revenue
💳 Credit cards dominate (~78% of transactions)
📦 Most orders are successfully delivered
🚚 Late delivery rate is ~7–8%

▶️ How to Use
Download the PBIX file from the link below
Open in Power BI Desktop
Load dataset
Use slicers (State, Month) to explore

📁 Power BI File

👉 Download here:

https://drive.google.com/file/d/1fgH9m6ivviccf-SEKQTtZloLJ6jWWkOn/view?usp=sharing

📁 Dataset

👉 Download here:

https://drive.google.com/drive/folders/1W_fzYjnDQphW8Z-X-AnXx6ThE1ocrtg1?usp=sharing

📂 Project Structure
📁 E-Commerce-Dashboard
│── dashboard1.png
│── dashboard2.png
│── model.png
│── ecommerce_analysis.sql
│── insights.txt
│── README.md


🚀 Future Improvements
Add profit & cost analysis
Customer segmentation (high/low value)
Repeat customer analysis
Sales forecasting (ML model)
Deploy dashboard on Power BI Service

👤 Author

Sumit Tiwari
Aspiring Data Analyst | SQL | Power BI
📌 LinkedIn:https://www.linkedin.com/in/sumit-tiwari-7a7112381/
📌 GitHub:https://github.com/sumit312-cpu/

⭐ Support

If you like this project, give it a ⭐ on GitHub!























