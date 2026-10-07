# Banking Customer & Performance Analytics Dashboard

An end-to-end banking analytics project built using **MySQL, SQL, Power BI and DAX** to analyze customer behavior, account activity, transactions, loan risk, card fraud and customer support performance.

The project combines relational database analysis with an interactive **6-page Power BI dashboard** to transform large-scale banking data into actionable business insights.

---

## 📌 Project Overview

Banks generate large volumes of data across customers, accounts, transactions, cards, loans and customer support.

The objective of this project is to build a centralized analytics solution that helps answer questions such as:

- How many customers and accounts does the bank have?
- How is customer activity distributed across states and occupations?
- What are the major transaction channels and transaction types?
- How large is the bank's loan portfolio?
- Which loan types have higher default risk?
- What is the card fraud rate and fraudulent transaction value?
- How effectively are customer support tickets being resolved?
- How does customer satisfaction vary across support issues?

The project follows an end-to-end analytics workflow:

**CSV Data → MySQL → SQL Analysis → Power BI Data Model → DAX Measures → Interactive Dashboard**

---

## 🛠️ Tech Stack

- **MySQL** – Data storage, relational modeling and SQL analysis
- **SQL** – Data validation, aggregation, segmentation and business analysis
- **Power BI** – Interactive dashboard and visualization
- **DAX** – Measures, KPIs and calculated columns
- **Power Query** – Data preparation and transformation

---

## 📊 Dataset Scale

The project contains multiple interconnected banking datasets:

| Dataset | Records |
|---|---:|
| Customers | 60,000 |
| Accounts | 95,000 |
| Transactions | 2,000,000 |
| Cards | 65,000 |
| Card Transactions | 3,000,000 |
| Loans | 22,000 |
| Loan Payments | 600,000 |
| Branches | 150 |
| Employees | 1,800 |
| Support Tickets | 25,000 |

The analysis covers more than **5 million financial and operational records** across the banking ecosystem.

> Raw CSV datasets are not included in this repository due to their large size.

---

# 🗄️ Database Structure

The project uses a relational banking database consisting of:

### Customer & Account

- `customers`
- `accounts`
- `branches`

### Transactions

- `transactions`

### Cards & Fraud

- `cards`
- `card_transactions`

### Loans & Payments

- `loans`
- `loan_payments`

### Branch & Employee Performance

- `employees`

### Customer Support

- `support_tickets`

These tables are connected using customer, account, card, loan and branch relationships.

---

# 🔍 SQL Analysis

SQL was used to perform business-focused analysis across multiple banking domains.

### Customer Analytics

- Customer distribution by state
- Customer distribution by occupation
- Credit score analysis
- Income analysis
- Customers with and without accounts
- Average accounts per customer

### Account & Transaction Analytics

- Account balances by account type
- Account status analysis
- Transaction value by transaction type
- Transaction value by channel
- Monthly transaction trends
- Average transaction value
- Transaction volume analysis

### Card & Fraud Analytics

- Card distribution by card type
- Card transaction analysis
- Fraud transaction analysis
- Fraud amount analysis
- Merchant category analysis
- Fraud rate analysis

### Loan & Risk Analytics

- Loan portfolio by loan type
- Default rate by loan type
- Default exposure
- Loan payment analysis
- Late payment analysis
- Monthly payment trends

### Customer Support Analytics

- Ticket volume by issue type
- Resolution rate
- Resolution time
- Customer satisfaction
- Satisfaction by issue type
- Monthly support ticket trends

### Branch & Employee Analytics

- Branch employee distribution
- Employee salary analysis
- Branch-level performance analysis

---

# 📈 Key Business Findings

### 💰 Transaction Activity

- **2 million transactions**
- Total transaction value of approximately **₹12.10 billion**
- Average transaction value of approximately **₹6,048**
- Transaction activity remained relatively stable across the analyzed period.

### 💳 Card Fraud

- Approximately **3 million card transactions**
- Fraud rate of approximately **0.50%**
- Fraudulent transaction value of approximately **₹27.42 million**
- Fraud patterns were analyzed across merchant categories and time.

