*> ##################################################
*> PROGRAM:     Roman Numeral Converter (Extension)
*> DESCRIPTION: This is the extension (function) for
*>              converting the roman numerals
*> NAME:        Daniel Domalik
*> STUDENT ID:  0933553
*> DATE:        03/23/2018
*> COMPILER:    COBC
*> ##################################################

identification division.
program-id. conv.
environment division.
input-output section.
file-control.
    select standard-output assign to display.
data division.
file section.
fd standard-output.
    01 stdout-record pic x(80).
working-storage section.
01 int           pic z(04)9.
01 prev-val      pic x(1).
77 sum-val       pic 9(10) value 0.
77 is-valid      pic 9(10) value 0.
77 i             pic s99 usage is computational.
linkage section.
01 loop       pic 9(2).
77 input-line pic x(30).
procedure division using input-line, loop.
    move 0 to sum-val
    move ' ' to prev-val
    
    *> Loop through numerals giving them their respective value
    perform varying i from 1 by 1 until i is greater than (loop + 1)
        move 0 to is-valid
        if i is greater than 1
            move input-line(i - 1:1) to prev-val
        end-if
        
        if input-line(i:1) is equal to 'M'
            move 1 to is-valid
            compute sum-val = sum-val + 1000
        end-if
        
        if input-line(i:1) is equal to 'D'
            move 1 to is-valid
            compute sum-val = sum-val + 500
        end-if
        
        if input-line(i:1) is equal to 'C'
            move 1 to is-valid
            compute sum-val = sum-val + 100
        end-if
        
        if input-line(i:1) is equal to 'L'
            move 1 to is-valid
            compute sum-val = sum-val + 50
        end-if
        
        if input-line(i:1) is equal to 'X'
            move 1 to is-valid
            compute sum-val = sum-val + 10
        end-if
        
        if input-line(i:1) is equal to 'V'
            move 1 to is-valid
            compute sum-val = sum-val + 5
        end-if 
        
        if input-line(i:1) is equal to 'I'
            move 1 to is-valid
            compute sum-val = sum-val + 1
        end-if
        
        *> Subtraction based on previous numeral
        if is-valid is equal to 1
            if prev-val is equal to 'I'
                compute sum-val = sum-val - 2
            end-if
            if prev-val is equal to 'X' and (input-line(i:1) is equal to 'M' or 'D' or 'C' or 'L')
                compute sum-val = sum-val - 2 * 10
            end-if
            if prev-val is equal to 'L' and (input-line(i:1) is equal to 'M' or 'D' or 'C')
                compute sum-val = sum-val - 2 * 50
            end-if
            if prev-val is equal to 'C' and (input-line(i:1) is equal to 'M' or 'D')
                compute sum-val = sum-val - 2 * 100
            end-if
        end-if
        
        *> If an invalid numeral is detected, exit
        if is-valid is equal to 0 and input-line is not equal to 'Q'
            move 0 to is-valid
            move 0 to sum-val
            display "Invalid numerals entered!"
            exit perform
        end-if
    end-perform
    
    *> If the end is reached successfully, print out the input as well as the calculated value
    if is-valid is equal to 1
        move sum-val to int
        display input-line int
    end-if.
