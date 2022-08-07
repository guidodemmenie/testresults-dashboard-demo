*** TestCases ***
01 Test number one
    Log    Test is supposed to Pass

02 Test number two
    ${value}    Generate Random String   length=2  char=[NUMBER]
    IF  '${value}'=='5'
        Fail  mag=Something went wrong
    END