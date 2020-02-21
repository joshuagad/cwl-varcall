class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: gatk_fastqtosam
baseCommand:
  - gatk
  - FastqToSam
inputs:
  - id: fastq1
    type: File
    inputBinding:
      position: 0
      prefix: '--FASTQ'
  - id: fastq2
    type: File?
    inputBinding:
      position: 0
      prefix: '--FASTQ2'
  - id: sample_name
    type: string
    inputBinding:
      position: 0
      prefix: '--SAMPLE_NAME'
  - id: library_name
    type: string
    inputBinding:
      position: 0
      prefix: '--LIBRARY_NAME'
  - id: platform
    type: string
    inputBinding:
      position: 0
      prefix: '--PLATFORM'
  - id: platform_unit
    type: string
    inputBinding:
      position: 0
      prefix: '--PLATFORM_UNIT'
outputs:
  - id: unmapped_bam
    type: File
    outputBinding:
      glob: unmapped.$(inputs.sample_name).bam
label: gatk-FastqToSam
arguments:
  - position: 0
    prefix: '-O'
    valueFrom: unmapped.$(inputs.sample_name).bam
  - position: 0
    prefix: '--SORT_ORDER'
    valueFrom: queryname
requirements:
  - class: DockerRequirement
    dockerPull: 'pgcbioinfo/gatk:4.1.4.0'
  - class: InlineJavascriptRequirement
