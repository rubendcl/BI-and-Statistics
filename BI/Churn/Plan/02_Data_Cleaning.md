# Step 2: Data Cleaning Planification

## Objective

Define a systematic pipeline to transform raw data into a clean, analysis-ready dataset — handling duplicates, missing values, type conversions, and feature engineering.

---

## Data Cleaning Pipeline — Overview

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                       DATA CLEANING PIPELINE FLOWCHART                       │
└─────────────────────────────────────────────────────────────────────────────┘

                         ┌─────────────────────────────┐
                         │     RAW DATA FILES           │
                         │  ContractData.csv            │
                         │  CallsData.xls               │
                         └─────────────┬───────────────┘
                                       │
                                       ▼
                    ┌─────────────────────────────────────┐
                    │  STEP 1: LOAD & INSPECT             │
                    │  • Load CSV (.csv)                  │
                    │  • Load Excel (.xls)                │
                    │  • Use str(), summary(), glimpse()  │
                    │  • Check for NAs, zeros, outliers   │
                    └─────────────────┬───────────────────┘
                                      │
                                      ▼
                    ┌─────────────────────────────────────┐
                    │  STEP 2: STANDARDISE JOIN KEYS      │
                    │  • Rename `Area Code` → Area.Code   │
                    │    (align with contract naming)     │
                    │  • Ensure same data type on         │
                    │    Phone and Area.Code in both      │
                    │    data frames                      │
                    └─────────────────┬───────────────────┘
                                      │
                                      ▼
                    ┌─────────────────────────────────────┐
                    │  STEP 3: JOIN & MERGE               │
                    │  • inner_join(contract, calls,      │
                    │    by = c("Phone", "Area.Code"))    │
                    │  • Check row count consistency      │
                    │  • Drop duplicate .x / .y columns   │
                    │    created by the join              │
                    └─────────────────┬───────────────────┘
                                      │
                                      ▼
                    ┌─────────────────────────────────────┐
                    │  STEP 4: SANITISE COLUMN NAMES      │
                    │  • make.names() to replace spaces   │
                    │    and special chars with dots      │
                    │  • Ensures formula interfaces       │
                    │    (glm, randomForest) work         │
                    └─────────────────┬───────────────────┘
                                      │
                                      ▼
                    ┌─────────────────────────────────────┐
                    │  STEP 5: TYPE CONVERSIONS           │
                    │  • Churn   → factor (2 levels)      │
                    │  • Int.l.Plan → factor (2 levels)   │
                    │  • VMail.Plan → factor (2 levels)   │
                    │  • State   → factor                 │
                    │  • All numeric vars → numeric       │
                    └─────────────────┬───────────────────┘
                                      │
                                      ▼
                    ┌─────────────────────────────────────┐
                    │  STEP 6: HANDLE MISSING VALUES      │
                    │  • Check with sum(is.na())          │
                    │  • If any found:                    │
                    │    - Continuous: median imputation  │
                    │    - Categorical: mode imputation   │
                    │    - Or listwise deletion if <5%    │
                    └─────────────────┬───────────────────┘
                                      │
                                      ▼
                    ┌─────────────────────────────────────┐
                    │  STEP 7: FEATURE ENGINEERING        │
                    │  • Create Total.Charge:             │
                    │    Day.Charge + Eve.Charge +        │
                    │    Night.Charge + Intl.Charge       │
                    │  • (Optional) Create ratio features │
                    │  • (Optional) Create interaction    │
                    │    terms if needed                  │
                    └─────────────────┬───────────────────┘
                                      │
                                      ▼
                    ┌─────────────────────────────────────┐
                    │  STEP 8: REMOVE IDENTIFIERS         │
                    │  • Drop: Phone, State, Area.Code    │
                    │    (not useful for prediction)      │
                    └─────────────────┬───────────────────┘
                                      │
                                      ▼
                    ┌─────────────────────────────────────┐
                    │     CLEAN DATASET READY FOR          │
                    │     EXPLORATORY ANALYSIS & MODELLING │
                    └─────────────────────────────────────┘
```

---

## Detailed Step-by-Step

### Step 1: Load & Inspect

```r
# Load data
calls    <- read_xls("CallsData.xls")
contract <- read.csv("ContractData.csv", stringsAsFactors = TRUE)

