class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: bwa_mem
baseCommand:
  - bwa
  - mem
inputs:
  - id: sample_name
    type: string?
  - id: indexed_reference
    type: File
    inputBinding:
      position: 0
    secondaryFiles:
      - .amb
      - .ann
      - .bwt
      - .pac
      - .sa
  - id: in1
    type: File
    inputBinding:
      position: 1
  - id: in2
    type: File?
    inputBinding:
      position: 2
outputs:
  - id: result_sam
    type: File
    outputBinding:
      glob: mapped.$(inputs.sample_name || "result").sam
label: bwa-mem
arguments:
  - position: 0
    prefix: '-o'
    valueFrom: mapped.$(inputs.sample_name || "result").sam
  - position: 0
    prefix: ''
    separate: false
    valueFrom: '-M'
  - position: 0
    prefix: '-t'
    valueFrom: $(runtime.cores)
requirements:
  - class: DockerRequirement
    dockerPull: 'pgcbioinfo/bwa:0.7.17'
  - class: InlineJavascriptRequirement
