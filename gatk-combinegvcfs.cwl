class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: gatk_combinegvcfs
baseCommand:
  - gatk
  - CombineGVCFs
inputs:
  - id: reference
    type: File
    inputBinding:
      position: 0
      prefix: '--reference'
    secondaryFiles:
      - $(inputs.reference.basename).fai
      - $(inputs.reference.nameroot).dict
  - id: variant
    type: File
    inputBinding:
      position: 0
      prefix: '--variant'
outputs: []
label: gatk-CombineGVCFs
requirements:
  - class: DockerRequirement
    dockerPull: 'pgcbioinfo/gatk:4.1.4.0'
  - class: InlineJavascriptRequirement
