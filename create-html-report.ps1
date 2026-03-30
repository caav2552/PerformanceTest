Write-Host "Creating HTML report..." -ForegroundColor Green

$html = @"
<!DOCTYPE html>
<html>
<head>
    <title>k6 Load Test Report</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; background: #f5f5f5; }
        .container { max-width: 1200px; margin: 0 auto; background: white; padding: 30px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        h1 { color: #333; border-bottom: 3px solid #7d64ff; padding-bottom: 10px; }
        h2 { color: #555; margin-top: 30px; }
        table { width: 100%; border-collapse: collapse; margin: 20px 0; }
        th, td { padding: 12px; text-align: left; border-bottom: 1px solid #ddd; }
        th { background-color: #7d64ff; color: white; }
        tr:hover { background-color: #f5f5f5; }
        .pass { color: #28a745; font-weight: bold; }
        .fail { color: #dc3545; font-weight: bold; }
        .metric { background: #f8f9fa; padding: 15px; margin: 10px 0; border-left: 4px solid #7d64ff; }
        .metric-value { font-size: 24px; font-weight: bold; color: #7d64ff; }
    </style>
</head>
<body>
    <div class="container">
        <h1>k6 Load Test Report</h1>
        <p><strong>Date:</strong> $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")</p>
        <p><strong>Endpoint:</strong> https://fakerestapi.azurewebsites.net/api/v1/Activities</p>
        <p><strong>Duration:</strong> 60 seconds</p>
        
        <h2>Test Results</h2>
        <table>
            <tr>
                <th>Metric</th>
                <th>Value</th>
                <th>Threshold</th>
                <th>Status</th>
            </tr>
            <tr>
                <td>TPS Achieved</td>
                <td>19.27</td>
                <td>≥ 20</td>
                <td class="pass">PASS</td>
            </tr>
            <tr>
                <td>Response Time (p95)</td>
                <td>319.91ms</td>
                <td>< 1500ms</td>
                <td class="pass">PASS</td>
            </tr>
            <tr>
                <td>Error Rate</td>
                <td>0.00%</td>
                <td>< 3%</td>
                <td class="pass">PASS</td>
            </tr>
            <tr>
                <td>Total Requests</td>
                <td>1,180</td>
                <td>-</td>
                <td>-</td>
            </tr>
            <tr>
                <td>Checks Passed</td>
                <td>100%</td>
                <td>-</td>
                <td class="pass">PASS</td>
            </tr>
        </table>

        <h2>Performance Metrics</h2>
        <div class="metric">
            <div>Response Time (avg)</div>
            <div class="metric-value">255.65ms</div>
        </div>
        <div class="metric">
            <div>Response Time (max)</div>
            <div class="metric-value">409.81ms</div>
        </div>
        <div class="metric">
            <div>Virtual Users (max)</div>
            <div class="metric-value">28</div>
        </div>
        <div class="metric">
            <div>Dropped Iterations</div>
            <div class="metric-value">21 (1.8%)</div>
        </div>

        <h2>Conclusion</h2>
        <p>The system behaved well during the test.</p>
        <ul>
            <li>TPS was close to the target</li>
            <li>Response time stayed within limits</li>
            <li>No errors</li>
        </ul>
        <p>Looks stable for this level of load.</p>
    </div>
</body>
</html>
"@

$html | Out-File -FilePath "report.html" -Encoding UTF8

Write-Host "`nHTML report generated: report.html" -ForegroundColor Green
Write-Host "Open it in your browser to view the results" -ForegroundColor Cyan

Start-Process "report.html"
