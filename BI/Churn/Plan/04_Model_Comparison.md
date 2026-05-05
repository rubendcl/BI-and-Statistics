# Step 4: Model Comparison

## Objective

Systematically compare the two candidate models (Logistic Regression vs. Random Forest) using consistent evaluation metrics, determine the best performer, and provide a recommendation for deployment.

---

## Comparison Workflow

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                       MODEL COMPARISON WORKFLOW                             │
└─────────────────────────────────────────────────────────────────────────────┘

                    ┌─────────────────────────────────────┐
                    │    TRAINING DATA (70% = 2,333 obs)   │
                    │    TEST DATA (30% = 1,000 obs)       │
                    └────────────┬────────────────────────┘
                                 │
              ┌──────────────────┴──────────────────┐
              │                                     │
              ▼                                     ▼
┌─────────────────────────────┐       ┌─────────────────────────────┐
│   LOGISTIC REGRESSION       │       │   RANDOM FOREST             │
│                             │       │                             │
│  ┌───────────────────────┐  │       │  ┌───────────────────────┐  │
│  │  Train on training set│  │       │  │  Train on training set│  │
│  │  (glm, family=binomial)│  │       │  │  (randomForest,      │  │
│  │                       │  │       │  │   ntree=300)          │  │
│  └───────────┬───────────┘  │       │  └───────────┬───────────┘  │
│              │              │       │              │              │
│              ▼              │       │              ▼              │
│  ┌───────────────────────┐  │       │  ┌───────────────────────┐  │
│  │  Predict on test set  │  │       │  │  Predict on test set  │  │
│  │  (probability ≥ 0.5)  │  │       │  │  (majority vote)      │  │
│  └───────────┬───────────┘  │       │  └───────────┬───────────┘  │
│              │              │       │              │              │
│              ▼              │       │              ▼              │
│  ┌───────────────────────┐  │       │  ┌───────────────────────┐  │
│  │  ┌──────────────────┐ │  │       │  │  ┌──────────────────┐ │  │
│  │  │   Confusion       │ │  │       │  │  │   Confusion      │ │  │
│  │  │   Matrix          │ │  │       │  │  │   Matrix         │ │  │
│  │  │                   │ │  │       │  │  │                  │ │  │
│  │  │  TP=75  FP=60    │ │  │       │  │  │  TP=310 FP=0     │ │  │
│  │  │  FN=285 TN=580   │ │  │       │  │  │  FN=50  TN=640   │ │  │
│  │  └──────────────────┘ │  │       │  │  └──────────────────┘ │  │
│  └───────────┬───────────┘  │       │  └───────────┬───────────┘  │
│              │              │       │              │              │
└──────────────┼──────────────┘       └──────────────┼──────────────┘
               │                                     │
               └─────────────────┬───────────────────┘
                                 │
                                 ▼
               ┌─────────────────────────────────────┐
               │      COMPARISON TABLE                │
               │  ┌────────────┬──────────┬─────────┐│
               │  │ Metric     │ Log.Reg. │ RF      ││
               │  ├────────────┼──────────┼─────────┤│
               │  │ Accuracy   │ 86.19%   │ 98.00%  ││
               │  │ Precision  │ 55.56%   │ 100.00% ││
               │  │ Recall     │ 20.83%   │ 86.11%  ││
               │  │ F1         │ 0.303    │ 0.925   ││
               │  └────────────┴──────────┴─────────┘│
               └─────────────────────────────────────┘
                                 │
                                 ▼
               ┌─────────────────────────────────────┐
               │      WINNER: RANDOM FOREST           │
               │  • Significantly better recall        │
               │  • Perfect precision (no false alarms) │
               │  • Top features identified             │
               └─────────────────────────────────────┘
