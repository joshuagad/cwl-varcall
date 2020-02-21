class: Workflow
cwlVersion: v1.0
id: varcall
label: varcall-spark
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: reads1
    type:
      - File
      - type: array
        items: File
    'sbg:x': -107
    'sbg:y': 484
  - id: reads2
    type:
      - 'null'
      - File
      - type: array
        items: File
    'sbg:x': -107
    'sbg:y': 375
  - id: platform
    type: string
    'sbg:x': -110
    'sbg:y': 261
  - id: sample_name
    type:
      - string
      - type: array
        items: string
    'sbg:x': -109
    'sbg:y': 136
  - id: reference
    type: File
    secondaryFiles:
      - .img
      - ^.dict
      - .fai
    'sbg:x': -111
    'sbg:y': 13
outputs:
  - id: unmapped_bam
    outputSource:
      - gatk_fastqtosam/unmapped_bam
    type:
      - File
      - type: array
        items: File
    'sbg:x': 216
    'sbg:y': 514
  - id: output
    outputSource:
      - gatk_bwaspark_1/output
    type:
      - File
      - type: array
        items: File
    'sbg:x': 321
    'sbg:y': 512
  - id: markdup_bam
    outputSource:
      - gatk_markduplicatesspark/markdup_bam
    type:
      - File
      - type: array
        items: File
    'sbg:x': 431
    'sbg:y': 508
  - id: gvcf
    outputSource:
      - gatk_haplotypecallergvcf/gvcf
    type:
      - File
      - type: array
        items: File
    'sbg:x': 919
    'sbg:y': 48
  - id: vcf
    outputSource:
      - gatk_haplotypecaller/vcf
    type:
      - File
      - type: array
        items: File
    'sbg:x': 296.6875
    'sbg:y': -75.5
  - id: recalibration_table
    outputSource:
      - gatk_baserecalibrator/recalibration_table
    type:
      - File
      - type: array
        items: File
    'sbg:x': 495
    'sbg:y': -78
  - id: recal_bam
    outputSource:
      - gatk_applybqsr/recal_bam
    type:
      - File
      - type: array
        items: File
    'sbg:x': 689
    'sbg:y': -70
steps:
  - id: gatk_fastqtosam
    in:
      - id: fastq1
        source: reads1
      - id: fastq2
        source: reads2
      - id: sample_name
        source: sample_name
      - id: library_name
        source: sample_name
      - id: platform
        source: platform
      - id: platform_unit
        source: sample_name
    out:
      - id: unmapped_bam
    run: ./gatk-fastqtosam.cwl
    label: gatk-FastqToSam
    scatter:
      - fastq1
      - fastq2
      - sample_name
      - library_name
      - platform_unit
    scatterMethod: dotproduct
    'sbg:x': 84
    'sbg:y': 388
  - id: gatk_bwaspark_1
    in:
      - id: input
        source: gatk_fastqtosam/unmapped_bam
      - id: reference
        source: reference
    out:
      - id: output
    run: ./gatk-bwaspark.cwl
    label: gatk-BwaSpark
    scatter:
      - input
    scatterMethod: dotproduct
    'sbg:x': 147
    'sbg:y': 237
  - id: gatk_markduplicatesspark
    in:
      - id: input
        source: gatk_bwaspark_1/output
    out:
      - id: markdup_bam
    run: ./gatk-markduplicatesspark.cwl
    label: gatk-MarkDuplicatesSpark
    scatter:
      - input
    scatterMethod: dotproduct
    'sbg:x': 306
    'sbg:y': 320
  - id: gatk_haplotypecaller
    in:
      - id: input
        source: gatk_markduplicatesspark/markdup_bam
      - id: reference
        source: reference
    out:
      - id: vcf
    run: ./gatk-haplotypecallervcf.cwl
    label: gatk-HaplotypeCallerVCF
    scatter:
      - input
    scatterMethod: dotproduct
    'sbg:x': 224
    'sbg:y': 105
  - id: gatk_baserecalibrator
    in:
      - id: input
        source: gatk_markduplicatesspark/markdup_bam
      - id: known_sites
        source: gatk_haplotypecaller/vcf
      - id: reference
        source: reference
    out:
      - id: recalibration_table
    run: ./gatk-baserecalibrator.cwl
    label: gatk-BaseRecalibrator
    scatter:
      - input
      - known_sites
    scatterMethod: dotproduct
    'sbg:x': 446
    'sbg:y': 122
  - id: gatk_applybqsr
    in:
      - id: reference
        source: reference
      - id: input
        source: gatk_markduplicatesspark/markdup_bam
      - id: bqsr_recal_file
        source: gatk_baserecalibrator/recalibration_table
    out:
      - id: recal_bam
    run: ./gatk-applybqsr.cwl
    label: gatk-ApplyBQSR
    scatter:
      - input
      - bqsr_recal_file
    scatterMethod: dotproduct
    'sbg:x': 654
    'sbg:y': 103
  - id: gatk_haplotypecallergvcf
    in:
      - id: input
        source: gatk_applybqsr/recal_bam
      - id: reference
        source: reference
    out:
      - id: gvcf
    run: ./gatk-haplotypecallergvcf.cwl
    label: gatk-HaplotypeCallerGVCF
    scatter:
      - input
    scatterMethod: dotproduct
    'sbg:x': 786
    'sbg:y': 48
requirements:
  - class: ScatterFeatureRequirement
