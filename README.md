# c64-asm-learning
Just some learning

## Vice Emulator - How to:
1. Attach the d64 file to drive # 8 from file menu
2. Below the READY prompt, type:
   LOAD "$",8
   LIST
   LOAD "<program-name>",8,1

3. The program will load to address $c000 as in example.
4. $c000 is 49152 in decimal, type SYS 49152 to start the program.
