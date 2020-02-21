class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: gatk_markduplicatesspark
baseCommand:
  - gatk
  - MarkDuplicatesSpark
inputs:
  - id: input
    type: File
    inputBinding:
      position: 0
      prefix: '-I'
outputs:
  - id: markdup_bam
    type: File
    outputBinding:
      glob: markdup.$(inputs.input.nameroot).bam
    secondaryFiles:
      - markdup.$(inputs.input.nameroot).bam.bai
label: gatk-MarkDuplicatesSpark
arguments:
  - position: 0
    prefix: '-O'
    valueFrom: markdup.$(inputs.input.nameroot).bam
  - position: 0
    prefix: '--create-output-bam-index'
    valueFrom: 'true'
requirements:
  - class: DockerRequirement
    dockerPull: 'pgcbioinfo/gatk:4.1.4.0'
  - class: InlineJavascriptRequirement
