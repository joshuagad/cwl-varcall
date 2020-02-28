class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: gatk_haplotypecaller
baseCommand:
  - gatk
  - HaplotypeCaller
inputs:
  - id: input
    type: File
    inputBinding:
      position: 0
      prefix: '--input'
    secondaryFiles:
      - .bai
  - id: reference
    type: File
    inputBinding:
      position: 0
      prefix: '--reference'
    secondaryFiles:
      - .fai
      - ^.dict
outputs:
  - id: vcf
    type: File
    outputBinding:
      glob: $(inputs.input.nameroot).vcf
    secondaryFiles:
      - .idx
label: gatk-HaplotypeCallerVCF
arguments:
  - position: 0
    prefix: '--output'
    valueFrom: $(inputs.input.nameroot).vcf
  - position: 0
    prefix: '--create-output-variant-index'
    valueFrom: 'true'
requirements:
  - class: DockerRequirement
    dockerPull: 'pgcbioinfo/gatk:4.1.4.0'
  - class: InlineJavascriptRequirement
