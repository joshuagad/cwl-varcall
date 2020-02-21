class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: gatk_bwaspark
baseCommand:
  - gatk
  - BwaMemIndexImageCreator
inputs:
  - id: input
    type: File
    inputBinding:
      position: 0
      prefix: '--input'
outputs:
  - id: output
    type: File
    outputBinding:
      glob: $(inputs.input.basename)
    secondaryFiles:
      - $(inputs.input.nameroot).dict
      - $(inputs.input.basename).img
      - $(inputs.input.basename).fai
label: gatk-BwaMemIndexImageCreator
arguments:
  - position: 0
    prefix: '--output'
    valueFrom: $(inputs.input.basename).img
requirements:
  - class: DockerRequirement
    dockerPull: 'pgcbioinfo/gatk:4.1.4.0'
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input)
        writable: false
  - class: InlineJavascriptRequirement
