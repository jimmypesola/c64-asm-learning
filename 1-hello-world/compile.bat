acme -o 1-hello-world.prg -f cbm 1-hello-world.asm
c1541 -format "examples,1a" d64 1-hello-world.d64
c1541 -attach 1-hello-world.d64 -write 1-hello-world.prg 1-hello.prg