# Inspect
str(calls)
str(contract)
summary(calls)
summary(contract)
```

| Check                  | Expected Result                        |
|------------------------|----------------------------------------|
| Number of rows         | 3,333 in both files                    |
| Missing values (NAs)   | 0 (no missing data expected)           |
| Zero-variance columns  | None expected                          |
| Outliers               | Check via boxplots in EDA phase        |

---

### Step 2: Standardise Join Keys

```
┌──────────────────────────────────────────────────────────────┐
│                    JOIN KEY STANDARDISATION                   │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│  CallsData.xls                ContractData.csv               │
│  ────────────────             ────────────────               │
│  "Phone"    (char)       ↔   "Phone"     (char)             │
│  "Area Code" (num)       →   "Area.Code" (num)   [RENAME]   │
│                                                              │
│  Action: calls <- calls %>%                                  │
│            rename(Area.Code = `Area Code`)                   │
│                                                              │
└──────────────────────────────────────────────────────────────┘
```

---

### Step 3: Join & Merge

```r
churn <- inner_join(contract, calls, by = c("Phone", "Area.Code"))
```

**Post-join checks:**

| Check                  | Action                                 |
|------------------------|----------------------------------------|
| Row count unchanged?   | If dropped, investigate mismatches     |
| Duplicate columns?     | Remove `.x` / `.y` suffixed duplicates |
| Duplicate rows?        | Use `distinct()` to deduplicate        |

---

### Step 4: Sanitise Column Names

```r
names(churn) <- make.names(names(churn), unique = TRUE)
```

This ensures R formula notation works correctly (e.g., `Area Code` → `Area.Code`).

---

### Step 5: Type Conversions

```
┌─────────────────────────────────────────────────────────────────────┐
│                     TARGET TYPE CONVERSIONS                          │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│  Original → Cleaned                                                  │
│  ─────────────────────                                             │
│  Churn      : chr "Yes"/"No" → factor("No Churn", "Churn")         │
│  Int.l.Plan : chr "yes"/"no" → factor("No Intl Plan", "Intl Plan") │
│  VMail.Plan : chr "yes"/"no" → factor("No VMail", "VMail")         │
│  State      : chr "AL","NY"... → factor (drop unused levels)       │
│  All others : already numeric → keep as numeric                     │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

---

### Step 6: Handle Missing Values

**Process:**

```
┌─────────────────────────────────────────────────────────────────┐
│                  MISSING VALUE HANDLING STRATEGY                │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌───────────────────────────────────────────────┐             │
│  │  Detect: sum(is.na(churn))                    │             │
│  │  Visualise: visdat::vis_miss(churn)           │             │
│  └───────────────────────────────────────────────┘             │
│                          │                                      │
│                          ▼                                      │
│  ┌───────────────────────────────────────────────┐             │
│  │  If NA found:                                  │             │
│  │  • Numeric columns → median imputation         │             │
│  │  • Factor columns  → mode imputation           │             │
│  │  • If <5% total NAs → listwise deletion        │             │
│  └───────────────────────────────────────────────┘             │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

### Step 7: Feature Engineering

```
┌─────────────────────────────────────────────────────────────────────┐
│                      FEATURE ENGINEERING                            │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│  Primary Feature (already implemented in analysis):                  │
│                                                                     │
│  Total.Charge = Day.Charge + Eve.Charge + Night.Charge + Intl.Charge│
│                                                                     │
│  Optional Features (to consider):                                   │
│                                                                     │
│  • Avg.Call.Duration = Total.Mins / Total.Calls                     │
│  • Day.Use.Ratio    = Day.Mins / (Day.Mins + Eve.Mins + Night.Mins) │
│  • High.CustServ    = ifelse(CustServ.Calls >= 3, 1, 0)            │
│  • Charge.Per.Min   = Total.Charge / Total.Mins                    │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

---

### Step 8: Remove Identifiers

```r
churn_clean <- churn %>%
  select(-Phone, -State, -Area.Code)
```

These columns are removed because:
- **Phone**: Unique identifier, no predictive value
- **State**: Too many levels (50+), no clear churn signal
- **Area.Code**: Near-constant if data is from a single region

---

## Final Clean Dataset — Summary

| Metric                | Value                         |
|-----------------------|-------------------------------|
| Rows                  | 3,333                         |
| Columns               | 21 → **19** (after dropping)  |
| Missing values        | 0                             |
| Continuous predictors | 15                            |
| Categorical predictors| 2 (Int.l.Plan, VMail.Plan)   |
| Target variable       | Churn (binary factor)         |
| Class distribution    | ~86% No Churn / ~14% Churn    |

---

## Task Checklist

- [x] Load both data sources and inspect their structure
- [x] Standardise join key column names
- [x] Merge files with `inner_join()` on `Phone` + `Area.Code`
- [x] Sanitise column names with `make.names()`
- [x] Convert target and categorical variables to factors
- [x] Check for and handle missing values (if any)
- [x] Create engineered feature: `Total.Charge`
- [x] Remove identifier columns (`Phone`, `State`, `Area.Code`)
