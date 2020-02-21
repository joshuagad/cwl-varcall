class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: gatk_indexfeaturefile
baseCommand:
  - gatk
  - IndexFeatureFile
inputs:
  - id: feature_file
    type: File
    inputBinding:
      position: 0
      prefix: '--feature-file'
outputs:
  - id: indexed_feature_file
    type: File
    outputBinding:
      glob: $(inputs.feature_file.basename)
    secondaryFiles:
      - $(inputs.feature_file.basename).idx
label: gatk-IndexFeatureFile
requirements:
  - class: DockerRequirement
    dockerPull: 'pgcbioinfo/gatk:4.1.4.0'
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.feature_file)
  - class: InlineJavascriptRequirement
