class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: gatk_samtofastq
baseCommand:
  - gatk
  - SamToFastq
inputs:
  - id: input
    type: File
    inputBinding:
      position: 0
      prefix: '--INPUT'
outputs:
  - id: interleaved_fastq
    type: File
    outputBinding:
      glob: $(inputs.input.nameroot).interleaved.fq
label: gatk-SamToFastq
arguments:
  - position: 0
    prefix: '--INTERLEAVE'
    valueFrom: 'true'
  - position: 0
    prefix: '--FASTQ'
    valueFrom: $(inputs.input.nameroot).interleaved.fq
requirements:
  - class: DockerRequirement
    dockerPull: 'pgcbioinfo/gatk:4.1.4.0'
  - class: InlineJavascriptRequirement
