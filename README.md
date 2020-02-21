# CWL-GATK4 Variant Calling Pipeline
This is a GATK4 Variant Calling pipeline developed on top of the Common Workflow Language (CWL).

## Prerequisites
Use the package manager [pip](https://pip.pypa.io/en/stable/) to install cwltool. You must also have installed [singularity](https://singularity.lbl.gov/) on your system.
```bash
pip install cwltool
```

## Pipeline Usage

```bash
## Standard pipeline
cwltool --singularity varcall-standard.cwl <job.yaml>
## Spark-enabled pipeline
cwltool --singularity varcall-spark.cwl <job.yaml>
```
The job.yaml file must contain the information for your current job. It is formatted as:
```yaml
reference:
  class: File
  path: /path/to/ref.fa
reads1:
  - class: File
    path: /path/to/readsA.fq
  - class: File
    path: /path/to/readsB.fq
reads2:
  - class: File
    path: /path/to/readsA.fq
  - class: File
    path: /path/to/readsB.fq
sample_name:
  - sampleA
  - sampleB
platform: ILLUMINA
```
The pipeline can take in multiple samples, for as long as the paths are properly formatted in the job.yaml file.
