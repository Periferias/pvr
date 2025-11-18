{{/*
Expand the name of the chart.
*/}}
{{- define "nixpacks-cloudnative-app.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "nixpacks-cloudnative-app.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name (include "nixpacks-cloudnative-app.name" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end }}

{{/*
Common labels
*/}}
{{- define "nixpacks-cloudnative-app.labels" -}}
app.kubernetes.io/name: {{ include "nixpacks-cloudnative-app.name" . }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "nixpacks-cloudnative-app.selectorLabels" -}}
app.kubernetes.io/name: {{ include "nixpacks-cloudnative-app.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

