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
    type: 'File[]'
    inputBinding:
      position: 0
      prefix: '-I'
      itemSeparator: ' -I '
      shellQuote: false
  - id: sample_name
    type: string
outputs:
  - id: markdup_bam
    type: File
    outputBinding:
      glob: $(inputs.sample_name).bam
    secondaryFiles:
      - ^bai
  - id: metrics_file
    type: File?
    outputBinding:
      glob: $(inputs.sample_name).metrics.txt
label: gatk-MarkDuplicates
arguments:
  - position: 0
    prefix: '-O'
    valueFrom: $(inputs.sample_name).bam
  - position: 0
    prefix: '--METRICS_FILE'
    valueFrom: $(inputs.sample_name).metrics.txt
requirements:
  - class: ShellCommandRequirement
  - class: DockerRequirement
    dockerPull: 'pgcbioinfo/gatk:4.1.4.0'
  - class: InlineJavascriptRequirement
