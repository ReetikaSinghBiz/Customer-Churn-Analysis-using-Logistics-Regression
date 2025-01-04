# Customer Churn Analysis using Logistic Regression

"
This Telecom dataset has the following features:
  
  1. Churn (Target Variable): Indicates whether a customer has left the service.
- 0 = Customer has not churned (retained).
- 1 = Customer has churned (left the service).

2. AccountWeeks: Represents the total number of weeks a customer has been with the company.

3. ContractRenewal: Indicates whether a customer recently renewed their contract.
- 1 = Contract renewed.
- 0 = Contract not renewed.

4. DataPlan: Indicates whether a customer is subscribed to a data plan.
- 1 = Has a data plan.
- 0 = No data plan.

5. DataUsage: Represents the amount of data (in GB) the customer used over the billing period.

6. CustServCalls: Represents the number of times a customer has contacted customer service.

7. DayMins: The total number of minutes the customer used during daytime hours.

8. DayCalls: The total number of calls made by the customer during daytime hours.

9. MonthlyCharge: The average monthly charge billed to the customer.

10. OverageFee: The amount charged to the customer for exceeding the allocated usage limits in a billing period.

11. RoamMins: The total number of minutes the customer spent on calls while roaming.
"


library(dplyr)
library(caret)
library(ggplot2)
library(pROC)

telecom_data <- read.csv("C:/Users/reeti/GitHub/telecom_churn.csv")

# Data Exploration
# Check for missing values
sum(is.na(telecom_data))

# Check for duplicates
print(paste0("Duplicate rows in the dataset:", sum(duplicated(telecom_data))))

# Summary statistics
summary(telecom_data)

# Data Visualization
# Churn rate
churn_rate <- table(telecom_data$Churn) / nrow(telecom_data)
print(paste0("Churn Rate:\n", paste(round(churn_rate * 100, 2), "%", sep = "")))

# Visualize churn distribution
ggplot(telecom_data, aes(x = "", fill = factor(Churn))) +
  geom_bar(width = 1) +
  coord_polar("y", start = 0) +
  theme_void() +
  labs(title = "Churn Distribution") +
  scale_fill_manual(values = c("skyblue", "salmon"), labels = c("Not Churned", "Churned"))

# Boxplots for num
ggplot(telecom_data, aes(y = AccountWeeks)) + geom_boxplot() + ggtitle("AccountWeeks")
ggplot(telecom_data, aes(y = DataUsage)) + geom_boxplot() + ggtitle("DataUsage") 

# Data Preparation
# Convert categorical variables to factors
telecom_data <- telecom_data %>%
  mutate(
    Churn = factor(Churn, levels = c(0, 1)),
    ContractRenewal = factor(ContractRenewal),
    DataPlan = factor(DataPlan)
  )

# Handle Outliers (Winsorization)
winsorize_data <- function(data, col, probs = c(0.05, 0.95)) {
  q <- quantile(data[[col]], probs)
  data[[col]] <- pmin(pmax(data[[col]], q[1]), q[2])
  return(data)
}

numerical_cols <- c("AccountWeeks", "DataUsage", "CustServCalls", "DayMins", "DayCalls", "MonthlyCharge", "OverageFee", "RoamMins")
for (col in numerical_cols) {
  telecom_data <- winsorize_data(telecom_data, col)
}

# Split the data
set.seed(123) 
train_index <- createDataPartition(telecom_data$Churn, p = 0.7, list = FALSE)
train_data <- telecom_data[train_index, ]
test_data <- telecom_data[-train_index, ]

# Logistic Regression Model
model <- glm(Churn ~ ., data = train_data, family = binomial)

# Test Predictions
predictions <- predict(model, newdata = test_data, type = "response")
predicted_classes <- ifelse(predictions > 0.5, "1", "0")

# Model Evaluation
confusion_matrix <- confusionMatrix(as.factor(predicted_classes), test_data$Churn)
print(confusion_matrix)

# ROC curve
roc_obj <- roc(response = test_data$Churn, predictor = predictions)
auc(roc_obj)
plot(roc_obj, col = "blue", main = "ROC Curve")
abline(a = 0, b = 1, lty = 2, col = "gray")

# Extract and display model coefficients
coefficients <- summary(model)$coefficients
print(coefficients)

# Live Data Prediction
new_data <- head(telecom_data) 
new_predictions <- predict(model, newdata = new_data, type = "response")
new_predicted_classes <- ifelse(new_predictions > 0.5, "1", "0")
print("Predictions on New Data:")
cbind(new_data, Prediction = new_predicted_classes)

"
Key Findings:
- Churn Rate: Approximately 14.49% of customers churned.
- Model Accuracy: The logistic regression model achieved an accuracy of 85.89% in predicting customer churn.

Key Predictors:
- Contract Renewal: Customers with shorter contracts are more likely to churn.
- Customer Service Calls: Higher numbers of customer service calls significantly increase churn risk.
- Day Minutes: Increased daily call duration is associated with a slight decrease in churn probability.

Next Steps:
  
Retention Strategies:
  Contract Incentives: Offer incentives for longer contracts, such as discounts or loyalty programs.
  
  Customer Service Improvement: Focus on improving customer service quality and reducing call volumes.
  - Implement proactive customer support measures (e.g., FAQs, chatbots).
  - Train customer service representatives to effectively address customer concerns.
  
  Targeted Campaigns:
  - Identify customers with high churn risk based on model predictions.
  - Offer personalized retention offers to these high-risk customers.
  - Data Usage Analysis: Investigate the relationship between data usage and churn further.
"