{{/*
Expand the name of the chart.
*/}}
{{- define "tock.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "tock.fullname" -}}
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
{{- define "tock.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "tock.labels" -}}
helm.sh/chart: {{ include "tock.chart" . }}
{{ include "tock.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "tock.selectorLabels" -}}
app.kubernetes.io/name: {{ include "tock.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "tock.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "tock.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "tock.mongoUrl" -}}
mongodb://{{ .Release.Name }}-mongo:27017/?replicaSet=tock
{{- end }}

{{- define "tock.deployment" -}}
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ include "tock.fullname" . }}
  labels:
    {{- include "tock.labels" . | nindent 4 }}
spec:
  replicas: {{ .Values.replicaCount }}
  selector:
    matchLabels:
      {{- include "tock.selectorLabels" . | nindent 6 }}
  template:
    metadata:
      annotations:
        {{- if .Values.podAnnotations }}{{- toYaml .Values.podAnnotations | nindent 8 }}{{ end }}
        config-sha256: "{{ include (print .Template.BasePath "/configmap.yaml") . | sha256sum }}"
      labels:
        {{- include "tock.selectorLabels" . | nindent 8 }}
    spec:
      {{- with .Values.imagePullSecrets }}
      imagePullSecrets:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      securityContext:
        {{- toYaml .Values.podSecurityContext | nindent 8 }}
      initContainers:
        - name: pull-image
          image: "{{ .Values.image.repository }}:{{ .Values.image.tag | default .Chart.AppVersion }}"
          imagePullPolicy: {{ .Values.image.pullPolicy }}
          command: ["sh", "-c", "echo ok"]
        - name: wait-mongo
          image: "busybox:1.33"
          imagePullPolicy: IfNotPresent
          command:
            - sh
            - -c
            - |-
                echo "Wait for mongo to be up"
                while true;
                do
                  timeout 5 nc {{ .Release.Name }}-mongo-setup 8080 && echo "ok" && exit ;
                  echo "waiting"
                  sleep 5
                done
        {{- range $svc := .Values.serviceDependencies }}
        - name: wait-{{ $svc }}
          image: "busybox:1.33"
          imagePullPolicy: IfNotPresent
          command:
            - sh
            - -c
            - |-
                echo "Wait for {{ $svc }} to be up"
                while true;
                do
                  timeout 5 nc {{ $.Release.Name }}-{{ $svc }} 8080 && echo "ok" && exit ;
                  echo "waiting"
                  sleep 5
                done
        {{- end }}
      containers:
        - name: {{ .Chart.Name }}
          securityContext:
            {{- toYaml .Values.securityContext | nindent 12 }}
          image: "{{ .Values.image.repository }}:{{ .Values.image.tag | default .Chart.AppVersion }}"
          imagePullPolicy: {{ .Values.image.pullPolicy }}
          envFrom:
            - configMapRef:
                name: "{{ include "tock.fullname" . }}"
          ports:
            - name: http
              containerPort: 8080
              protocol: TCP
          livenessProbe: &liveness
            httpGet:
              path: {{ .Values.healthEndpoint }}
              port: http
            initialDelaySeconds: 20
            periodSeconds: 30
          readinessProbe:
            <<: *liveness
            periodSeconds: 10
            initialDelaySeconds: 5
          resources:
            {{- toYaml .Values.resources | nindent 12 }}
      {{- with .Values.nodeSelector }}
      nodeSelector:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      {{- with .Values.affinity }}
      affinity:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      {{- with .Values.tolerations }}
      tolerations:
        {{- toYaml . | nindent 8 }}
      {{- end }}
{{ end }}

{{- define "tock.config" -}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ include "tock.fullname" . }}
  labels:
    {{- include "tock.labels" . | nindent 4 }}
data:
  {{- tpl .Values.configMap . | nindent 2 }}
{{ end }}

{{- define "tock.service" -}}
apiVersion: v1
kind: Service
metadata:
  name: {{ include "tock.fullname" . }}
  labels:
    {{- include "tock.labels" . | nindent 4 }}
spec:
  type: {{ .Values.service.type }}
  ports:
    - port: {{ .Values.service.port }}
      targetPort: http
      protocol: TCP
      name: http
  selector:
    {{- include "tock.selectorLabels" . | nindent 4 }}
{{ end }}
