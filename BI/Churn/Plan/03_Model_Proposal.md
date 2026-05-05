# Step 3: Propose the Models for Churn Prediction

## Objective

Select and justify appropriate classification models for predicting customer churn, considering the binary nature of the target variable (~14% churn rate) and the need for both interpretability and predictive performance.

---

## Model Selection Criteria

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                     MODEL SELECTION CRITERIA                                │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  1. Target type: Binary classification ("Churn" / "No Churn")               │
│  2. Dataset size: 3,333 observations → no need for deep learning            │
│  3. Class imbalance: ~14% churn → needs robust handling                     │
│  4. Interpretability: Important for business insights                       │
│  5. Performance: High recall needed (false negatives are costly)            │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Proposed Models — Decision Flowchart

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    CHURN MODELLING — MODEL SELECTION FLOW                    │
└─────────────────────────────────────────────────────────────────────────────┘

                         ┌─────────────────────────────┐
                         │  Is the target binary?       │
                         │  Yes → Classification        │
                         └─────────────┬───────────────┘
                                       │
              ┌────────────────────────┼────────────────────────┐
              │                        │                        │
              ▼                        ▼                        ▼
┌─────────────────────────┐  ┌─────────────────────┐  ┌─────────────────────┐
│ Need interpretability?  │  │ Small dataset (<    │  │ Handle non-linear   │
│ Yes → Logistic Reg.     │  │ 10K)? Yes → Tree-   │  │ relationships?      │
│                         │  │ based methods work  │  │ Yes → Random Forest │
│                         │  │ well                │  │ or XGBoost          │
└───────────┬─────────────┘  └──────────┬──────────┘  └──────────┬──────────┘
            │                           │                        │
            └───────────┬───────────────┴────────────┬───────────┘
                        │                            │
                        ▼                            ▼
            ┌───────────────────────┐    ┌───────────────────────┐
            │  MODEL 1              │    │  MODEL 2              │
            │  Logistic Regression  │    │  Random Forest        │
            │                       │    │                       │
            │  • High interpret.    │    │  • High performance   │
            │  • Probability output │    │  • Feature importance │
            │  • Linear log-odds    │    │  • Non-linear capture │
            │  • Fast & simple      │    │  • No scaling needed  │
            └───────────┬───────────┘    └───────────┬───────────┘
                        │                            │
                        └───────────┬────────────────┘
                                    │
                                    ▼
                      ┌─────────────────────────────┐
                      │  CROSS-VALIDATION            │
                      │  5-fold CV on training set   │
                      │  Metric: F1, Recall, AUC     │
                      └─────────────────────────────┘
```

---

## Model 1: Logistic Regression

### Why Logistic Regression?

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    LOGISTIC REGRESSION — OVERVIEW                            │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  Formula:                                                                    │
│                                                                             │
│              P(Churn = 1 | x) = 1 / (1 + e^-(β₀ + β₁x₁ + ... + βₚxₚ))      │
│                                                                             │
│  Interpretation:                                                             │
│  • Coefficients β represent log-odds change per unit predictor increase     │
│  • exp(β) = Odds Ratio → e.g., exp(β)=2 means 2× odds of churn             │
│                                                                             │
│  ┌───────────────────────────────────────────────────────────────────────┐  │
│  │  ADVANTAGES                      │  DISADVANTAGES                     │  │
│  ├──────────────────────────────────┼────────────────────────────────────┤  │
│  │ ✓ Highly interpretable           │ ✗ Assumes linear log-odds         │  │
│  │ ✓ Fast to train                  │ ✗ Sensitive to multicollinearity  │  │
│  │ ✓ Calibrated probabilities       │ ✗ Struggles with non-linear       │  │
│  │ ✓ Works with small datasets      │   patterns                         │  │
│  │ ✓ Well-understood statistically  │ ✗ May underfit complex data       │  │
│  └───────────────────────────────────────────────────────────────────────┘  │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Implementation Plan

```r
# 1. Train-test split (70/30)
set.seed(42)
train_idx <- createDataPartition(churn$Churn, p = 0.70, list = FALSE)
train_set <- churn[train_idx, ]
test_set  <- churn[-train_idx, ]

# 2. Train logistic regression
log_model <- glm(Churn ~ ., data = train_set, family = binomial)

# 3. Predict on test set
log_probs <- predict(log_model, newdata = test_set, type = "response")
log_preds <- factor(ifelse(log_probs >= 0.5, "Churn", "No Churn"))

