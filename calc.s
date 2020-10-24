/* �������� ��� main.c */
 .text
      .global Start_DSP
      .global ArrayIn
      .global OutValue

/* ������� ���� */
Start_DSP:
                /* ������������ */
                MOVE ArrayIn, A1
                MOVE OutValue, A2

                /* ���������� ������� � �������������� �������� � R0
                   ����������� ������� ������ ���� [5][6] */
                MOVE 50,R0.L
                DO 49, FillArray
                SUBL 1,R0.L
FillArray:      MOVE R0,(A1)+

                /* ����� ��������� �������� �������� �������, �����������
                   ��� ��� �������� ��������������� */
                MOVE 0,R0.L
                MOVE R0.L,(A2)

                /* ��������������� �������� ������ */
                MOVE ArrayIn, A1

                /*
                  R0 - ������� ��� �����
                  R2 - ������� ��� ��������, ����������� ����� ������ ������
                  ��������� �������� ��� ����� ������: R2=R0+1
                  R4 - ������� �������� ��������
                  ����������: R4=(R0*7)+R2
                */
                MOVE 0,R0.L

                /* �������� �� �������
                   ������������ ��� ������ - �� 0 �� 5 ������������ */
IterateRow:     CMPL 6,R0.L
                /* ���� ����� �� ��������� ������ - ����� */
                J.eq LoopEnd

                /* ����� ��������� ������� � ������ */
                MOVE R0.L,R2.L
                ADDL 1,R2.L,R2.L

                /* ������������ �������� � ������ - �� R0+1 �� 6 ������������ */
IterateCol:     CMPL 6,R2.L
                /* ���� R2>6, ������ ����� �� ������ ��������, ����������� �� 1
                   ������� ����� */
                ADDL.gt 1,R0.L,R0.L
                J.t IterateRow

                /* ��������� ����� �������� �������� */
                MOVE 7,R4.L
                MPYL R0.L,R4.L
                ADDL R2.L,R4.L
                MOVE R4,I1

                /* �������� �������� �������� �������� ������� */
                MOVE (A1+I1),R6.L
                MOVE (A2),R8.L
                /* ���������� ������� ������� � ������������ �� ������ ������ */
                CMPL R6.L,R8.L
                MOVE.lt R6.L,(A2)
                /*
                        J.gt ChangeMaxVal
                */

ContinueCycle:  ADDL 1,R2.L,R2.L
                J IterateCol

LoopEnd:
                STOP
/*
ChangeMaxVal:   MOVE R6.L,(A2)
                J ContinueCycle
*/

/* ������� ������ */
 .data
OutValue: .word 0
ArrayIn: .space 49*4, 0x01
 .end
