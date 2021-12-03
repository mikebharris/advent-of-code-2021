identification division.
program-id. AOC-2021-DAY-1-TEST-1.
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
    02 Depth                pic 9(4).

working-storage section.
01 NumberOfIncreases    pic 9(4) value zero.
01 PreviousDepth        pic 9(4).

procedure division.
Begin.
    open input InputFile
    read InputFile
        at end set EndOfInputFile to true
    end-read

    perform with test before until EndOfInputFile
       move Depth to PreviousDepth
       read InputFile
         at end set EndOfInputFile to true
       end-read
       if Depth is greater than PreviousDepth then
           add 1 to NumberOfIncreases
       end-if
    end-perform

    close InputFile

    display "There were " NumberOfIncreases " increases"

    stop run.
end program AOC-2021-DAY-1-TEST-1.
