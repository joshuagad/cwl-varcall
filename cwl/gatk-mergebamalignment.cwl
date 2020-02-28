class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: gatk_mergebamalignment
baseCommand:
  - gatk
  - MergeBamAlignment
inputs:
  - id: reference
    type: File
    inputBinding:
      position: 0
      prefix: '--REFERENCE_SEQUENCE'
    secondaryFiles:
      - ^.dict
  - id: unmapped
    type: File
    inputBinding:
      position: 0
      prefix: '--UNMAPPED'
  - id: aligned
    type: File
    inputBinding:
      position: 0
      prefix: '--ALIGNED'
outputs:
  - id: output
    type: File
    outputBinding:
      glob: merged.bam
label: gatk-MergeBamAlignment
arguments:
  - position: 0
    prefix: '--OUTPUT'
    valueFrom: merged.bam
requirements:
  - class: DockerRequirement
    dockerPull: 'pgcbioinfo/gatk:4.1.4.0'
