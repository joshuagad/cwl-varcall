class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: samtools_index
baseCommand:
  - samtools
  - index
inputs:
  - id: input_bam
    type: File
    inputBinding:
      position: 0
outputs:
  - id: indexed_bam
    type: File
    outputBinding:
      glob: $(inputs.input_bam.basename)
    secondaryFiles:
      - $(inputs.input_bam.basename).bai
label: samtools-index
requirements:
  - class: DockerRequirement
    dockerPull: 'pgcbioinfo/samtools:1.9'
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.input_bam)
  - class: InlineJavascriptRequirement
