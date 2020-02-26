class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: gatk_markduplicates
baseCommand:
  - gatk
  - MarkDuplicates
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
      - ^bai
  - id: metrics_file
    type: File?
    outputBinding:
      glob: markdup.$(inputs.input.nameroot).metrics.txt
label: gatk-MarkDuplicates
arguments:
  - position: 0
    prefix: '-O'
    valueFrom: markdup.$(inputs.input.nameroot).bam
  - position: 0
    prefix: '--METRICS_FILE'
    valueFrom: markdup.$(inputs.input.nameroot).metrics.txt
requirements:
  - class: DockerRequirement
    dockerPull: 'pgcbioinfo/gatk:4.1.4.0'
  - class: InlineJavascriptRequirement
