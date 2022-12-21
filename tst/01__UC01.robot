*** Settings ***
Library  String

Force Tags  UC01  Team1

#Suite Setup  Fail  msg=Oops something went wrong
Resource    keywords.resource

*** Test Cases ***
01 Test number one
    Add Delay
    Log    Test is supposed to Pass

02 Test number two
    Log    Test is supposed to Pass

03 Test
    Log    Test is supposed to Pass

04 Test
    Add Delay
    Log    Test is supposed to Pass

05 Test
    Add Delay
    Log    Test is supposed to Pass

06 Test
    Log    Test is supposed to Pass