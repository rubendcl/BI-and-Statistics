# Step 1: Identify the Data Sources

## Objective

Locate and document the raw data files used for churn analysis, understand their structure, origin, and the variables they contain.

---

## Data Source Overview

The churn analysis uses **two separate data files** that are joined by customer identifiers.

```
┌─────────────────────────────────────────────────────────────────────────┐
│                   CHURN ANALYSIS — DATA SOURCE IDENTIFICATION            │
└─────────────────────────────────────────────────────────────────────────┘

                                  ┌─────────────────────┐
                                  │  Telecom Provider     │
                                  │  (Internal Systems)   │
                                  └──────────┬──────────┘
                                             │
                    ┌────────────────────────┼────────────────────────┐
                    │                        │                        │
                    ▼                        ▼                        ▼
        ┌───────────────────┐  ┌─────────────────────┐  ┌───────────────────────┐
        │   Billing System  │  │   Customer Database │  │   Call Detail Records │
        │   (CSV Export)    │  │   (CSV Export)      │  │   (Excel .xls Export) │
        └─────────┬─────────┘  └──────────┬──────────┘  └───────────┬───────────┘
                  │                       │                        │
                  │                       │                        │
                  ▼                       ▼                        ▼
        ┌───────────────────┐  ┌─────────────────────┐  ┌───────────────────────┐
        │  ContractData.csv │  │ (demographics info  │  │    CallsData.xls      │
        │                   │  │  is embedded in the │  │                       │
        │  • Account info   │  │  ContractData file) │  │  • Call minutes/day   │
        │  • Plan details   │  └─────────────────────┘  │  • Call charges       │
        │  • Churn label    │                           │  • Customer service   │
        └─────────┬─────────┘                           └───────────┬───────────┘
                  │                                                 │
                  └────────────────────┬────────────────────────────┘
                                       │
                                       ▼
                          ┌─────────────────────────┐
                          │     Merged Dataset      │
                          │    (inner_join on       │
                          │   Phone + Area.Code)    │
                          └─────────────────────────┘
```

---

## Data File Details

### 1. Contract Data (`ContractData.csv`)

| Attribute        | Description                                              |
|------------------|----------------------------------------------------------|
| **Format**       | CSV (Comma-Separated Values)                             |
| **Rows**         | 3,333 customers                                          |
| **Origin**       | Billing / Customer database export                       |
| **Join Key**     | `Phone` + `Area.Code`                                    |

#### Variables

| Column             | Type      | Description                                       |
|--------------------|-----------|---------------------------------------------------|
| `State`            | Factor    | US state code (2-letter)                          |
| `Account.Length`   | Numeric   | Months the customer has been with the company     |
| `Area.Code`        | Numeric   | Area code of the customer's phone number          |
| `Phone`            | Character | Customer's phone number (unique identifier)       |
| `Int.l.Plan`       | Factor    | Whether the customer has an international plan    |
| `VMail.Plan`       | Factor    | Whether the customer has a voicemail plan         |
| `VMail.Message`    | Numeric   | Number of voicemail messages                      |
| `Day.Mins`         | Numeric   | Total day minutes used                            |
| `Day.Calls`        | Numeric   | Number of day calls                               |
| `Day.Charge`       | Numeric   | Total day charge ($)                              |
| `Eve.Mins`         | Numeric   | Total evening minutes used                        |
| `Eve.Calls`        | Numeric   | Number of evening calls                           |
| `Eve.Charge`       | Numeric   | Total evening charge ($)                          |
| `Night.Mins`       | Numeric   | Total night minutes used                          |
| `Night.Calls`      | Numeric   | Number of night calls                             |
| `Night.Charge`     | Numeric   | Total night charge ($)                            |
| `Intl.Mins`        | Numeric   | Total international minutes used                  |
| `Intl.Calls`       | Numeric   | Number of international calls                     |
| `Intl.Charge`      | Numeric   | Total international charge ($)                    |
| `CustServ.Calls`   | Numeric   | Number of customer service calls made             |
| **`Churn`**        | **Factor**| **Target variable: "Yes" / "No"**                 |

