class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: samtools_faidx
baseCommand:
  - samtools
  - faidx
inputs:
  - id: input_fasta
    type: File
    inputBinding:
      position: 0
outputs:
  - id: output_fasta
    type: File
    outputBinding:
      glob: $(inputs.input_fasta.basename)
    secondaryFiles:
      - $(inputs.input_fasta.basename).fai
label: samtools-faidx
requirements:
  - class: DockerRequirement
    dockerPull: 'pgcbioinfo/samtools:1.9'
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.input_fasta)
  - class: InlineJavascriptRequirement
