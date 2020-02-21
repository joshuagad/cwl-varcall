class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: gatk_sortsam
baseCommand:
  - gatk
  - SortSam
inputs:
  - id: input
    type: File
    inputBinding:
      position: 0
      prefix: '-I'
  - id: sort_order
    type: string
    inputBinding:
      position: 0
      prefix: '--SORT_ORDER'
outputs:
  - id: markdup_bam
    type: File
    outputBinding:
      glob: sorted.$(inputs.input.nameroot).bam
label: gatk-SortSam
arguments:
  - position: 0
    prefix: '-O'
    valueFrom: sorted.$(inputs.input.nameroot).bam
requirements:
  - class: DockerRequirement
    dockerPull: 'pgcbioinfo/gatk:4.1.4.0'
  - class: InlineJavascriptRequirement
