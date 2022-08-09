*** Settings ***
Library  String

Force Tags  UC01  Team1

#Suite Setup  Fail  msg=Oops something went wrong

*** Test Cases ***
01 Test number one
    Log    Test is supposed to Pass

02 Test number two
    ${value}    Generate Random String   length=2  chars=[NUMBERS]
    ${int}  Convert to Integer  ${value}
    Log to console  Value = ${int}
        IF  ${int}>80
        Fail  msg=Oops nu gaat hij ineens fout met error ${int}
    END

03 Test
    Log    Test is supposed to Pass

04 Test
    Log    Test is supposed to Pass

05 Test
    ${value}    Generate Random String   length=2  chars=[NUMBERS]
    ${int}  Convert to Integer  ${value}
    Log to console  Value = ${int}
        IF  ${int}>60
        Fail  msg=Oops nu gaat hij ineens fout met error ${int}
    END

06 Test
    Log    Test is supposed to Pass