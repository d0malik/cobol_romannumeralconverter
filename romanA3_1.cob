*> ############################################
*> PROGRAM:     Roman Numeral Converter (Main)
*> DESCRIPTION: This program acts as a
*>              roman numeral converter
*> NAME:        Daniel Domalik
*> STUDENT ID:  0933553
*> DATE:        03/23/2018
*> COMPILER:    COBC
*> ############################################

identification division.
program-id. romannumerals.
environment division.
input-output section.
file-control.
    select standard-input assign to keyboard.
    select standard-output assign to display.
    select input-file
    assign to input-filename
    organization is line sequential.
data division.
file section.
fd standard-input.
    01 stdin-record pic  x(80).
fd standard-output.
    01 stdout-record pic x(80).
fd input-file.
    01 input-record pic x(20).
working-storage section.
01 int            pic z(04)9.
01 loop           pic 9(2) value 0.
01 ws-end-of-file pic a(1).
01 prev-val       pic x(1).
01 input-filename pic x(64) value ' '.
01 is-alphabet    pic x(1) value 'n'.
01 is-valid       pic 9(1) value 0.
77 get-line       pic x(30) value " ".
77 input-line     pic x(30).
77 sum-val        pic 9(10).
77 is-file        pic 9(1) value 0.
77 i              pic s99 usage is computational.

procedure division.

open input standard-input, output standard-output
    display " "
    display "--------------------------------------------------------------------"
    display " "
    display "Hello! Welcome to the Roman Numeral Converter."
    display " "
    display "Simply enter a roman numeral and it will be converted."
    display " "
    display "To read in a file, enter the > character followed by the file name."
    display "    e.g. >numerals OR >numerals.ext"
    display " "
    display "--------------------------------------------------------------------"
    display " "
    display "         Roman Numeral Converter"
    display "-----------------    ----------------------"
    display "  Roman Numeral        Decimal Equivalent"
    perform until input-line is equal to "q" or "Q"
        move " " to get-line
        move " " to input-line
        move 'n' to is-alphabet
        move 0 to loop
        move 0 to is-file
        move 0 to sum-val
        read standard-input into get-line
        
        *> Max length of 25 for entered numeral
        perform varying loop from 25 by -1 until loop < 1 or is-alphabet = 'y'
            if get-line (loop : 1) not = space
                move 'y' to is-alphabet
            end-if
        end-perform
        
        *> Check if file character is in input
        perform varying i from 1 by 1 until i is greater than (loop + 1)
            if get-line(i:1) is equal to '>'
                move 1 to is-file
            end-if
        end-perform
        
        *> If file character is in input, read in file
        if is-file is equal to 1
            move 0 to loop
            move 0 to sum-val
            move " " to input-line
            move 'n' to is-alphabet
            move 'n' to ws-end-of-file
            move get-line(2:) to input-filename
            display input-filename
            open input input-file
            
            perform until ws-end-of-file = 'y'
                move 0 to loop
                move 'n' to is-alphabet
                read input-file into input-record
                at end move 'y' to ws-end-of-file
                not at end    
                    move input-record to get-line
                    perform varying loop from 25 by -1 until loop < 1 or is-alphabet = 'y'
                        if get-line (loop : 1) not = space
                            move 'y' to is-alphabet
                        end-if
                    end-perform
                    move function upper-case(get-line) to input-line
                    call "conv" using input-line, loop
                    end-read
                end-perform
                close input-file
            end-if
            
            if is-file is equal to 0
                move function upper-case(get-line) to input-line
                call "conv" using input-line, loop
            end-if
    end-perform.
