class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: gatk_createsequencedictionary
baseCommand:
  - gatk
  - CreateSequenceDictionary
inputs:
  - id: reference
    type: File
    inputBinding:
      position: 0
      prefix: '--REFERENCE'
outputs:
  - id: sequence_dictionary
    type: File
    outputBinding:
      glob: $(inputs.reference.basename)
    secondaryFiles:
      - $(inputs.reference.nameroot).dict
      - $(inputs.reference.basename).fai
label: gatk-CreateSequenceDictionary
arguments:
  - position: 0
    prefix: '--OUTPUT'
    valueFrom: $(inputs.reference.nameroot).dict
requirements:
  - class: DockerRequirement
    dockerPull: 'pgcbioinfo/gatk:4.1.4.0'
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.reference)
  - class: InlineJavascriptRequirement
