#!/bin/bash

# get PCB input and output files
input="$(basename *.kicad_pro)"
input_sch="${input/.kicad_pro/.kicad_sch}"
input_pcb="$(basename *.kicad_pcb)"
output_sch_pdf="${input_sch/.kicad_sch/.pdf}"
output_pcb_pdf="${input_pcb/.kicad_pcb/_pcb.pdf}"
name="$(basename *.kicad_pro)"
zip_name="${name/.kicad_pro/.zip}"

echo "Export Schmatic to PDF"
kicad-cli sch export pdf $input_sch \
    --no-background-color \
    --output schematic_pdf/$output_sch_pdf

echo "Export PCB to PDF"
kicad-cli pcb export pdf $input_pcb \
    -l "B.Cu,B.Silkscreen,B.Courtyard,B.Fab,F.Cu,F.Silkscreen,F.Courtyard,F.Fab,Edge.Cuts,User.1" \
    --include-border-title \
    --drill-shape-opt 1 \
    --output schematic_pdf/$output_pcb_pdf

echo "Export PCB to Drill"
kicad-cli pcb export drill $input_pcb \
    --drill-origin plot \
    --output gerber/

echo "Export PCB to Gerbers"
kicad-cli pcb export gerbers $input_pcb \
    --output gerber/ \
    --use-drill-file-origin \
    --layers "F.Cu,F.Paste,F.Silkscreen,F.Mask,B.Cu,B.Paste,B.Silkscreen,B.Mask,Edge.Cuts"

echo "Compress Gerbers"
zip -r gerber/$zip_name gerber/