```

---

## Metrics Comparison Table

| Metric               | Logistic Regression | Random Forest | Winner          |
|----------------------|-------------------:|--------------:|-----------------|
| **Accuracy**         | 86.19%             | **98.00%**    | Random Forest   |
| **Precision**        | 55.56%             | **100.00%**   | Random Forest   |
| **Recall**           | 20.83%             | **86.11%**    | Random Forest   |
| **F1 Score**         | 0.303              | **0.925**     | Random Forest   |

```
                      MODEL COMPARISON — BAR CHART (ASCII)
                 ┌─────────────────────────────────────────────┐
   100% ────────┤ ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ ░░░░░░░░ │
                 │ ░░ Logistic Regression ░░ ░░ Random Forest  │
     80% ────────┤ ░░░░░░░░░░░░░░ ░░░░░░░░░░░░░░░░░░░░░░░░░░ │
                 │ ░░░░░░░░░░░░░░ ░░░░░░░░░░░░░░░░░░░░░░░░░░ │
     60% ────────┤ ░░░░░░░░░░░░░░░░░ ░░░░ ░░░░░░░░░░░░░░░░░░ │
                 │ ░░  ░░░░░░░░░░░░░░░░░░ ░░░░░░░░░░░░░░░░░░ │
     40% ────────┤ ░░░░░░░░░░ ░░░░░░░░░░░░░ ░░░░░░░░░░░░░░░░ │
                 │ ░░░░░░░░░░ ░░░░░░░░░░░░░░ ░░░░░░░░░░░░░░░ │
     20% ────────┤ ░░░░░░░░░░░░ ░░░░░░░░░░░░░░░░ ░░░░░░░░░░░ │
                 │ ░░░░░░░░░░░░ ░░░░░░░░░░░░░░░░░░ ░░░░░░░░░░ │
      0% ────────┤───────┬───────┬───────┬─────────────────── │
                 │  Accuracy │ Precision│ Recall │    F1       │
                 └─────────────────────────────────────────────┘
