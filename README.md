# PerformanceTest

Performance Test with k6

## Installation

```powershell
winget install k6
.\run-test.ps1
```

## Run tests

```powershell
.\run-test.ps1
```

## Structure

```text
├── scripts/
│   └── login.js          # Test script
├── data/
│   └── users.csv         # Test data
├── config/
│   └── options.js        # Test configuration
├── utils/
│   └── helpers.js        # Helper functions
├── load-env.ps1          # Load variables
├── run-test.ps1          # Run tests
├── README.md             # Documentation
└── conclusions.txt       # Test results
