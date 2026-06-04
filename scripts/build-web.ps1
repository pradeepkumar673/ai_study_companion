# Build StudySpark for web (release) and print output path.
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$root = Split-Path -Parent $PSScriptRoot

Push-Location $root
try {
    flutter pub get
    flutter build web --release --no-wasm-dry-run
    $out = Join-Path $root "build\web"
    Write-Host "Web build output: $out"
} finally {
    Pop-Location
}
