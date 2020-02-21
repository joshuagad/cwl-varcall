class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: gatk_addorreplacereadgroups
baseCommand:
  - gatk
  - AddOrReplaceReadGroups
inputs:
  - id: input
    type: File
    inputBinding:
      position: 0
      prefix: '--INPUT'
    'sbg:fileTypes': 'sam, bam'
  - id: rglb
    type: string
    inputBinding:
      position: 0
      prefix: '--RGLB'
  - id: rgpl
    type: string
    inputBinding:
      position: 0
      prefix: '--RGPL'
  - id: rgpu
    type: string
    inputBinding:
      position: 0
      prefix: '--RGPU'
  - id: rgsm
    type: string
    inputBinding:
      position: 0
      prefix: '--RGSM'
outputs:
  - id: output
    type: File
    outputBinding:
      glob: addrep.$(inputs.input.nameroot).bam
label: gatk-AddOrReplaceReadGroups
arguments:
  - position: 0
    prefix: '--OUTPUT'
    valueFrom: addrep.$(inputs.input.nameroot).bam
requirements:
  - class: DockerRequirement
    dockerPull: 'pgcbioinfo/gatk:4.1.4.0'
  - class: InlineJavascriptRequirement
