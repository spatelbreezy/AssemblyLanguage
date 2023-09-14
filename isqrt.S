;;; Sahil Patel
;;; 119012512
;;; spatel88

;;; Implementation that computes the square root of an integer using the bitwise algorithm.

    .global isqrt                 ; exposes isqrt as a label for the linker
isqrt:                            ; the label: the next instruction starts isqrt() function.
    cpi r24, 2      ; Comparing parameter n value to 2
    brlo return_n   ; If n < 2, return n

    mov r30, r24    ; Move value of n into r30
    push r30        ; Saving original n value

    lsr r24         ; One logical shift to the right
    lsr r24         ; One logical shift to the right
    call isqrt      ; Recursive call (result of n >> 2 stored in r24)
    lsl r24         ; One logical shift to the left on result value after recursive call

    pop r30         ; Retrieving original n value
    mov r18, r24    ; Move new small value into r18
    mov r20, r18    ; Duplicate value for large value
    inc r20         ; large = small + 1

    mul r20, r20    ; Multiplying large * large
    cp r30, r0      ; if n < (large * large)
    brlo return_small ; Branch if true

    ; Return large as the result
    mov r24, r20 ; Moving value into return registers
    ret ; Returning

return_small:
    ; Return small as the result
    mov r24, r18 ; Moving value into return registers
    ret ; Returning
return_n:
    ; Return n as the result
    ret ; Returning