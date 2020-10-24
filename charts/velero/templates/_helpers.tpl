{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "velero.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "velero.fullname" -}}
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
{{- define "velero.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create the name of the service account to use for creating or deleting the velero server
*/}}
{{- define "velero.serverServiceAccount" -}}
{{- if .Values.serviceAccount.server.create -}}
    {{ default (printf "%s-%s" (include "velero.fullname" .) "server") .Values.serviceAccount.server.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.server.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name for the credentials secret.
*/}}
{{- define "velero.secretName" -}}
{{- if .Values.credentials.existingSecret -}}
  {{- .Values.credentials.existingSecret -}}
{{- else -}}
  {{- include "velero.fullname" . -}}
{{- end -}}
{{- end -}}

{{/*
Create the Velero priority class name.
*/}}
{{- define "velero.priorityClassName" -}}
{{- if .Values.priorityClassName -}}
  {{- .Values.priorityClassName -}}
{{- else -}}
  {{- include "velero.fullname" . -}}
{{- end -}}
{{- end -}}

{{/*
Create the Restic priority class name.
*/}}
{{- define "velero.restic.priorityClassName" -}}
{{- if .Values.restic.priorityClassName -}}
  {{- .Values.restic.priorityClassName -}}
{{- else -}}
  {{- include "velero.fullname" . -}}
{{- end -}}
{{- end -}}

{{/*
Create the backup storage location name
*/}}
{{- define "velero.backupStorageLocation.name" -}}
{{ coalesce .Values.backupStorageLocation.name .Values.configuration.backupStorageLocation.name "default" }}
{{- end -}}

{{/*
Create the backup storage location provider
*/}}
{{- define "velero.backupStorageLocation.provider" -}}
{{ coalesce .Values.backupStorageLocation.provider .Values.configuration.backupStorageLocation.provider .Values.provider }}
{{- end -}}

{{/*
Create the volume snapshot location name
*/}}
{{- define "velero.volumeSnapshotLocation.name" -}}
{{ coalesce .Values.volumeSnapshotLocation.name .Values.configuration.volumeSnapshotLocation.name "default" }}
{{- end -}}

{{/*
Create the volume snapshot location provider
*/}}
{{- define "velero.volumeSnapshotLocation.provider" -}}
{{ coalesce  .Values.volumeSnapshotLocation.provider .Values.configuration.volumeSnapshotLocation.provider .Values.provider}}
{{- end -}}

{{- define "velero.image-from-values" -}}
  {{- if kindIs "string" . -}}
    {{- . }}
  {{- else -}}
    {{- if .digest -}}
      {{- .repository }}@{{ .digest }}
    {{- else -}}
      {{- .repository }}:{{ .tag }}
    {{- end -}}
  {{- end -}}
{{- end -}}
{{- define "velero.pull-policy-from-values" -}}
  {{- if kindIs "string" . -}}
    {{ "IfNotPresent" -}}
  {{- else -}}
    {{ .pullPolicy -}}
  {{- end -}}
{{- end -}}

{{- define "velero.name-from-values" -}}
  {{- if kindIs "string" . -}}
    {{ splitList "@" . | first | splitList ":" | first | splitList "/" | last -}}
  {{- else -}}
    {{ splitList "/" .repository | last -}}
  {{- end -}}
{{- end -}}
