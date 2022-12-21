{{- define "ix.v1.common.spawner.configmapAndSecret" -}}
  {{- $root := . -}}

  {{- range $name, $objectData := .Values.configmap -}}
    {{- include "ix.v1.common.configmapAndSecret.process" (dict "root" $root "name" $name "objectData" $objectData "objectType" "configmap") -}}
  {{- end -}}
  {{- range $name, $objectData := .Values.secret -}}
    {{- include "ix.v1.common.configmapAndSecret.process" (dict "root" $root "name" $name "objectData" $objectData "objectType" "secret") -}}
  {{- end -}}
{{- end -}}

{{- define "ix.v1.common.configmapAndSecret.process" -}}
  {{- $root := .root -}}
  {{- $name := .name -}}
  {{- $objectData := .objectData -}}
  {{- $objectType := .objectType -}}

  {{- if ne $name ($name | lower) -}}
    {{- fail (printf "%s has invalid name (%s). Name must be lowercase." (camelcase $objectType) $name) -}}
  {{- end -}}
  {{- if contains "_" $name -}}
    {{- fail (printf "%s has invalid name (%s). Name cannot contain underscores (_)." (camelcase $objectType) $name) -}}
  {{- end -}}

  {{/* Generate the name */}}
  {{- $objectName := include "ix.v1.common.names.fullname" $root -}}
  {{- if and (hasKey $objectData "nameOverride") $objectData.nameOverride -}}
    {{- $objectName = printf "%v-%v" $objectName $objectData.nameOverride -}}
  {{- else -}}
    {{- $objectName = printf "%v-%v" $objectName $name -}}
  {{- end -}}

  {{- if $objectData.enabled -}} {{/* If it's enabled... */}}

    {{/* Do some checks */}}
    {{- if not $objectData.content -}}
      {{- fail (printf "Content of %s (%s) are empty. Please disable or add content." (camelcase $objectType) $name) -}}
    {{- end -}}

    {{- if eq (kindOf $objectData.content) "string" -}}
      {{- fail (printf "Content of %s (%s) are string. Must be in key/value format. Value can be scalar too." (camelcase $objectType) $name) -}}
    {{- end -}}


    {{- $parseAsEnv := false -}}
    {{- if hasKey $objectData "parseAsEnv" -}}
      {{- $parseAsEnv = $objectData.parseAsEnv -}}
    {{- end -}}

    {{- $classData := dict -}} {{/* Store expanded data that will be passed to the class */}}
    {{- $dupeCheck := dict -}}  {{/* Store expanded data that will be checked for dupes */}}

    {{- range $k, $v := $objectData.content -}}
      {{- $value := tpl ($v | toString) $root -}} {{/* Convert to string so safely handle ints, falsy values and scalars. Also expand values */}}
      {{- if $parseAsEnv -}}
        {{- $_ := set $dupeCheck $k $value -}}
      {{- end -}}
      {{- $_ := set $classData $k $value -}}
    {{- end -}}

    {{/* Add the to the list for dupeCheck */}}
    {{- include "ix.v1.common.util.storeEnvsForDupeCheck" (dict "root" $root "source" (printf "%s-%s" (camelcase $objectType) $objectName) "data" $dupeCheck) -}}
    {{/* Convert to Yaml before sending to classes */}}
    {{- $classData = toYaml $classData -}}

    {{- $contentType := "yaml" -}}
    {{/* Create ConfigMap or Secret */}}
    {{- if eq $objectType "configmap" -}}
      {{- include "ix.v1.common.class.configmap" (dict "root" $root "configName" $objectName "contentType" $contentType "data" $classData "labels" $objectData.labels "annotations" $objectData.annotations) -}}
    {{- else if eq $objectType "secret" -}}
      {{- include "ix.v1.common.class.secret" (dict "root" $root "secretName" $objectName "secretType" $objectData.secretType "contentType" $contentType "data" $classData "labels" $objectData.labels "annotations" $objectData.annotations) -}}
    {{- end -}}

  {{- end -}}
{{- end -}}