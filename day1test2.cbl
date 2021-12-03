identification division.
program-id. AOC-2021-DAY-1-TEST-2.
environment division.
input-output section.
    file-control.
        select InputFile assign to "day1-input.txt"
            organization is line sequential.

data division.
file section.
fd InputFile.
01 filler.
    88 EndOfInputFile       value high-values.
    02 Reading              pic x(4).

working-storage section.
01 NumberOfIncreases    pic 9(4) value zero.

01 DepthsTable.
    02 Depth pic 9999 occurs 1 to 9999 times depending on NumberOfReadings value zeroes.

01 NumberOfReadings pic 9999 value zero.

01 Offset pic 9999.

01 PreviousSum          pic 9(4) value zeroes.
01 ThisSum              pic 9(4) value zeroes.

procedure division.
Begin.
    open input InputFile
    read InputFile
        at end set EndOfInputFile to true
    end-read

    perform with test before until EndOfInputFile

        move Reading to Depth(NumberOfReadings)
        add 1 to NumberOfReadings

        read InputFile
            at end set EndOfInputFile to true
        end-read

    end-perform

    close InputFile

    display "recorded " NumberOfReadings " readings"

    perform with test before varying Offset from 1 by 1 until Offset is equal to NumberOfReadings
        compute ThisSum = Depth(Offset) + Depth(Offset + 1) + Depth(Offset + 2)
        compute PreviousSum = Depth(Offset - 1) + Depth(Offset) + Depth(Offset + 1)

        if ThisSum is greater than PreviousSum then
            add 1 to NumberOfIncreases
        end-if
    end-perform

    display "There were " NumberOfIncreases " increases"

    stop run.
end program AOC-2021-DAY-1-TEST-2.
