{{/* Return the appropriate apiVersion for Deployment */}}
{{- define "ix.v1.common.capabilities.deployment.apiVersion" -}}
  {{- print "apps/v1" -}}
{{- end -}}

{{/* Return the appropriate apiVersion for Statefulset */}}
{{- define "ix.v1.common.capabilities.statefulset.apiVersion" -}}
  {{- print "apps/v1" -}}
{{- end -}}

{{/* Return the appropriate apiVersion for Daemonset */}}
{{- define "ix.v1.common.capabilities.daemonset.apiVersion" -}}
  {{- print "apps/v1" -}}
{{- end -}}

{{/* Return the appropriate apiVersion for CronJob */}}
{{- define "ix.v1.common.capabilities.cronJob.apiVersion" -}}
  {{- print "batch/v1" -}}
{{- end -}}

{{/* Return the appropriate apiVersion for Job */}}
{{- define "ix.v1.common.capabilities.job.apiVersion" -}}
  {{- print "batch/v1" -}}
{{- end -}}

{{/* Return the appropriate apiVersion for Job */}}
{{- define "ix.v1.common.capabilities.serviceAccount.apiVersion" -}}
  {{- print "v1" -}}
{{- end -}}

{{/* Return the appropriate apiVersion for ClusterRole */}}
{{- define "ix.v1.common.capabilities.clusterRole.apiVersion" -}}
  {{- print "rbac.authorization.k8s.io/v1" -}}
{{- end -}}

{{/* Return the appropriate apiVersion for Role */}}
{{- define "ix.v1.common.capabilities.role.apiVersion" -}}
  {{- print "rbac.authorization.k8s.io/v1" -}}
{{- end -}}

{{/* Return the appropriate apiVersion for RoleBinding */}}
{{- define "ix.v1.common.capabilities.roleBinding.apiVersion" -}}
  {{- print "rbac.authorization.k8s.io/v1" -}}
{{- end -}}

{{/* Return the appropriate apiVersion for ClusterRoleBinding */}}
{{- define "ix.v1.common.capabilities.clusterRoleBinding.apiVersion" -}}
  {{- print "rbac.authorization.k8s.io/v1" -}}
{{- end -}}

{{/* Return the appropriate apiVersion for Service */}}
{{- define "ix.v1.common.capabilities.service.apiVersion" -}}
  {{- print "v1" -}}
{{- end -}}

{{/* Return the appropriate apiVersion for Endpoints */}}
{{- define "ix.v1.common.capabilities.endpoints.apiVersion" -}}
  {{- print "v1" -}}
{{- end -}}

{{/* Return the appropriate apiVersion for PersistentVolumeClaim */}}
{{- define "ix.v1.common.capabilities.pvc.apiVersion" -}}
  {{- print "v1" -}}
{{- end -}}

{{/* Return the appropriate apiVersion for NetworkAttachmentDefinition */}}
{{- define "ix.v1.common.capabilities.externalInterfaces.apiVersion" -}}
  {{- print "k8s.cni.cncf.io/v1" | quote -}}
{{- end -}}