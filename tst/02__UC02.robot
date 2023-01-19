*** Settings ***
Library  String

Default Tags  UC02  Team1

#Suite Setup  Fail  msg=Oops something went wrong
Resource    keywords.resource

*** Test Cases ***
01 Test number one
    Log    Test is supposed to Pass

02 Test number two
    ${value}    Generate Random String   length=2  chars=[NUMBERS]
    ${int}  Convert to Integer  ${value}
    Log to console  Value = ${int}
        IF  ${int}>90
        Add Delay
        Add Delay
        Fail  msg=Oops nu gaat hij ineens fout met error ${int}
    END

03 Test
    Add Delay
    Log    Test is supposed to Pass

04 Test
    Add Delay
    Log    Test is supposed to Pass

05 Test
    Add Delay
    Log    Test is supposed to Pass

06 Test
    Add Delay
    Log    Test is supposed to Pass

07 Test
    ${value}    Generate Random String   length=2  chars=[NUMBERS]
    ${int}  Convert to Integer  ${value}
    Log to console  Value = ${int}
    IF  ${int}>80
        Add Delay
        Fail  msg=Oops nu gaat hij ineens fout met error ${int}
    END
08 Test
    ${value}    Generate Random String   length=2  chars=[NUMBERS]
    ${int}  Convert to Integer  ${value}
    Log to console  Value = ${int}
        IF  ${int}>65
        Add Delay
        Fail  msg=Oops nu gaat hij ineens fout met error ${int}
    END