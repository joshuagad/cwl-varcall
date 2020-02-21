class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: gatk_bwaspark
baseCommand:
  - gatk
  - BwaSpark
inputs:
  - id: input
    type: File
    inputBinding:
      position: 0
      prefix: '--input'
  - id: reference
    type: File
    inputBinding:
      position: 0
      prefix: '--reference'
    secondaryFiles:
      - $(inputs.reference.nameroot).dict
      - $(inputs.reference.basename).img
outputs:
  - id: output
    type: File
    outputBinding:
      glob: mapped.$(inputs.input.nameroot).bam
label: gatk-BwaSpark
arguments:
  - position: 0
    prefix: '--output'
    valueFrom: mapped.$(inputs.input.nameroot).bam
requirements:
  - class: DockerRequirement
    dockerPull: 'pgcbioinfo/gatk:4.1.4.0'
  - class: InlineJavascriptRequirement
