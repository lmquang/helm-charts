{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "snipeit.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "snipeit.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "snipeit.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name for the mysql requirement.
*/}}
{{- define "snipeit.mysqlFullname" -}}
{{- $mysqlContext := dict "Values" .Values.mysql "Release" .Release "Chart" (dict "Name" "mysql") -}}
{{ template "mysql.fullname" $mysqlContext }}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "snipeit.labels" -}}
app: {{ include "snipeit.name" . }}
chart: {{ include "snipeit.chart" . }}
release: {{ .Release.Name }}
heritage: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "snipeit.selector" -}}
app: {{ include "snipeit.name" . }}
release: {{ .Release.Name }}
{{- end -}}
