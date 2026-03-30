# Performance Test

Load test using k6

## Note

The exercise mentioned `/auth/login`, but that endpoint is not available in FakeRestAPI.

So I used `/api/v1/Activities` to run the test.

The requirements are still covered:

- ~20 TPS
- response time < 1.5s
- error rate < 3%

## Installation

```powershell
winget install k6
.\run-test.ps1
```

## Run tests

```powershell
.\run-test.ps1
```

## Reports

### Generate HTML_Report

```powershell
.\create-html-report.ps1
```

This will generate `report.html` and open it in your browser.

### Generate JSON data

```powershell
k6 run scripts/login.js --out json=results.json
```

## Structure

```text
├── scripts/
│   └── login.js           # main test
├── data/
│   └── users.csv         # data
├── config/
│   └── options.js        # config
├── utils/
│   └── helpers.js        # helpers
├── load-env.ps1          # env
├── run-test.ps1          # run
├── README.md             # Documentation
└── conclusions.txt       # Test results
