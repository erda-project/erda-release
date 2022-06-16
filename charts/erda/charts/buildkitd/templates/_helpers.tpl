{{/* vim: set filetype=mustache: */}}

{{/*
Name
*/}}
{{- define "buildkitd.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{/*
Labels
*/}}
{{- define "buildkitd.labels" -}}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: "{{ replace "+" "_" .Chart.AppVersion }}"
app.kubernetes.io/name: {{ include "buildkitd.name" . }}
{{- if .Values.labels}}
{{ toYaml .Values.labels }}
{{- end }}
{{- end -}}

{{/*
Match labels
*/}}
{{- define "buildkitd.matchLables" -}}
app.kubernetes.io/name:  {{ include "buildkitd.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Full name
*/}}
{{- define "buildkitd.fullname" -}}
{{- if .Values.fullNameOverride -}}
{{- .Values.fullNameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
 TLS cert generatro job service account name
 */}}
{{- define "buildkitd.tlsCertServiceAccountName" -}}
{{- if .Values.tls.autoGenerated.rbac.create -}}
    {{- printf "%s-tls-generator" (include "buildkitd.fullname" .) -}}
{{- else -}}
    {{ default (include "buildkitd.fullname" .) .Values.tls.autoGenerated.serviceAccountName }}
{{- end -}}
{{- end -}}

{{/*
TLS daemon cert secret
*/}}
{{- define "buildkitd.tlsDaemonCertSecret" -}}
{{- if not .Values.tls.autoGenerated.enabled -}}
    {{ default "buildkit-daemon-certs" .Values.tls.autoGenerated.daemonSecret }}
{{- else -}}
    {{- print "buildkit-daemon-certs" -}}
{{- end -}}
{{- end -}}

{{/*
TLS generator job image
*/}}
{{- define "buildkitd.tlsDaemonCertGenJobImage" -}}
{{ printf "%s/buildkit_ssl:%s" .Values.global.image.repository .Values.tls.autoGenerated.jobTag }}
{{- end -}}

{{/*
TLS generator job enable
*/}}

{{/*
Create configmap
*/}}
{{- define "buildkitd.createConfigmap" -}}
{{- if and .Values.configuration (not .Values.existingConfigmap) -}}
{{true}}
{{- else -}}
{{- end -}}
{{- end -}}

{{/*
Buildkitd configmap name
*/}}
{{- define "buildkitd.configmapName" -}}
{{- if .Values.existingConfigmap -}}
    {{- print .Values.existingConfigmap -}}
{{- else -}}
    {{- printf "%s-config" (include "buildkitd.name" .) -}}
{{- end -}}
{{- end -}}


{{/*
Use configmap
*/}}
{{- define "buildkitd.useConfig" -}}
{{- if or .Values.configuration .Values.existingConfigmap -}}
{{true}}
{{- else -}}
{{- end -}}
{{- end -}}