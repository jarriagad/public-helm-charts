{{/*
Expand the name of the chart.
*/}}
{{- define "resume.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "resume.fullname" -}}
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
{{- define "resume.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "resume.labels" -}}
helm.sh/chart: {{ include "resume.chart" . }}
{{ include "resume.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "resume.selectorLabels" -}}
app.kubernetes.io/name: {{ include "resume.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "resume.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "resume.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the config pvc
*/}}
{{- define "resume.configPvcName" -}}
{{- printf "%s-%s" (include "resume.fullname" .) "config" }}
{{- end }}

{{/*
Create the name of the movies pvc
*/}}
{{- define "resume.moviesPvcName" -}}
{{- printf "%s-%s" (include "resume.fullname" .) "movies" }}
{{- end }}

{{/*
Create the name of the tv pvc
*/}}
{{- define "resume.tvPvcName" -}}
{{- printf "%s-%s" (include "resume.fullname" .) "tv" }}
{{- end }}
