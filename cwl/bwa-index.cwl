class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: bwa_index
baseCommand:
  - bwa
  - index
inputs:
  - id: input_fasta
    type: File
    inputBinding:
      position: 0
outputs:
  - id: indexed_fasta
    type: File
    outputBinding:
      glob: $(inputs.input_fasta.basename)
    secondaryFiles:
      - $(inputs.input_fasta.basename).amb
      - $(inputs.input_fasta.basename).ann
      - $(inputs.input_fasta.basename).bwt
      - $(inputs.input_fasta.basename).pac
      - $(inputs.input_fasta.basename).sa
label: bwa-index
requirements:
  - class: DockerRequirement
    dockerPull: 'pgcbioinfo/bwa:0.7.17'
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_fasta)
        writable: false
  - class: InlineJavascriptRequirement
