Write-Host "Running k6 test and generating HTML report..." -ForegroundColor Green

k6 run scripts/login.js --summary-export=summary.json

if ($LASTEXITCODE -eq 0) {
    Write-Host "`nTest completed successfully!" -ForegroundColor Green
    Write-Host "Summary saved to: summary.json" -ForegroundColor Cyan
    Write-Host "`nYou can view the results in:" -ForegroundColor Yellow
    Write-Host "  - conclusions.txt" -ForegroundColor White
    Write-Host "  - textSummary.txt" -ForegroundColor White
    Write-Host "  - summary.json (for processing)" -ForegroundColor White
} else {
    Write-Host "`nTest failed!" -ForegroundColor Red
    exit 1
}
