{{/* vim: set filetype=mustache: */}}

{{/*
Erda registry address
*/}}
{{- define "erda.registry.address" -}}
{{- if .Values.registry.custom.nodeName -}}
{{ printf "%s:5000" .Values.registry.custom.nodeIP }}
{{- else if .Values.registry.custom.address -}}
{{ .Values.registry.custom.address }}
{{- else -}}
{{ printf "erda-registry.%s.svc.cluster.local:5000" .Release.Namespace }}
{{- end -}}
{{- end -}}

{{/*
Erda registry authorization
*/}}
{{- define "erda.registry.authorization" }}
{{- if .Values.registry.custom.username }}
REGISTRY_USERNAME: {{ .Values.registry.custom.username | quote }}
{{- end }}
{{- if .Values.registry.custom.password }}
REGISTRY_PASSWORD: {{ .Values.registry.custom.password | quote }}
{{- end }}
{{- end }}

{{/*
Erda registry configuration
*/}}
{{- define "erda.registry.configuration" -}}
REGISTRY_ADDR: {{ template "erda.registry.address" . }}
{{- template "erda.registry.authorization" . -}}
{{- end -}}

{{/*
Erda registry credential secret enabled
*/}}
{{- define "erda.registry.regcred.enabled" -}}
{{- if and .Values.registry.custom.address .Values.registry.custom.username .Values.registry.custom.password -}}
{{- true -}}
{{- else -}}
{{- end  -}}
{{- end -}}

{{/*
Erda buildkitd enabled
*/}}
{{- define "erda.buildkitd.enabled" -}}
{{- if ne .Values.buildkitd.enabled false -}}
{{true}}
{{- end -}}
{{- end -}}

{{/*
Erda buildkitd configuration configmap
*/}}
{{- define "erda.buildkitd.configmapName" -}}
{{ default  "buildkitd-config" .Values.buildkitd.existingConfigmap }}
{{- end -}}


{{/*
Lookup Erda etcd certs
*/}}
{{- define "erda.buildkitd.certsIntegrity" -}}
{{- $buildkitDaemonCert := (lookup "v1" "Secret" $.Release.Namespace "buildkit-daemon-certs" ) }}
{{- $buildkitClientCert := (lookup "v1" "Secret" $.Release.Namespace "buildkit-client-certs" ) }}
{{- if and $buildkitDaemonCert $buildkitClientCert -}}
{{- true -}}
{{- else -}}
{{- end -}}
{{- end -}}

{{/*
Lookup Erda etcd certs
*/}}
{{- define "erda.etcd.certsIntegrity" -}}
{{- $etcdClientCert := (lookup "v1" "Secret" $.Release.Namespace "erda-etcd-client-secret" ) }}
{{- $etcdServerCert := (lookup "v1" "Secret" $.Release.Namespace "erda-etcd-server-secret" ) }}
{{- if and $etcdClientCert $etcdServerCert -}}
{{- true -}}
{{- else -}}
{{- end -}}
{{- end -}}


{{/*
Erda buildkitd configuration
*/}}
{{- define "erda.buildkitd.configuration" -}}
[registry.{{ print (include "erda.registry.address" .) | quote }}]
  http = true
  insecure = true
{{- end -}}

{{/*
Erda certgen enabled
*/}}
{{- define "erda.certgen.enabled" -}}
{{- if .Values.tags.worker -}}
{{- if not (include "erda.buildkitd.certsIntegrity" . ) -}}
{{- true -}}
{{- else -}}
{{- end -}}
{{- else -}}
{{- if or (not (include "erda.buildkitd.certsIntegrity" . )) (not (include "erda.etcd.certsIntegrity" .)) -}}
{{- true -}}
{{- else -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Erda certgen serviceaccount name
*/}}
{{- define "erda.certgen.serviceAccountName" -}}
{{- if .Values.certgen.serviceAccount.create -}}
    {{ default (printf "%s-certgen" (include "common.names.fullname" .)) .Values.certgen.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.certgen.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Erda certgen image
*/}}
{{- define "erda.certgen.image" -}}
{{ printf "%s/certgen:%s" .Values.global.image.repository .Values.certgen.image.tag | quote }}
{{- end -}}
