class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: gatk_baserecalibrator
baseCommand:
  - gatk
  - BaseRecalibrator
inputs:
  - id: input
    type: File
    inputBinding:
      position: 0
      prefix: '--input'
    secondaryFiles:
      - $(inputs.input.basename).bai
  - id: known_sites
    type: File
    inputBinding:
      position: 0
      prefix: '--known-sites'
    secondaryFiles:
      - $(inputs.known_sites.basename).idx
  - id: reference
    type: File
    inputBinding:
      position: 0
      prefix: '--reference'
    secondaryFiles:
      - $(inputs.reference.basename).fai
      - $(inputs.reference.nameroot).dict
outputs:
  - id: recalibration_table
    type: File
    outputBinding:
      glob: recal.$(inputs.input.basename).txt
label: gatk-BaseRecalibrator
arguments:
  - position: 0
    prefix: '--output'
    valueFrom: recal.$(inputs.input.basename).txt
requirements:
  - class: DockerRequirement
    dockerPull: 'pgcbioinfo/gatk:4.1.4.0'
  - class: InlineJavascriptRequirement
