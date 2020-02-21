class: Workflow
cwlVersion: v1.0
id: varcall
label: varcall-standard
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: sample_name
    type: 'string[]'
    'sbg:x': -2.8485500812530518
    'sbg:y': 423.2580261230469
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
    'sbg:x': -8.497928619384766
    'sbg:y': 12.605132102966309
  - id: platform
    type: string
    'sbg:x': -1
    'sbg:y': 570.4046630859375
  - id: reads2
    type: 'File[]'
    'sbg:x': -6
    'sbg:y': 148
  - id: reads1
    type: 'File[]'
    'sbg:x': -6.9248809814453125
    'sbg:y': 289
outputs:
  - id: gvcf
    outputSource:
      - gatk_haplotypecallergvcf/gvcf
    type:
      - File
      - type: array
        items: File
    'sbg:x': 1145.0751953125
    'sbg:y': 124
  - id: result_sam
    outputSource:
      - bwa_mem/result_sam
    type:
      - File
      - type: array
        items: File
    'sbg:x': 304.93255615234375
    'sbg:y': -88.67449188232422
  - id: output
    outputSource:
      - gatk_addorreplacereadgroups/output
    type:
      - File
      - type: array
        items: File
    'sbg:x': 491.4662780761719
    'sbg:y': 661.3841552734375
  - id: markdup_bam
    outputSource:
      - gatk_markduplicatesspark/markdup_bam
    type:
      - File
      - type: array
        items: File
    'sbg:x': 732.275634765625
    'sbg:y': 665.225830078125
  - id: vcf
    outputSource:
      - gatk_haplotypecaller/vcf
    type:
      - File
      - type: array
        items: File
    'sbg:x': 520.0674438476562
    'sbg:y': -87.20234680175781
  - id: recalibration_table
    outputSource:
      - gatk_baserecalibrator/recalibration_table
    type:
      - File
      - type: array
        items: File
    'sbg:x': 736.4603881835938
    'sbg:y': -89
  - id: recal_bam
    outputSource:
      - gatk_applybqsr/recal_bam
    type:
      - File
      - type: array
        items: File
    'sbg:x': 993.1906127929688
    'sbg:y': 651.49853515625
steps:
  - id: bwa_mem
    in:
      - id: sample_name
        source: sample_name
      - id: indexed_reference
        source: reference
      - id: in1
        source: reads1
      - id: in2
        source: reads2
    out:
      - id: result_sam
    run: ./bwa-mem.cwl
    label: bwa-mem
    scatter:
      - sample_name
      - in1
      - in2
    scatterMethod: dotproduct
    'sbg:x': 216.4545135498047
    'sbg:y': 245.23739624023438
  - id: gatk_addorreplacereadgroups
    in:
      - id: input
        source: bwa_mem/result_sam
      - id: rglb
        source: sample_name
      - id: rgpl
        source: sample_name
      - id: rgpu
        source: platform
      - id: rgsm
        source: sample_name
    out:
      - id: output
    run: ./gatk-addorreplacereadgroups.cwl
    label: gatk-AddOrReplaceReadGroups
    scatter:
      - input
      - rglb
      - rgpl
      - rgsm
    scatterMethod: dotproduct
    'sbg:x': 373.2916564941406
    'sbg:y': 473.4861145019531
  - id: gatk_markduplicatesspark
    in:
      - id: input
        source: gatk_addorreplacereadgroups/output
    out:
      - id: markdup_bam
    run: ./gatk-markduplicatesspark.cwl
    label: gatk-MarkDuplicatesSpark
    scatter:
      - input
    scatterMethod: dotproduct
    'sbg:x': 532.3472290039062
    'sbg:y': 463.8055419921875
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
    'sbg:x': 451.4444274902344
    'sbg:y': 265.3333435058594
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
    'sbg:x': 655.6666870117188
    'sbg:y': 221.02032470703125
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
    'sbg:x': 866.5416870117188
    'sbg:y': 197.4722137451172
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
    'sbg:x': 1014.1388549804688
    'sbg:y': 124.69445037841797
requirements:
  - class: ScatterFeatureRequirement
