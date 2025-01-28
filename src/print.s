// DID YOU KNOW THAT ARM64 IS 16 BYTE ALIGNED???
// AND THAT YOU CAN'T SAVE JUST ONE REGISTER BY OFFSETTING 8 BYTES?!
// AAAAAAAAAAAAAAAAAAA
.text

.global _day_asm_7

_day_asm_7:
        // Store registers
        stp fp, lr, [sp, #-16]!

        mov X1, #00
        mov X2, X0
        ldrb W3, [X2]
        loop:
                cmp X3, #00
                b.eq loop_end
                add X1, X1, #01
                add X2, X2, #01
                ldrb W3, [X2]
                b loop
        loop_end:
        // Malloc size
        mov X4, X1
        add X4, X4, #20
        add X4, X4, #01
        // Malloc call
        // Store registers
        str X1, [sp, #-16]!
        stp X0, X4, [sp, #-16]!
        mov X0, X4
        bl _malloc
        ldp X1, X2, [sp], #16
        ldr X3, [sp], #16
        // X0 has new ptr
        // X1 has old ptr
        // X2 has num of malloc'd bytes
        // X3 has strlen of old ptr
        mov X4, #00
        loop2:
                cmp X4, X3
                b.gt loop2_end
                ldrb W5, [X1, X4]
                strb W5, [X0, X4]
                add X4, X4, #01
                b loop2
        loop2_end:
        mov X4, #00
        mov X8, #20
        adr X6, today
        loop3:
                cmp X4, X8
                b.gt loop3_end
                ldrb W5, [X6, X4]
                add X7, X3, X4
                strb W5, [X0, X7]
                add X4, X4, #01
                b loop3
        loop3_end:
        add X7, X3, X4
        add X7, X0, X7
        mov X7, #00
        // Free call
        str X0, [sp, #-16]!
        mov X0, X1 
        bl _free
        ldr X0, [sp], #16
        // Return
        ldp fp, lr, [sp], #16
        ret lr

today: .asciz "Seven access errors\n"
