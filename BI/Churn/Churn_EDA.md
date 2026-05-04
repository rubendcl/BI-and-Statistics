Churn Data Exploration
================
Ruben Cabrera
2026-05-04

## Load Libraries

``` r
library(readxl)
```

## Load Data

``` r
calls    <- read_xls("CallsData.xls")
contract <- read.csv("ContractData.csv", stringsAsFactors = TRUE)
```

## Calls Data

### Structure

``` r
str(calls)
```

    ## tibble [3,333 × 16] (S3: tbl_df/tbl/data.frame)
    ##  $ VMail Message : num [1:3333] 25 26 0 0 0 0 24 0 0 37 ...
    ##  $ Day Mins      : num [1:3333] 265 162 243 299 167 ...
    ##  $ Eve Mins      : num [1:3333] 197.4 195.5 121.2 61.9 148.3 ...
    ##  $ Night Mins    : num [1:3333] 245 254 163 197 187 ...
    ##  $ Intl Mins     : num [1:3333] 10 13.7 12.2 6.6 10.1 6.3 7.5 7.1 8.7 11.2 ...
    ##  $ CustServ Calls: num [1:3333] 1 1 0 2 3 0 3 0 1 0 ...
    ##  $ Day Calls     : num [1:3333] 110 123 114 71 113 98 88 79 97 84 ...
    ##  $ Day Charge    : num [1:3333] 45.1 27.5 41.4 50.9 28.3 ...
    ##  $ Eve Calls     : num [1:3333] 99 103 110 88 122 101 108 94 80 111 ...
    ##  $ Eve Charge    : num [1:3333] 16.78 16.62 10.3 5.26 12.61 ...
    ##  $ Night Calls   : num [1:3333] 91 103 104 89 121 118 118 96 90 97 ...
    ##  $ Night Charge  : num [1:3333] 11.01 11.45 7.32 8.86 8.41 ...
    ##  $ Intl Calls    : num [1:3333] 3 3 5 7 3 6 7 6 4 5 ...
    ##  $ Intl Charge   : num [1:3333] 2.7 3.7 3.29 1.78 2.73 1.7 2.03 1.92 2.35 3.02 ...
    ##  $ Area Code     : num [1:3333] 415 415 415 408 415 510 510 415 408 415 ...
    ##  $ Phone         : chr [1:3333] "382-4657" "371-7191" "358-1921" "375-9999" ...

### Summary

``` r
summary(calls)
```

    ##  VMail Message       Day Mins        Eve Mins       Night Mins   
    ##  Min.   : 0.000   Min.   :  0.0   Min.   :  0.0   Min.   : 23.2  
    ##  1st Qu.: 0.000   1st Qu.:143.7   1st Qu.:166.6   1st Qu.:167.0  
    ##  Median : 0.000   Median :179.4   Median :201.4   Median :201.2  
    ##  Mean   : 8.099   Mean   :179.8   Mean   :201.0   Mean   :200.9  
    ##  3rd Qu.:20.000   3rd Qu.:216.4   3rd Qu.:235.3   3rd Qu.:235.3  
    ##  Max.   :51.000   Max.   :350.8   Max.   :363.7   Max.   :395.0  
    ##    Intl Mins     CustServ Calls    Day Calls       Day Charge   
    ##  Min.   : 0.00   Min.   :0.000   Min.   :  0.0   Min.   : 0.00  
    ##  1st Qu.: 8.50   1st Qu.:1.000   1st Qu.: 87.0   1st Qu.:24.43  
    ##  Median :10.30   Median :1.000   Median :101.0   Median :30.50  
    ##  Mean   :10.24   Mean   :1.563   Mean   :100.4   Mean   :30.56  
    ##  3rd Qu.:12.10   3rd Qu.:2.000   3rd Qu.:114.0   3rd Qu.:36.79  
    ##  Max.   :20.00   Max.   :9.000   Max.   :165.0   Max.   :59.64  
    ##    Eve Calls       Eve Charge     Night Calls     Night Charge   
    ##  Min.   :  0.0   Min.   : 0.00   Min.   : 33.0   Min.   : 1.040  
    ##  1st Qu.: 87.0   1st Qu.:14.16   1st Qu.: 87.0   1st Qu.: 7.520  
    ##  Median :100.0   Median :17.12   Median :100.0   Median : 9.050  
    ##  Mean   :100.1   Mean   :17.08   Mean   :100.1   Mean   : 9.039  
    ##  3rd Qu.:114.0   3rd Qu.:20.00   3rd Qu.:113.0   3rd Qu.:10.590  
    ##  Max.   :170.0   Max.   :30.91   Max.   :175.0   Max.   :17.770  
    ##    Intl Calls      Intl Charge      Area Code        Phone          
    ##  Min.   : 0.000   Min.   :0.000   Min.   :408.0   Length:3333       
    ##  1st Qu.: 3.000   1st Qu.:2.300   1st Qu.:408.0   Class :character  
    ##  Median : 4.000   Median :2.780   Median :415.0   Mode  :character  
    ##  Mean   : 4.479   Mean   :2.765   Mean   :437.2                     
    ##  3rd Qu.: 6.000   3rd Qu.:3.270   3rd Qu.:510.0                     
    ##  Max.   :20.000   Max.   :5.400   Max.   :510.0

## Contract Data

### Structure

``` r
str(contract)
```

    ## 'data.frame':    3333 obs. of  7 variables:
    ##  $ Account.Length: int  128 107 137 84 75 118 121 147 117 141 ...
    ##  $ Churn         : int  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ Int.l.Plan    : int  0 0 0 1 1 1 0 1 0 1 ...
    ##  $ VMail.Plan    : int  1 1 0 0 0 0 1 0 0 1 ...
    ##  $ State         : Factor w/ 51 levels "AK","AL","AR",..: 17 36 32 36 37 2 20 25 19 50 ...
    ##  $ Area.Code     : int  415 415 415 408 415 510 510 415 408 415 ...
    ##  $ Phone         : Factor w/ 3333 levels "327-1058","327-1319",..: 1927 1576 1118 1708 111 2254 1048 81 292 118 ...

### Summary

``` r
summary(contract)
```

    ##  Account.Length      Churn          Int.l.Plan        VMail.Plan    
    ##  Min.   :  1.0   Min.   :0.0000   Min.   :0.00000   Min.   :0.0000  
    ##  1st Qu.: 74.0   1st Qu.:0.0000   1st Qu.:0.00000   1st Qu.:0.0000  
    ##  Median :101.0   Median :0.0000   Median :0.00000   Median :0.0000  
    ##  Mean   :101.1   Mean   :0.1449   Mean   :0.09691   Mean   :0.2766  
    ##  3rd Qu.:127.0   3rd Qu.:0.0000   3rd Qu.:0.00000   3rd Qu.:1.0000  
    ##  Max.   :243.0   Max.   :1.0000   Max.   :1.00000   Max.   :1.0000  
    ##                                                                     
    ##      State        Area.Code          Phone     
    ##  WV     : 106   Min.   :408.0   327-1058:   1  
    ##  MN     :  84   1st Qu.:408.0   327-1319:   1  
    ##  NY     :  83   Median :415.0   327-3053:   1  
    ##  AL     :  80   Mean   :437.2   327-3587:   1  
    ##  OH     :  78   3rd Qu.:510.0   327-3850:   1  
    ##  OR     :  78   Max.   :510.0   327-3954:   1  
    ##  (Other):2824                   (Other) :3327
