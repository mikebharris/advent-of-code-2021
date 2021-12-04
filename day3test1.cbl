identification division.
program-id. AOC-2021-DAY-3-TEST-1.
environment division.
input-output section.
    file-control.
        select InputFile assign to "day3-input.txt"
            organization is line sequential.

data division.
file section.
fd InputFile.
01 filler.
    88 EndOfInputFile       value high-values.
    02 Reading              pic x(12). *> 000011001000

working-storage section.
01 DiagnosticLine.
    02 DiagnosticBit pic 9 occurs 12 times.

01 BitCounter.
    02 BitCount pic 9(4) occurs 12 times.

01 GammaBinaryValue.
    02 GammaBit pic 9 occurs 12 times value zero.
01 EpsilonBinaryValue.
    02 EpsilonBit pic 9 occurs 12 times value zero.

01 GammaDecimalValue pic 9(10) value zero.
01 EpsilonDecimalValue pic 9(10) value zero.
01 TempBitValue pic 9(10).
01 Power pic 9(10) value zero.

01 BitPosition pic 99.

01 NumberOfReadings pic 9999 value zero.

procedure division.
Begin.
    open input InputFile
    read InputFile
        at end set EndOfInputFile to true
    end-read

    perform with test before until EndOfInputFile

        move Reading to DiagnosticLine
        add 1 to NumberOfReadings

        perform with test after varying BitPosition from 1 by 1 until BitPosition is equal to 12
            add DiagnosticBit(BitPosition) to BitCount(BitPosition)
        end-perform

        read InputFile
            at end set EndOfInputFile to true
        end-read

    end-perform

    close InputFile

    display "read " NumberOfReadings " readings from diagnostics report"

    *> Gamma is the most common bit, epsilon is least common

    perform with test after varying BitPosition from 1 by 1 until BitPosition is equal to 12
        if BitCount(BitPosition) is greater than or equal to NumberOfReadings / 2 then
            move 1 to GammaBit(BitPosition)
            move 0 to EpsilonBit(BitPosition)
        else
            move 0 to GammaBit(BitPosition)
            move 1 to EpsilonBit(BitPosition)
        end-if
    end-perform

    display "epsilon value = " EpsilonBinaryValue " gamma value = " GammaBinaryValue

    perform with test after varying BitPosition from 1 by 1 until BitPosition is equal to 12
        compute TempBitValue = 2 ** (12 - BitPosition)
        if GammaBit(BitPosition) is equal to 1 then
            add TempBitValue to GammaDecimalValue
        end-if
        if EpsilonBit(BitPosition) is equal to 1 then
            add TempBitValue to EpsilonDecimalValue
        end-if
        display "2 ^ " BitPosition "-1 = " TempBitValue " with bit " GammaBit(BitPosition) ":" EpsilonBit(BitPosition) " therefore gamma = " GammaDecimalValue " and epsilon = " EpsilonDecimalValue
    end-perform

    display "epsilon value = " EpsilonDecimalValue " gamma value = " GammaDecimalValue

    multiply EpsilonDecimalValue by GammaDecimalValue giving Power

    display "the power consumption is " Power

    stop run.
end program AOC-2021-DAY-3-TEST-1.
