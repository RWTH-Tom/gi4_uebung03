global  main
extern  puts

section .data
  x dd 4
  ergebnis dd 0
  koeffizienten dd 33,2,7

section .text
main:
  call aufgabe1
  call aufgabe2
  mov ebx, koeffizienten
  call aufgabe3
  call aufgabe4

  mov ebx, 0      ; damit wird der Exitcode auf 0 gesetzt,
  mov eax, 1      ; somit wurde das Program erfolgreich
  int 0x80        ; ausgefuehrt und beendet

aufgabe1:
  mov eax, -5     ; eax = -5
  mov ebx, 4      ; ebx = 4
  imul ebx, 2     ; ebx = 4*2
  add eax, ebx    ; eax = 4*2 - 5
  mov ebx, 3      ; ebx = 3
  imul ebx, 2     ; ebx = 3*2
  imul ebx, 2     ; ebx = 3*2*2
  add eax, ebx    ; eax = 3*2*2 + 4*2 -5 = 15

  ret

aufgabe2:
  mov eax, -5           ; eax = -5
  mov ebx, 4            ; ebx = 4
  imul ebx, [x]         ; ebx = 4*x
  add eax, ebx          ; eax = 4*x - 5
  mov ebx, 3            ; ebx = 3
  imul ebx, [x]         ; ebx = 3x
  imul ebx, [x]         ; ebx = 3x*x
  add eax, ebx          ; eax = 3x*x + 4*x -5
  mov [ergebnis], eax   ; ergebnis = 3x*x + 4*x -5

  ret

aufgabe3: ;Speicher ab &x: 0x03 00 00 00 x
                            ;00 00 00 00 Ergebnis
                            ;21 00 00 00 Koeffizienten[0]
                            ;02 00 00 00 Koeffizienten[1]
                            ;07 00 00 00 Koeffizienten[2]
  mov eax, [ebx+8]
  mov ecx, [ebx+4]
  imul ecx, [x]
  add eax, ecx
  mov ecx, [ebx+0]
  imul ecx, [x]
  imul ecx, [x]
  add eax, ecx
  mov [ergebnis], eax

  ret

aufgabe4:
;Hornerschema: ax^2+bx+c = ((a*x)+b)*x+c --> 2 Multiplikationen, 2 additionen
; (vorher: 3 multiplikationen, 2 additionen)
  mov eax, [ebx+0]
  imul eax, [x]
  add eax, [ebx+4]
  imul eax, [x]
  add eax, [ebx+8]

  mov [ergebnis], eax

  ret

aufgabe5:
;Feld mit allen ai, Anzahl der ai müssen bekannt sein.
;Dann eine schleife in der jeweils ein schritt des Hornerschemas berechnet wird
;--> #ai Multiplikationen und #ai Additionen
