*** Settings ***
Library    String

*** Variables ***
${DF}    # Delay Factor that can be increased for each run

*** Keywords ***
Add Delay
    ${delay}    Generate Random String    length=3    chars=[NUMBERS]
    ${delay}    Convert To Integer    ${delay}
    ${delay}    Evaluate    ${delay}*${DF}
    Sleep    ${delay}ms