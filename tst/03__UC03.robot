*** Settings ***
Library  String

Default Tags  UC03  Team2

#Suite Setup  Fail  msg=Oops something went wrong
Resource    keywords.resource

*** Test Cases ***
01 Test number one
    Add Delay
    Log    Test is supposed to Pass

02 Test number two
    ${value}    Generate Random String   length=2  chars=[NUMBERS]
    ${int}  Convert to Integer  ${value}
    Log to console  Value = ${int}
        IF  ${int}>70
        Add Delay
        Add Delay
        Fail  msg=TimeoutError: waiting for locator .myclass${int}
    END

03 Test
    Add Delay
    Log    Test is supposed to Pass

04 Test
    Add Delay
    Log    Test is supposed to Pass