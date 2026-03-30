param(
    [string]$TestFile = "scripts/login.js",
    [switch]$Help
)

if ($Help) {
    Write-Host @"
Usage: .\run-test.ps1 [-TestFile <script.js>] [-Help]

Options:
  -TestFile    Specify the k6 test script to run (default: login-test.js)
  -Help        Show this help message

Examples:
  .\run-test.ps1
  .\run-test.ps1 -TestFile login-test.js

"@ -ForegroundColor Cyan
    exit 0
}

.\load-env.ps1

if ($?) {
    Write-Host "`nRunning k6 test: $TestFile" -ForegroundColor Yellow
    Write-Host "==========================================`n" -ForegroundColor Yellow
    
    k6 run $TestFile
} else {
    Write-Host "Failed to load environment variables. Exiting..." -ForegroundColor Red
    exit 1
}
