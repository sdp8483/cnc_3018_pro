# About this directory
Gerber Output Files go here.

# CNC PCB Mill GCODE Generation
Edit `millproject` with filenames. Adjust mill diameter as needed.
Run `pcb2gcode` to use millproject for creating backside milled PCB.

For front silkscreen edit `millproject_fsilk` with filenames and x-offset.
Run `pcb2gcode --config=milLproject_fsilk` to create front silkscreen gcode.
