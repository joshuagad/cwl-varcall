class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: gatk_haplotypecallergvcf
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
  - id: gvcf
    type: File
    outputBinding:
      glob: $(inputs.input.nameroot).g.vcf
label: gatk-HaplotypeCallerGVCF
arguments:
  - position: 0
    prefix: '--output'
    valueFrom: $(inputs.input.nameroot).g.vcf
  - position: 0
    prefix: '--emit-ref-confidence'
    valueFrom: GVCF
requirements:
  - class: DockerRequirement
    dockerPull: 'pgcbioinfo/gatk:4.1.4.0'
  - class: InlineJavascriptRequirement