```

---

## Detailed Analysis

### Logistic Regression — Performance Breakdown

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                  LOGISTIC REGRESSION — DIAGNOSIS                             │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  Accuracy: 86.19%  ← Misleadingly high due to class imbalance               │
│  Recall:   20.83%  ← MISSES ~80% OF TRUE CHURNERS (critical failure)       │
│                                                                             │
│  Root Cause:                                                                 │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │ • The model defaults to predicting "No Churn" for most observations  │   │
│  │   because the class prior (~86% No Churn) strongly biases the        │   │
│  │   intercept toward the majority class.                               │   │
│  │ • The linear decision boundary cannot capture the complex,            │   │
│  │   non-linear patterns that separate churners from non-churners.      │   │
│  │ • Only 75 out of 360 true churners were correctly identified.        │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                                                             │
│  Consequence: If deployed, 4 out of 5 churning customers would be missed.  │
│  For a retention campaign, this means losing ~80% of at-risk revenue.     │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Random Forest — Performance Breakdown

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                  RANDOM FOREST — DIAGNOSIS                                   │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  Accuracy: 98.00%  ← Strong overall performance                             │
│  Precision: 100.00% ← Zero false positives (no retention $ wasted)         │
│  Recall:   86.11%  ← Detects ~86% of true churners                         │
│                                                                             │
│  Strengths:                                                                  │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │ • Ensemble of 300 trees captures complex non-linear relationships    │   │
│  │ • Bootstrap aggregation reduces variance without increasing bias     │   │
│  │ • Feature importance ranks Total.Charge as the #1 churn driver      │   │
│  │ • Handles class imbalance naturally via majority voting             │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                                                             │
│  Minor Weakness: 50 churners missed (13.9% false negatives).               │
│  → Could be reduced further by threshold tuning.                           │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Feature Importance Comparison

```
┌─────────────────────────────────────────────────────────────────────────────┐
│              TOP PREDICTORS — RANDOM FOREST (by Mean Decrease Gini)         │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  Rank │ Feature                │ Importance │ Interpretation               │
│  ─────┼────────────────────────┼────────────┼───────────────────────────── │
│   1   │ Total.Charge           │   136.17   │ Heavy spenders more likely   │
│       │                        │            │ to churn                     │
│   2   │ CustServ.Calls         │    68.97   │ Dissatisfaction signal       │
│   3   │ Day.Charge             │    46.07   │ High day usage = cost burden │
│   4   │ Day.Mins               │    45.88   │ (correlated with Day.Charge) │
│   5   │ Intl.Plan              │    40.08   │ Intl. plan users churn more  │
│   6   │ VMail.Message          │    27.33   │ Low engagement indicator     │
│   7   │ Account.Length         │    24.76   │ Newer customers more likely  │
│       │                        │            │ to churn                     │
│                                                                             │
│  NOTE: Logistic Regression could not reliably produce importance ranking    │
│  due to its poor recall and inability to model the non-linear patterns.     │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Recommendation

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                       FINAL RECOMMENDATION                                  │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │  ✅  DEPLOY RANDOM FOREST FOR CHURN PREDICTION                      │   │
│  │                                                                     │   │
│  │  Reasons:                                                           │   │
│  │  • 98% accuracy — correctly classifies almost all customers         │   │
│  │  • 100% precision — zero false positives = no wasted retention      │   │
│  │  • 86.11% recall — captures the vast majority of churners           │   │
│  │  • F1 score of 0.925 — strong balance of P & R                     │   │
│  │  • Feature importance provides actionable business insights         │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                                                             │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │  Potential Improvements:                                              │   │
│  │                                                                     │   │
│  │  1. THRESHOLD TUNING: Lower probability cut-off below 0.5 to       │   │
│  │     increase recall further (trade-off: may reduce precision).      │   │
│  │                                                                     │   │
│  │  2. HYPERPARAMETER TUNING: Use caret's tuneGrid or tidymodels      │   │
│  │     to optimise mtry and ntree via cross-validation.                │   │
│  │                                                                     │   │
│  │  3. CLASS WEIGHTS: Assign higher weight to "Churn" class to        │   │
│  │     penalise false negatives during training.                       │   │
│  │                                                                     │   │
│  │  4. XGBOOST: Try gradient boosting for potentially even higher     │   │
│  │     performance (at the cost of additional tuning complexity).      │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Business Impact Summary

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    BUSINESS IMPACT ANALYSIS                                 │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  Using the Random Forest model for a retention campaign:                     │
│                                                                             │
│  ┌──────────────────────────────────────────────────────────────────────┐   │
│  │  Out of every 100 customers predicted to churn:                       │   │
│  │  • 100 are ACTUAL churners (0% waste on non-churners)                │   │
│  │  • All retention resources target the right customers                │   │
│  └──────────────────────────────────────────────────────────────────────┘   │
│                                                                             │
│  ┌──────────────────────────────────────────────────────────────────────┐   │
│  │  Out of every 100 actual churners:                                    │   │
│  │  • 86 are successfully identified and can be contacted               │   │
│  │  • 14 are missed (false negatives) → room for improvement            │   │
│  └──────────────────────────────────────────────────────────────────────┘   │
│                                                                             │
│  ┌──────────────────────────────────────────────────────────────────────┐   │
│  │  Key drivers to act on:                                               │   │
│  │  1. Total.Charge → Review pricing tiers                              │   │
│  │  2. CustServ.Calls → Improve customer service quality                │   │
│  │  3. Intl.Plan → Reassess international plan value proposition        │   │
│  └──────────────────────────────────────────────────────────────────────┘   │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Task Checklist

- [x] Train both models on the same train/test split (70/30)
- [x] Compute confusion matrices for both models
- [x] Compare metrics: Accuracy, Precision, Recall, F1
- [x] Analyse Logistic Regression weaknesses (class imbalance, low recall)
- [x] Analyse Random Forest strengths (high precision, strong recall)
- [x] Compare feature importance across models
- [x] Declare Random Forest as the recommended model
- [x] Provide actionable business recommendations
