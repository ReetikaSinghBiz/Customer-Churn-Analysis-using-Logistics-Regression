# Telecom Churn Analysis

This repository contains the code and analysis for a telecom churn prediction project. The goal of this project is to identify factors that contribute to customer churn and build a predictive model to identify customers at high risk of churn.


**Data**

* The analysis uses a dataset containing information about telecom customers, including features such as:
    * Customer demographics
    * Service usage patterns
    * Account information
    * Churn status (whether the customer churned or not)


**Usage**

1. **Install required packages:**
   ```R
   install.packages(c("dplyr", "caret", "ggplot2", "pROC"))


**Methodology**

1. **Data Loading and Cleaning:**
   - Load the dataset. handle missing values & outliers, and perform EDA to understand the data distribution and identify key features.

2. **Data Preprocessing:**
   - Convert categorical variables to appropriate data types.
   - Split the data into training and testing sets.

3. **Model Building:**
   - Train a logistic regression model to predict customer churn based on the selected features.

4. **Model Evaluation:**
   - Evaluate the model's performance on the testing set using metrics such as accuracy, precision, recall, F1-score, and AUC.
   - Generate a confusion matrix and ROC curve to visualize the model's performance.
   - ![ROC Curve](https://github.com/user-attachments/assets/865b34e1-a6e6-4d81-9674-7e2432687307)


5. **Feature Importance:**
   - Analyze the coefficients of the logistic regression model to identify the most important features in predicting churn.

**Outcomes**

* Key Findings:
- Churn Rate: Approximately 14.49% of customers churned.
  ![Churn Distribution](https://github.com/user-attachments/assets/4a587721-6a13-45aa-b441-b3bd18fd4455)

- Model Accuracy: The logistic regression model achieved an accuracy of 85.89% in predicting customer churn.

Key Predictors:
- Contract Renewal: Customers with shorter contracts are more likely to churn.
- Customer Service Calls: Higher numbers of customer service calls significantly increase churn risk.
- Day Minutes: Increased daily call duration is associated with a slight decrease in churn probability.


**Actionable Insights**

* Retention Strategies:
* Contract Incentives: Offer incentives for longer contracts, such as discounts or loyalty programs.
  
* Customer Service Improvement: Focus on improving customer service quality and reducing call volumes.
  - Implement proactive customer support measures (e.g., FAQs, chatbots).
  - Train customer service representatives to effectively address customer concerns.
  
* Targeted Campaigns:
  - Identify customers with high churn risk based on model predictions.
  - Offer personalized retention offers to these high-risk customers.
  - Data Usage Analysis: Investigate the relationship between data usage and churn further.

## Author
Reetika Singh
