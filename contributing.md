# WJentner Helm Charts

[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/wjentner-charts)](https://artifacthub.io/packages/search?repo=wjentner-charts)

## Development

1. Modify/extend chart.
2. Adjust documentation.
3. Adjust changelog.
4. Adjust Chart.yaml
5. `helm package -d docs ./db-backup-retention`
6. `helm repo index --url https://wjentner.github.io/helmcharts ./docs`