---

### 2. Calls Data (`CallsData.xls`)

| Attribute        | Description                                              |
|------------------|----------------------------------------------------------|
| **Format**       | Excel (.xls)                                             |
| **Rows**         | 3,333 customers                                          |
| **Origin**       | Call Detail Records (CDR) system export                  |
| **Join Key**     | `Phone` + `Area Code`                                    |

#### Variables

| Column         | Type      | Description                                    |
|----------------|-----------|------------------------------------------------|
| `Phone`        | Character | Customer's phone number (unique identifier)    |
| `Area Code`    | Numeric   | Area code                                      |
| `Day Mins`     | Numeric   | (Same as ContractData) — duplicate column      |
| `Day Calls`    | Numeric   | (Same as ContractData) — duplicate column      |
| `Day Charge`   | Numeric   | (Same as ContractData) — duplicate column      |
| `Eve Mins`     | Numeric   | (Same as ContractData) — duplicate column      |
| `Eve Calls`    | Numeric   | (Same as ContractData) — duplicate column      |
| `Eve Charge`   | Numeric   | (Same as ContractData) — duplicate column      |
| `Night Mins`   | Numeric   | (Same as ContractData) — duplicate column      |
| `Night Calls`  | Numeric   | (Same as ContractData) — duplicate column      |
| `Night Charge` | Numeric   | (Same as ContractData) — duplicate column      |
| `Intl Mins`    | Numeric   | (Same as ContractData) — duplicate column      |
| `Intl Calls`   | Numeric   | (Same as ContractData) — duplicate column      |
| `Intl Charge`  | Numeric   | (Same as ContractData) — duplicate column      |

> **Note:** The `CallsData.xls` contains **duplicate columns** (call minutes, charges, etc.) that overlap with `ContractData.csv`. After the join, these duplicates should be identified and removed.

---

## Data Dictionary — Merged Dataset

After joining both files on `Phone` + `Area.Code`, the merged dataset contains:

```
┌─────────────────────────────────────────────────────────────────────────┐
│                  MERGED DATASET — FINAL VARIABLES                        │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│  ┌─────────────────────────────────────────────────────────────────┐   │
│  │  PREDICTOR VARIABLES (Features)                                 │   │
│  ├─────────────────────────────────────────────────────────────────┤   │
│  │  Continuous:                                                     │   │
│  │    Account.Length | Day.Mins | Day.Calls | Day.Charge           │   │
│  │    Eve.Mins      | Eve.Calls | Eve.Charge                      │   │
│  │    Night.Mins    | Night.Calls | Night.Charge                  │   │
│  │    Intl.Mins     | Intl.Calls | Intl.Charge                    │   │
│  │    CustServ.Calls | VMail.Message                               │   │
│  │                                                                 │   │
│  │  Categorical:                                                    │   │
│  │    State | Area.Code | Int.l.Plan | VMail.Plan                  │   │
│  │                                                                 │   │
│  │  Identifier (excluded from modelling):                          │   │
│  │    Phone                                                         │   │
│  └─────────────────────────────────────────────────────────────────┘   │
│                                                                         │
│  ┌─────────────────────────────────────────────────────────────────┐   │
│  │  TARGET VARIABLE (Response)                                     │   │
│  ├─────────────────────────────────────────────────────────────────┤   │
│  │  Churn: Binary factor ["No Churn" / "Churn"]                    │   │
│  │       ~14% churn rate (class imbalance)                         │   │
│  └─────────────────────────────────────────────────────────────────┘   │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
```

---

## Task Checklist

- [x] Locate the two source files: `ContractData.csv` and `CallsData.xls`
- [x] Identify the join keys: `Phone` + `Area.Code`
- [x] List all variables and their types for each source
- [x] Identify the target variable: `Churn`
- [x] Note the class imbalance (~14% churners)
- [x] Document duplicate columns between the two files
- [x] Remove identifier columns (`Phone`, `State`, `Area.Code`) before modelling
