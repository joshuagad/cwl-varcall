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
        - name: read_group_name
          type: string
        - name: library_name
          type: string
        - name: platform
          type: string
        - name: platform_unit
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
  - id: read_group_name
    type: string
    outputBinding:
      outputEval: $(inputs.input.read_group_name)
  - id: library_name
    type: string
    outputBinding:
      outputEval: $(inputs.input.library_name)
  - id: platform
    type: string
    outputBinding:
      outputEval: $(inputs.input.platform)
  - id: platform_unit
    type: string
    outputBinding:
      outputEval: $(inputs.input.platform_unit)
label: parseReads
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.input.reads1)
      - $(inputs.input.reads2)
  - class: InlineJavascriptRequirement
