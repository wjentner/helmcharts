{{/*
Expand the name of the chart.
*/}}
{{- define "db-backup-retention.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "db-backup-retention.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "db-backup-retention.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "db-backup-retention.labels" -}}
helm.sh/chart: {{ include "db-backup-retention.chart" . }}
{{ include "db-backup-retention.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "db-backup-retention.selectorLabels" -}}
app.kubernetes.io/name: {{ include "db-backup-retention.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "db-backup-retention.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "db-backup-retention.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the role to use
*/}}
{{- define "db-backup-retention.rbac.role.name" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "db-backup-retention.fullname" .) .Values.rbac.role.name }}
{{- else }}
{{- default "default" .Values.rbac.role.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the role to use
*/}}
{{- define "db-backup-retention.rbac.roleBinding.name" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "db-backup-retention.fullname" .) .Values.rbac.roleBinding.name }}
{{- else }}
{{- default "default" .Values.rbac.roleBinding.name }}
{{- end }}
{{- end }}
