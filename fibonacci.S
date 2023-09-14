;;; Sahil Patel
;;; 119012512
;;; spatel88

;;; Implementation that computes the nth fibonacci number.

    .global fib                 ; exposes fib as a label for the linker
fib:                            ; the label: the next instruction starts fib() function.
    tst r24                     ; Base case (if n == 0)
    breq 1f                     ; Branching to 1, forward
    cpi r24, 1                  ; Base case (if n == 1)
    breq 2f                     ; Branching to 2, forward

    subi r24, 1                 ; Computing n-1 value 
    push r24                    ; Save the value of n - 1
    push r25                    ; Save the value of n - 1 (high byte)

    call fib                    ; Recursive call on n-1
    movw r18, r24               ; Saving value of fib(n-1) call

    pop r25                     ; Retrieving n-1 value (hi byte)
    pop r24                     ; Retrieving n-1 value 

    push r18                    ; Saving value of fib(n-1)
    push r19                    ; Saving value of fib(n-1) (high byte)
    subi r24, 1                 ; Computing n-2 value
    call fib                    ; 2nd Recursive call on n-2 
    pop r19                     ; Restoring value of fib(n-1) (high byte)
    pop r18                     ; Restoring value of fib(n-1)
    
    add r24, r18                ; Adding low byte of both fib(n-1) & fib(n-2)
    adc r25, r19                ; Adding hi byte of both fib(n-1) & fib(n-2)

    ret                         ; Returning

1:  clr r24                     ; Base case result 
    clr r25                     ; Setting to zero
    ret                         ; Returtning

2:  ldi r24, 1                  ; Another base case result 
    clr r25                     ; Setting to zero
    ret                         ; returns.  necessary.
