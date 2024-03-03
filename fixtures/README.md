random-guids.txt

```bash
pwsh --Command "1..10000 | % { New-Guid | Select-Object -ExpandProperty Guid }" > tests/example/random-guids.txt
```
