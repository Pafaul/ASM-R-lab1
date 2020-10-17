/* описания для main.c */
 .text
      .global Start_DSP
      .global InA
      .global InB
      .global InC
      .global OutC


/* сегмент кода */
Start_DSP:
        MOVE (A0),R0.L
        MOVE (A1),R2.L
        MOVE (A2),R4.L

/*StartLoop:*/
        DO R4,DoEnd
        FMPY R0.L,R2.L,R8.L
        MOVE R8.L,R2.L
DoEnd:
        /*DECL R4.L,R4.L
        J.ne StartLoop */

        MOVE R2,(A3)
        STOP




/* сегмент данных */
 .data
InA:  .float 0
InB:  .float 0
InC:  .word 0
OutC: .float 0
 .end
