# CWL-GATK4 Variant Calling Pipeline
This is a GATK4 Variant Calling pipeline developed on top of the Common Workflow Language (CWL).

## Prerequisites
Use the package manager [pip](https://pip.pypa.io/en/stable/) to install cwltool. You must also have installed [singularity](https://singularity.lbl.gov/) and [node](https://nodejs.org/) on your system.
```bash
pip install cwltool
```
The main programs **varcall-standard** and **varcall-spark** may be copied to PATH as is.

## Pipeline Usage

```bash
## Standard pipeline
./varcall-standard <job.yaml>
```
The job.yaml file must contain the information for your current job. It is formatted as:
```yaml
reference:
  class: File
  path: /path/to/ref.fa
sample_name: sample
input:
  - read_group_name: readsA
    reads1:
      class: File
      path: /path/to/readsA.1.fq
    reads2:
      class: File
      path: /path/to/readsA.2.fq
    library_name: library
    platform: ILLUMINA
    platform_unit: readsA
  - read_group_name: readsB
    reads1:
      class: File
      path: readsB.1.fq
    reads2:
      class: File
      path: readsB.2.fq
    library_name: library
    platform: ILLUMINA
    platform_unit: readsB
```
It is important to classify reads according to the sequencing experiment design as the recalibration will take these into account in removing biases.
**read_group_name** - Unique identifier for a read group's sequencing run
**library_name** - Identifier for library used
**platform** - Sequencing platform used
**platform_unit** - Usually the same as read_group_name but required by GATK

The pipeline must only be run for one sample at a time with all libraries / sequencing data laid out in the yaml file.
