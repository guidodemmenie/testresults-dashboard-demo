*** Settings ***
Library  String

Force Tags  UC03  Team2

#Suite Setup  Fail  msg=Oops something went wrong

*** Test Cases ***
01 Test number one
    Log    Test is supposed to Pass

02 Test number two
    ${value}    Generate Random String   length=2  chars=[NUMBERS]
    ${int}  Convert to Integer  ${value}
    Log to console  Value = ${int}
        IF  ${int}>95
        Fail  msg=Oops nu gaat hij ineens fout
    END

03 Test
    Log    Test is supposed to Pass

04 Test
    Log    Test is supposed to Pass