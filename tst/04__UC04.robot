*** Settings ***
Library  String

Default Tags  UC04  Team2

Resource    keywords.resource

*** Test Cases ***
01 Test number one
    Add Delay
    Log    Test is supposed to Pass

02 Test number two
    Add Delay
    ${value}    Generate Random String   length=2  chars=[NUMBERS]
    ${int}  Convert to Integer  ${value}
    Log to console  Value = ${int}
        IF  ${int}>75
        Add Delay
        Fail  msg=Oops nu gaat hij ineens fout met error ${int}
    END

03 Test
    ${value}    Generate Random String   length=2  chars=[NUMBERS]
    ${int}  Convert to Integer  ${value}
    Log to console  Value = ${int}
    IF  ${int}>80
        Add Delay
        Add Delay
        Fail  msg=Oops nu gaat hij ineens fout met error ${int}
    END

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
    Add Delay
    Log    Test is supposed to Pass