### 🏦 Loan Portfolio

- Approximately **22,000 loans**
- Total loan portfolio of approximately **₹9.21 billion**
- Default rates were relatively close across loan types.
- **Education and Gold loans had the highest default rate at approximately 7.54%.**

### 🎧 Customer Support

- **25,000 support tickets**
- Approximately **80.2% resolution rate**
- Average customer satisfaction of approximately **3.0 / 5**

### 👥 Customer & Account Base

- **60,000 customers**
- **95,000 accounts**
- Approximately **47,640 customers have accounts**
- Customers with accounts hold approximately **2 accounts on average**

---

# 📊 Power BI Dashboard

The final Power BI dashboard contains **6 interactive pages**.

## 1. Executive Overview

Provides a high-level view of the bank's overall performance.

Includes:

- Total Customers
- Total Accounts
- Total Balance
- Total Loan Portfolio
- Transaction Value
- Fraud Rate
- Monthly Transaction Value
- Transaction Value by Channel
- Loan Portfolio by Type
- Account Status Distribution

---

## 2. Customer Analytics

Analyzes customer demographics, financial characteristics and credit profiles.

Includes:

- Customer Distribution by State
- Customer Distribution by Occupation
- Credit Score Distribution
- Income vs Credit Score
- Average Credit Score
- Average Annual Income
- Customers with Accounts

---

## 3. Accounts & Transactions

Analyzes account activity and transaction behavior.

Includes:

- Balance by Account Type
- Account Status Distribution
- Transaction Value by Type
- Monthly Transaction Value
- Transaction Value by Channel
- Average Transaction Value by Channel

---

## 4. Loans & Risk

Focuses on lending performance and credit risk.

Includes:

- Loan Portfolio by Type
- Default Rate by Loan Type
- Loan Amount vs Interest Rate
- Loan Payments by Type
- Late Payment Rate by Loan Type
- Monthly Loan Payment Trend

---

## 5. Cards & Fraud

Analyzes card activity and financial fraud.

Includes:

- Cards by Type
- Fraud Transactions by Merchant Category
- Fraud Amount by Merchant Category
- Monthly Fraud Transactions
- Fraud Rate by Merchant Category
- Total Card Spend
- Fraud Amount
- Active Cards

---

## 6. Customer Support

Analyzes customer service performance.

Includes:

- Support Tickets by Issue Type
- Customer Satisfaction by Issue Type
- Average Resolution Time by Issue Type
- Monthly Support Ticket Volume
- Resolution Rate by Issue Type
- Satisfaction Score Distribution

---

# 🧮 DAX & Power BI Modeling

A dedicated Date table was created to support time-series analysis.

Key DAX measures include:

- Total Customers
- Total Accounts
- Total Balance
- Total Loan Portfolio
- Total Transactions
- Transaction Value
- Average Transaction Value
- Total Card Spend
- Fraud Transactions
- Fraud Rate
- Fraud Amount
- Total Loans
- Defaulted Loans
- Default Rate
- Late Payment Rate
- Total Loan Payments
- Total Support Tickets
- Resolution Rate
- Average Satisfaction
- Average Resolution Hours

Additional calculated columns were created for:

- Credit Score Bands
- Credit Score Band Sorting
- Date attributes
- Year
- Month
- Quarter
- Year-Month

---

# 🏗️ Project Architecture

```text
                CSV DATA
                   │
                   ▼
              ┌─────────┐
              │  MySQL  │
              └─────────┘
                   │
                   ▼
            SQL Analysis
                   │
                   ▼
          Power BI Data Model
                   │
                   ├── Customers
                   ├── Accounts
                   ├── Transactions
                   ├── Cards
                   ├── Card Transactions
                   ├── Loans
                   ├── Loan Payments
                   ├── Branches
                   ├── Employees
                   └── Support Tickets
                   │
                   ▼
              DAX Measures
                   │
                   ▼
          6-Page Power BI
              Dashboard
