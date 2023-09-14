;;; Sahil Patel
;;; 119012512
;;; spatel88

;;; Implementation that determines if a string is a palindrome (same forward as backward).

    .global is_palindrome                   ; exposes is_palindrome as a label for the linker
is_palindrome:                              ; the label: the next instruction starts is_palindrome() function.
    push r16 ; Pushing r16 value to stack (callee-save)

    movw r26, r24  ; X register pointing to string
    movw r30, r24  ; Z register pointing to string

    push r26 ; Saving value of X register
    push r27 ; Saving value of X register
    call Strlen ; Calling strlen to calculate length of string and place length in r25:r24
    pop r27 ; Retrieving value of X register
    pop r26 ; Retrieving value of X register

    mov r18, r24 ; Moving strlen result in register r18
    clr r24 ; Clearing return value
    clr r25 ; (Not necessary but still included)
    clr r0  ; Clearing from previous Strlen call
    clr r1 ; Clearing r1 before use

    ldi r16, 0 ; Iteration variable
    add r26, r18 ; X register now points to the end of the string

    tst r18 ; Checking if length is 0 
    breq 2f ; Jumps to 2 forward if zero (is a palindrome)

    lsr r18 ; Dividing length / 2

1:  cp r16, r18 ; r18 - r16 (iteration - length)
    brsh 2f ; if the iteration >= length

    dec r26; Decreming the x register
    ld r0, Z+ ; Post increment to point to next char on next b iteration
    ld r1, X ; Loading char at end of string
    cp r0, r1 ; Comparing the chars 
    brne 3f ; not a palindrome if the 2 char are not equal (3 forward)

    inc r16 ; Incrementing the iteration variable
    jmp 1b ; Jumping to 1 backward

2:  ldi r24, 1 ; Is a palindrome 
    clr r25 ; Setting to zero
    clr r1 ; Clearing r1 
    pop r16 ; Retrieiving original r16 value from stack
    ret ; Returning

3:  clr r24 ; not a palindrome
    clr r25 ; Setting to zero
    clr r1 ; Clearing r1
    pop r16 ; Retrieving original r16 value from stack
    ret ; Returning


;;; Strlen
Strlen:
    ;;; uint16_t Strlen(char *arg)
    ;; copy argument to X (r27:26) pointer
    movw r26, r24 ; Moving argument into x register
    ;; initialize return value to zero
    clr r24 ; Setting to zero
    clr r25 ; Setting to zero
2:  
    ;; load X with post-increment
    ld r0, X+ ; Loading r0 with value 
    ;; if loaded value was zero, branch 1f (label 1, forward)
    tst r0 ; Checking if zero 
    breq 1f ; if it is zero than branch to 1, forward

    ;; increment return value
    inc r24 ; Incrementing count value
    ;; check for overflow
    tst r24 ; Check if it is over 255
    breq 3f ; if it is than branch to 3 forward

    ;; jump 2b (label 2, backward)
    jmp 2b ; Go back to beginning of loop
3: 
    ;; increment high byte of return value
    inc r25 ; Increment hi byte if necessary
    ;; jump 2b (label 2, backward)
    jmp 2b ; Jump back to beginning of loop

1:
    ;; return
    ret ; Returning