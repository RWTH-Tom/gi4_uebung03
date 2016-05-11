default:
	nasm -f elf32 -g -F dwarf -l uebung3.lst uebung3.asm && gcc -m32 -g -o uebung3 uebung3.o && rm uebung3.o
