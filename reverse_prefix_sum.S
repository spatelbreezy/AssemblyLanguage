;;; Sahil Patel
;;; 119012512
;;; spatel88
    .data
pctd:
        .asciz "%d" ; Format string without a space
spctd:
        .asciz " %d" ; Format string with a space
    
    .text

;;; Implementation that transforms an array by adding the value at an index to the sum of the remainder of the array.
    .global reverse_prefix_sum                 ; exposes reverse_prefix_sum as a label for the linker
reverse_prefix_sum:                            ; the label: the next instruction starts reverse_prefix_sum() function.
    movw r26, r24 ; Moving array pointer to the X registers
    ld r22, X ; Loading the first element into the r22 register
    cpi r22, -1 ; Checking if the first value is -1 
    breq 1f ; if it is, then go to end and return 0 (branch 1 forward)

    push r27 ; Pushing r27:r26 to stack to safe pointer to the array
    push r26 ; Pushing r27:r26 to stack to safe pointer to the array
    push r23 ; Pushing r23 to stack to save
    push r22 ; Pushing r22 to stack to save

    adiw r26, 1 ; Pointing to next element in array
    movw r24, r26 ; Moving that next element pointer into r24:r25 so it can be used by next recursive call
    call reverse_prefix_sum ; Stores result in r24:r25
 
    pop r22 ; Retrieving original value in r22
    pop r23 ; Retrieving original value in r23
    pop r26 ; Retrieving original pointer in r26
    pop r27 ; Retrieving original pointer in r27

    clr r23 ; Clearing r23 so proper addition can happen 
    add r24, r22 ; Adding result with original value in array (element)
    adc r25, r23 ; Adding w/ carry to update high byte

    st X, r24 ; Storing the low byte of the result into the array
    ret ; Returning
1:
    clr r24 ; Returning 0
    clr r25 ; Returning 0
    ret ; Returning

    .global print_array
print_array:
    movw r26, r24 ; X register now pointing to array
        
    clr r25 ; Setting r25 to 0 to remove any possible problems 
    ld r24, X ; Loading first element of array into r24 register
    ldi r20, 1 ; Loading r20 with 1 to twos complement it
    neg r20 ; Getting twos complement of 1 (-1)

    cp r24, r20 ; Checking if the integer is -1 
    breq 1f ; if it is, than go to the end

    ldi r22, lo8(pctd) ; Loading the address of the format string
    ldi r23, hi8(pctd) ; Loading the address of the format string (high)
    push r20 ; Saving values
    push r26 ; Saving values
    push r27 ; Saving values
    call pint ; Calling pint function to print the integer in the r24 register
    pop r27 ; Retrieving values
    pop r26 ; Retrieving values
    pop r20 ; Retrieving values

    ldi r22, lo8(spctd) ; Loading the address of the format string with a space
    ldi r23, hi8(spctd) ; Loading th address of the format string with a space (high)
        
2:
    adiw r26, 1 ; Increment the pointer to point to next element
    ld r24, X ; Loading next element of array into r0 register and post-incrementing
    cp r24, r20 ; Checking loop condition (is the element == -1?)
    breq 1f ; if the element is -1 than branch out of loop 

    push r20 ; Saving values
    push r26 ; Saving values
    push r27 ; Saving values
    call pint ; Calling pint function to print the integer in the r24 register
    pop r27 ; Retrieving values
    pop r26 ; Retrieving values
    pop r20 ; Retrieving values
    jmp 2b ; Jump back into to top of loop for next iteration
    

1:  call prt_newline ; Calling prt_newline function
    clr r0 ; Clearing temp values
    clr r1 ; Setting back to zero
    ret


;;; Prints an integer value assuming the format string has already been pushed to register pair r23:r22
pint: 
    push r25 ; Hi byte of integer value
    push r24 ; Low byte of integer value
    push r23 ; Hi byte of format string (either pctd or spctd)
    push r22 ; Low byte of format string
    call printf ; Calling printf function with the parameters in the stack
    pop r22  ; Retrieving information
    pop r23 ; Retrieving information
    pop r24 ; Retrieving information
    pop r25 ; Retrieving information
    clr r0 ; Clearing temp values
    clr r1 ; Setting back to zero
 
    ret ; Returning

pint_space:
    push r25 ; Hi byte of integer value
    push r24 ; Low byte of integer value
    push r23 ; Hi byte of format string (either pctd or spctd)
    push r22 ; Low byte of format string
    call printf ; Calling printf function with the parameters in the stack
    pop r22  ; Retrieving information
    pop r23 ; Retrieving information
    pop r24 ; Retrieving information
    pop r25 ; Retrieving information
    clr r0 ; Clearing temp values
    clr r1 ; Setting back to zero

    ret ; Returning

;;; Prints a new line character
prt_newline:
    clr r25 ; Setting r25 register to zero to prevent any possible issues
    ldi r24, 10 ; Asci value for new line char loaded in r24 register
    call putchar ; Calling putchar to place new line char
    clr r0 ; Clearing temp values
    clr r1 ; Setting back to zero

    ret ; Returning