class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: fastp
baseCommand:
  - fastp
inputs:
  - id: in1
    type: File
    inputBinding:
      position: 1
      prefix: '--in1'
  - id: in2
    type: File
    inputBinding:
      position: 3
      prefix: '--in2'
  - id: custom_args
    type: string?
    inputBinding:
      position: 8
outputs:
  - id: out1_cleaned
    type: File
    outputBinding:
      glob: $('cleaned.' + inputs.in1.basename)
  - id: out1_unpaired
    type: File
    outputBinding:
      glob: $('unpaired.' + inputs.in1.basename)
  - id: out2_cleaned
    type: File
    outputBinding:
      glob: $('cleaned.' + inputs.in2.basename)
  - id: out2_unpaired
    type: File
    outputBinding:
      glob: $('unpaired.' + inputs.in2.basename)
  - id: report_json
    type: File
    outputBinding:
      glob: $(inputs.in1.basename + '.json')
  - id: report_html
    type: File
    outputBinding:
      glob: $(inputs.in1.basename + '.html')
label: fastp-paired
arguments:
  - position: 0
    prefix: '-w'
    valueFrom: $(runtime.cores)
  - position: 2
    prefix: '--out1'
    valueFrom: $('cleaned.' + inputs.in1.basename)
  - position: 4
    prefix: '--out2'
    valueFrom: $('cleaned.' + inputs.in2.basename)
  - position: 5
    prefix: '--unpaired1'
    valueFrom: $('unpaired.' + inputs.in1.basename)
  - position: 6
    prefix: '--unpaired2'
    valueFrom: $('unpaired.' + inputs.in2.basename)
  - position: 7
    prefix: '--json'
    valueFrom: $(inputs.in1.basename + '.json')
  - position: 8
    prefix: '--html'
    valueFrom: $(inputs.in1.basename + '.html')
requirements:
  - class: DockerRequirement
    dockerPull: 'pgcbioinfo/fastp:0.20.0'
  - class: InlineJavascriptRequirement
