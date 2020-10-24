/* описания для main.c */
 .text
      .global Start_DSP
      .global ArrayIn
      .global OutValue

/* сегмент кода */
Start_DSP:
                /* Инициаизация */
                MOVE ArrayIn, A1
                MOVE OutValue, A2

                /* Заполнение массива с использованием значения в R0
                   Наибольшимй элемент должен быть [5][6] */
                MOVE 50,R0.L
                DO 49, FillArray
                SUBL 1,R0.L
FillArray:      MOVE R0,(A1)+

                /* Задаём начальное значение элемента массива, предполагая
                   что все элементы неотрицательные */
                MOVE 0,R0.L
                MOVE R0.L,(A2)

                /* Восстанавливаем значение адреса */
                MOVE ArrayIn, A1

                /*
                  R0 - счётчик для строк
                  R2 - счётчик для столбцов, сбрасывется после каждой строки
                  Начальное значение для новой строки: R2=R0+1
                  R4 - счётчик текущего элемента
                  Вычисление: R4=(R0*7)+R2
                */
                MOVE 0,R0.L

                /* Итерация по строкам
                   Интересующие нас строки - от 0 до 5 включительно */
IterateRow:     CMPL 6,R0.L
                /* Если дошли до последней строки - выход */
                J.eq LoopEnd

                /* Задаём начальный элемент в строке */
                MOVE R0.L,R2.L
                ADDL 1,R2.L,R2.L

                /* Интересующие элементы в строке - от R0+1 до 6 включительно */
IterateCol:     CMPL 6,R2.L
                /* Если R2>6, значит обход по строке завершён, увеличиваем на 1
                   счётчик строк */
                ADDL.gt 1,R0.L,R0.L
                J.t IterateRow

                /* Вычисляем номер текущего элемента */
                MOVE 7,R4.L
                MPYL R0.L,R4.L
                ADDL R2.L,R4.L
                MOVE R4,I1

                /* Получаем значение текущего элемента массива */
                MOVE (A1+I1),R6.L
                MOVE (A2),R8.L
                /* Сравниваем текущий элемент с максимальным на данный момент */
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

/* сегмент данных */
 .data
OutValue: .word 0
ArrayIn: .space 49*4, 0x01
 .end
