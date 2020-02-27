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
        - name: rg_sample
          type: string
        - name: rg_id
          type: string
        - name: rg_library
          type: string
        - name: rg_platform
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
  - id: rg_sample
    type: string
    outputBinding:
      outputEval: $(inputs.input.rg_sample)
  - id: rg_id
    type: string
    outputBinding:
      outputEval: $(inputs.input.rg_id)
  - id: rg_library
    type: string
    outputBinding:
      outputEval: $(inputs.input.rg_library)
  - id: rg_platform
    type: string
    outputBinding:
      outputEval: $(inputs.input.rg_platform)
label: parseReads
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.input.reads1)
      - $(inputs.input.reads2)
  - class: InlineJavascriptRequirement