# 4. Evaluate
confusionMatrix(log_preds, test_set$Churn, positive = "Churn")
```

### Hyperparameters to Tune

| Parameter     | Description                          | Tuning Strategy           |
|---------------|--------------------------------------|---------------------------|
| Threshold     | Probability cut-off for classification| Tune via ROC curve       |
| Regularisation| L1 (Lasso) or L2 (Ridge)            | Use `glmnet` if overfitting|

---

## Model 2: Random Forest

### Why Random Forest?

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    RANDOM FOREST — OVERVIEW                                  │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  How it works:                                                               │
│  • Builds B decision trees on bootstrap samples                              │
│  • Each tree uses a random subset of features at each split                 │
│  • Final prediction = majority vote across all trees                       │
│                                                                             │
│                                                                             │
│  ┌───────────────────────────────────────────────────────────────────────┐  │
│  │  ADVANTAGES                      │  DISADVANTAGES                     │  │
│  ├──────────────────────────────────┼────────────────────────────────────┤  │
│  │ ✓ Captures non-linear patterns   │ ✗ Less interpretable (black-box)  │  │
│  │ ✓ Robust to outliers             │ ✗ More computationally expensive  │  │
│  │ ✓ No feature scaling needed      │ ✗ Requires hyperparameter tuning  │  │
│  │ ✓ Handles correlated features    │ ✗ May overfit if not tuned        │  │
│  │ ✓ Provides importance scores     │                                    │  │
│  └───────────────────────────────────────────────────────────────────────┘  │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Implementation Plan

```r
# 1. Train random forest
set.seed(42)
rf_model <- randomForest(Churn ~ ., data = train_set, 
                         ntree = 300, importance = TRUE)

# 2. Predict on test set
rf_preds <- predict(rf_model, newdata = test_set)

# 3. Evaluate
confusionMatrix(rf_preds, test_set$Churn, positive = "Churn")

# 4. Variable importance
varImpPlot(rf_model)
```

### Hyperparameters to Tune

| Parameter     | Description                          | Tuning Strategy                          |
|---------------|--------------------------------------|------------------------------------------|
| `ntree`       | Number of trees in the forest        | Start at 300, increase until plateau     |
| `mtry`        | Features considered at each split    | Try sqrt(p) ≈ 4-5, tune via `tuneRF()`  |
| `nodesize`    | Minimum terminal node size           | Default (1 for classif.), try 5-10       |

---

## (Optional) Model 3: Gradient Boosting (XGBoost)

For future iterations, consider:

| Aspect                        | Benefit                                      |
|-------------------------------|----------------------------------------------|
| Sequential boosting           | Often outperforms Random Forest               |
| Built-in regularisation       | Reduces overfitting                          |
| Handles class imbalance       | Can use `scale_pos_weight` parameter         |
| Feature importance            | Gain, cover, frequency metrics               |

---

## Evaluation Metrics

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    EVALUATION METRICS DEFINITIONS                           │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  For each model, we compute on the test set:                                │
│                                                                             │
│                    ┌─────────────────────────────────┐                     │
│                    │        CONFUSION MATRIX          │                     │
│                    ├─────────────────────┬───────────┤                     │
│                    │                     │  Churn?   │                     │
│                    │                     │ Yes │ No  │                     │
│                    ├─────────────────────┼─────┼─────┤                     │
│                    │ Predicted Yes       │ TP  │ FP  │  Precision=TP/(TP+FP)│
│                    │ Predicted No        │ FN  │ TN  │  Recall   =TP/(TP+FN)│
│                    └─────────────────────┴─────┴─────┘                     │
│                                                                             │
│  Metric         │ Formula               │ Why Important for Churn         │
│  ───────────────┼───────────────────────┼───────────────────────────────── │
│  Accuracy       │ (TP+TN) / Total       │ Overall correctness (misleading │
│                 │                       │ when imbalanced)                 │
│  Precision      │ TP / (TP+FP)          │ Cost of false alarms (wasted    │
│                 │                       │ retention resources)             │
│  Recall (Sens.) │ TP / (TP+FN)          │ Cost of missed churners (lost   │
│                 │                       │ revenue) — PRIORITY METRIC       │
│  F1 Score       │ 2*(P*R)/(P+R)         │ Harmonic mean of P & R          │
│  AUC-ROC        │ Area under ROC curve  │ Overall discriminative ability  │
│                 │                       │ across thresholds                │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Class Imbalance Strategy

Since ~86% of customers do NOT churn, standard models tend to predict "No Churn" for everyone.

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                 CLASS IMBALANCE HANDLING STRATEGIES                         │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  ┌──────────────────────┐     ┌─────────────────────────────────────────┐  │
│  │  Current approaches: │     │  Why they were NOT needed here:         │  │
│  ├──────────────────────┤     ├─────────────────────────────────────────┤  │
│  │ ✓ Use AUC & F1       │     │ • Random Forest handles imbalance      │  │
│  │ ✓ Use class weights  │     │   reasonably well via bootstrap        │  │
│  │ ✓ Threshold tuning   │     │ • "Churn" class is still ~467 obs      │  │
│  │                      │     │   enough for modelling                 │  │
│  │  Future options:     │     │ • If needed, add SMOTE for synthetic   │  │
│  │  • SMOTE oversampling│     │   oversampling of minority class       │  │
│  │  • Downsample No     │     │                                         │  │
│  └──────────────────────┘     └─────────────────────────────────────────┘  │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Task Checklist

- [x] Identify problem as binary classification with class imbalance
- [x] Select **Logistic Regression** for interpretability and baseline
- [x] Select **Random Forest** for high predictive performance
- [x] Define evaluation metrics: Accuracy, Precision, Recall, F1, AUC
- [x] Plan threshold tuning for probability cut-off optimisation
- [x] Note class imbalance and proposed mitigation strategies
- [x] (Optional) Note XGBoost as future enhancement
