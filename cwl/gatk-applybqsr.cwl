class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: gatk_applybqsr
baseCommand:
  - gatk
  - ApplyBQSR
inputs:
  - id: reference
    type: File
    inputBinding:
      position: 0
      prefix: '--reference'
    secondaryFiles:
      - .fai
      - ^.dict
  - id: input
    type: File
    inputBinding:
      position: 0
      prefix: '--input'
    secondaryFiles:
      - .bai
  - id: bqsr_recal_file
    type: File
    inputBinding:
      position: 0
      prefix: '--bqsr-recal-file'
outputs:
  - id: recal_bam
    type: File
    outputBinding:
      glob: recal.$(inputs.input.nameroot).bam
    secondaryFiles:
      - recal.$(inputs.input.nameroot).bam.bai
label: gatk-ApplyBQSR
arguments:
  - position: 0
    prefix: '--output'
    valueFrom: recal.$(inputs.input.nameroot).bam
  - position: 0
    prefix: '--create-output-bam-index'
    valueFrom: 'true'
requirements:
  - class: DockerRequirement
    dockerPull: 'pgcbioinfo/gatk:4.1.4.0'
  - class: InlineJavascriptRequirement
