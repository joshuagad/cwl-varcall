class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: parsereads
baseCommand:
  - echo
inputs:
  - id: input
    type:
      type: record
      fields:
        - name: reads1
          type: File
        - name: reads2
          type: File?
        - name: rgsm
          type: string
        - name: rgid
          type: string
        - name: rglb
          type: string
        - name: rgpl
          type: string
        - name: rgpu
          type: string
      name: input
outputs:
  - id: reads1
    type: File
    outputBinding:
      glob: $(inputs.input.reads1.basename)
  - id: reads2
    type: File
    outputBinding:
      glob: $(inputs.input.reads2.basename)
  - id: rgsm
    type: string
    outputBinding:
      outputEval: $(inputs.input.rgsm)
  - id: rgid
    type: string
    outputBinding:
      outputEval: $(inputs.input.rgid)
  - id: rglb
    type: string
    outputBinding:
      outputEval: $(inputs.input.rglb)
  - id: rgpl
    type: string
    outputBinding:
      outputEval: $(inputs.input.rgpl)
  - id: rgpu
    type: string
    outputBinding:
      outputEval: $(inputs.input.rgpu)
label: parseReads
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.input.reads1)
      - $(inputs.input.reads2)
  - class: InlineJavascriptRequirement
