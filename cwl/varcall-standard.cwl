class: Workflow
cwlVersion: v1.0
id: varcall
label: varcall-standard
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: reference
    type: File
    secondaryFiles:
      - .amb
      - .ann
      - .bwt
      - .pac
      - .sa
      - ^.dict
      - .fai
    'sbg:x': -2.506943464279175
    'sbg:y': 39.577247619628906
  - id: sample_name
    type: string
    'sbg:x': -3.436631679534912
    'sbg:y': 157.4505157470703
  - id: input
    type:
      type: array
      items:
        type: record
        name: input
        fields:
          - name: reads1
            type: File
          - name: reads2
            type: File?
          - name: read_group_name
            type: string
          - name: library_name
            type: string
          - name: platform
            type: string
          - name: platform_unit
            type: string
    'sbg:x': -2.873265266418457
    'sbg:y': 280.88714599609375
outputs:
  - id: sample_bam
    outputSource:
      - samtools_index/indexed_bam
    type: File
    'sbg:x': 1206.255859375
    'sbg:y': 425
  - id: recalibrated_bam
    outputSource:
      - samtools_index_1/indexed_bam
    type: File
    'sbg:x': 1495.0968017578125
    'sbg:y': 423.62164306640625
  - id: gvcf
    outputSource:
      - gatk_haplotypecallergvcf/gvcf
    type:
      - File
      - type: array
        items: File
    'sbg:x': 1488.1448974609375
    'sbg:y': 260.885498046875
steps:
  - id: gatk_sortsam
    in:
      - id: input
        source: gatk_mergebamalignment/output
      - id: sort_order
        default: coordinate
    out:
      - id: sorted_bam
    run: ./gatk-sortsam.cwl
    label: gatk-SortSam
    scatter:
      - input
    'sbg:x': 610.9158935546875
    'sbg:y': 434.7137756347656
  - id: bwa_mem
    in:
      - id: indexed_reference
        source: reference
      - id: in1
        source: parsereads/reads1
      - id: in2
        source: parsereads/reads2
    out:
      - id: result_sam
    run: ./bwa-mem.cwl
    label: bwa-mem
    scatter:
      - in1
      - in2
    scatterMethod: dotproduct
    'sbg:x': 250.831787109375
    'sbg:y': 307.10107421875
  - id: gatk_mergebamalignment
    in:
      - id: reference
        source: reference
      - id: unmapped
        source: gatk_fastqtosam/unmapped_bam
      - id: aligned
        source: bwa_mem/result_sam
    out:
      - id: output
    run: ./gatk-mergebamalignment.cwl
    label: gatk-MergeBamAlignment
    scatter:
      - unmapped
      - aligned
    scatterMethod: dotproduct
    'sbg:x': 525.2861938476562
    'sbg:y': 313.2558288574219
  - id: samtools_index
    in:
      - id: input_bam
        source: gatk_markduplicates/markdup_bam
    out:
      - id: indexed_bam
    run: ./samtools-index.cwl
    label: samtools-index
    'sbg:x': 779.1010131835938
    'sbg:y': 396.41412353515625
  - id: gatk_markduplicates
    in:
      - id: input
        source:
          - gatk_sortsam/sorted_bam
      - id: sample_name
        source: sample_name
    out:
      - id: markdup_bam
      - id: metrics_file
    run: ./gatk-markduplicates.cwl
    label: gatk-MarkDuplicates
    'sbg:x': 666.8013916015625
    'sbg:y': 235.88551330566406
  - id: parsereads
    in:
      - id: input
        source: input
    out:
      - id: reads1
      - id: reads2
      - id: read_group_name
      - id: library_name
      - id: platform
      - id: platform_unit
    run: ./parsereads.cwl
    label: parseReads
    scatter:
      - input
    scatterMethod: dotproduct
    'sbg:x': 94.90247344970703
    'sbg:y': 488
  - id: gatk_fastqtosam
    in:
      - id: reads1
        source: parsereads/reads1
      - id: reads2
        source: parsereads/reads2
      - id: read_group_name
        source: parsereads/read_group_name
      - id: sample_name
        source: sample_name
      - id: library_name
        source: parsereads/library_name
      - id: platform
        source: parsereads/platform
      - id: platform_unit
        source: parsereads/platform_unit
    out:
      - id: unmapped_bam
    run: ./gatk-fastqtosam.cwl
    label: gatk-FastqToSam
    scatter:
      - reads1
      - reads2
      - read_group_name
      - library_name
      - platform
      - platform_unit
    scatterMethod: dotproduct
    'sbg:x': 334.37384033203125
    'sbg:y': 509.9293212890625
  - id: gatk_haplotypecaller
    in:
      - id: input
        source: samtools_index/indexed_bam
      - id: reference
        source: reference
    out:
      - id: vcf
    run: ./gatk-haplotypecallervcf.cwl
    label: gatk-HaplotypeCallerVCF
    'sbg:x': 812.9158935546875
    'sbg:y': 186.5858612060547
  - id: gatk_baserecalibrator
    in:
      - id: input
        source: samtools_index/indexed_bam
      - id: known_sites
        source: gatk_haplotypecaller/vcf
      - id: reference
        source: reference
    out:
      - id: recalibration_table
    run: ./gatk-baserecalibrator.cwl
    label: gatk-BaseRecalibrator
    'sbg:x': 994.3434448242188
    'sbg:y': 162.0572509765625
  - id: gatk_applybqsr
    in:
      - id: reference
        source: reference
      - id: input
        source: samtools_index/indexed_bam
      - id: bqsr_recal_file
        source: gatk_baserecalibrator/recalibration_table
    out:
      - id: recal_bam
    run: ./gatk-applybqsr.cwl
    label: gatk-ApplyBQSR
    'sbg:x': 1228.629638671875
    'sbg:y': 132.9427490234375
  - id: samtools_index_1
    in:
      - id: input_bam
        source: gatk_applybqsr/recal_bam
    out:
      - id: indexed_bam
    run: ./samtools-index.cwl
    label: samtools-index
    'sbg:x': 1296.5589599609375
    'sbg:y': 284.1985778808594
  - id: gatk_haplotypecallergvcf
    in:
      - id: input
        source: samtools_index_1/indexed_bam
      - id: reference
        source: reference
    out:
      - id: gvcf
    run: ./gatk-haplotypecallergvcf.cwl
    label: gatk-HaplotypeCallerGVCF
    'sbg:x': 1374.744140625
    'sbg:y': 87.52862548828125
requirements:
  - class: ScatterFeatureRequirement
