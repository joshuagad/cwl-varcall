class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: varcall_standard_collect
baseCommand:
  - echo
inputs:
  - id: gatk-FastqToSam
    type: File?
    inputBinding:
      position: 0
  - id: bwa-mem
    type: File?
    inputBinding:
      position: 0
  - id: gatk-MergeBamAlignment
    type: File?
    inputBinding:
      position: 0
  - id: gatk-SortSam
    type: File?
    inputBinding:
      position: 0
  - id: gatk-MarkDuplicates
    type: File?
    inputBinding:
      position: 0
  - id: gatk-HaplotypeCallerVCF
    type: File?
    inputBinding:
      position: 0
  - id: gatk-BaseRecalibrator
    type: File?
    inputBinding:
      position: 0
  - id: gatk-ApplyBQSR
    type: File?
    inputBinding:
      position: 0
  - id: gatk-HaplotypeCallerGVCF
    type: File?
    inputBinding:
      position: 0
outputs:
  - id: output
    type: Directory?
label: varcall-standard-collect
