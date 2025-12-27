import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

df = pd.read_csv('Telco-Customer-Churn.csv')
df.head()
df.shape
df.info()
df.describe()
#data cleaning
df.isnull().sum()
df['TotalCharges'] = pd.to_numeric(df['TotalCharges'], errors='coerce')
df.dropna(inplace=True)
df['Churn'] = df['Churn'].map({'Yes': 1, 'No': 0})
df.isnull().sum()
df.info()

#perform EDA

# Set style
sns.set(style="whitegrid")
plt.figure(figsize=(15, 10))

# -------------------------------
# 1. Churn Distribution
# -------------------------------
# This bar plot shows the total number of customers who churned (Yes) versus those who did not churn (No).
# It gives you an initial idea of the class imbalance in your target variable.
plt.subplot(2, 3, 1)
sns.countplot(x='Churn', data=df)
plt.title("Churn Distribution")
plt.xlabel("Churn (0 = No, 1 = Yes)")
plt.ylabel("Count")

# -------------------------------
# 2. Churn by Gender
# -------------------------------
# This count plot compares the churn rate between male and female customers.
# It helps determine if there's a significant difference in churn behavior based on gender.
plt.subplot(2, 3, 2)
sns.countplot(x='gender', hue='Churn', data=df)
plt.title("Churn by Gender")
plt.xlabel("Gender")
plt.ylabel("Count")

# -------------------------------
# 3. Tenure vs Churn
# -------------------------------
# This histogram illustrates the distribution of customer tenure (how long they've been with the company)
# for both churned and non-churned customers. You can observe if customers with shorter or longer tenures
# are more likely to churn.
plt.subplot(2, 3, 3)
sns.histplot(data=df, x='tenure', hue='Churn', bins=30, kde=True)
plt.title("Tenure vs Churn")
plt.xlabel("Tenure (Months)")
plt.ylabel("Frequency")

# -------------------------------
# 4. Contract Type vs Churn
# -------------------------------
# This count plot shows the number of churned and non-churned customers across different contract types
# (e.g., Month-to-month, One year, Two year). This helps understand which contract types are associated
# with higher churn rates.
plt.subplot(2, 3, 4)
sns.countplot(x='Contract', hue='Churn', data=df)
plt.title("Contract Type vs Churn")
plt.xlabel("Contract Type")
plt.ylabel("Count")
plt.xticks(rotation=20)

# -------------------------------
# 5. Monthly Charges vs Churn
# -------------------------------
# This box plot compares the distribution of monthly charges for churned and non-churned customers.
# It can reveal if customers with higher or lower monthly charges are more prone to churn.
plt.subplot(2, 3, 5)
sns.boxplot(x='Churn', y='MonthlyCharges', data=df)
plt.title("Monthly Charges vs Churn")
plt.xlabel("Churn (0 = No, 1 = Yes)")
plt.ylabel("Monthly Charges")

# -------------------------------
# 6. Payment Method vs Churn
# -------------------------------
# This count plot visualizes the churn rate for each payment method. It helps identify if certain
# payment methods are more common among customers who churn.
plt.subplot(2, 3, 6)
sns.countplot(x='PaymentMethod', hue='Churn', data=df)
plt.title("Payment Method vs Churn")
plt.xlabel("Payment Method")
plt.ylabel("Count")
plt.xticks(rotation=45)

plt.tight_layout()
plt.show()