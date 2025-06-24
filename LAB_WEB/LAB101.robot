*** Settings ***
Library           SeleniumLibrary
Library           BuiltIn
Library           String
Library           Collections
Library           ExcelRobot
Library           Dialogs

*** Test Cases ***
TC_LAB
    Open Web Testit    https://testit.co.th/    chrome
    Close Browser

How to use Evaluate
    ${result1}    Evaluate    1+2
    ${result2}    Evaluate    10-5
    ${result3}    Evaluate    ${result1}+${result2}
    ${result4}    Evaluate    ${result2}*${result3}
    ${result5}    Evaluate    ${result2}/${result3}
    ${result6}    Evaluate    random.randint(0,99)
    ### Result ###
    Log To Console    ${result1} = 1+2
    Log To Console    ${result2} = 10-5
    Log To Console    ${result3} = ${result1}+${result2}
    Log To Console    ${result6}

How to use Convert To
    ${result1}    Convert To Integer    200
    ${result2}    Convert To Binary    210
    ${result3}    Convert To Number    42.1343434    2
    ${result4}    Convert To String    12 String
    ${result5}    Convert To Hex    10
    ### Result ###
    Log To Console    Convert To Integer -> ${result1}
    Log To Console    Convert To Binary -> ${result2}
    Log To Console    Convert To Number -> ${result3}
    Log To Console    Convert To String -> ${result4}
    Log To Console    Convert To Hex -> ${result5}

How to use Should Be Equal
    Should Be Equal    1 THB    1 THB
    Should Be Equal As Numbers    2.5    2.5
    Should Be Equal As Integers    ABCD    abcd    base=16
    Should Be Equal As Integers    10    10
    Should Be Equal As Strings    John    John

How to use Strings
    ${valueStr1}    Catenate    Hello    World!!!
    ${valueStr2}    Remove String    Robot Framework    ${SPACE}    Frame
    ${valueStr3}    Split String    Hello World!!!    ${SPACE}
    ${valueStr4}    Replace String    Hello World!!!    ${SPACE}    +

How to use Collections List
    Log To Console    XXXXXX
    @{List}    Create List    B    A    C    B    3
    Append To List    ${List}    D
    Append To List    ${List}    Z
    Append To List    ${List}    ${SPACE}
    Log To Console    Append D Z --> ${List}
    ${countValue}    Count Values In List    ${List}    Z
    Insert Into List    ${List}    0    C
    Log To Console    Insert 0 C --> ${List}
    Insert Into List    ${List}    3    A
    Log To Console    Insert 3 A --> ${List}
    Sort List    ${List}
    Log To Console    Sort --> ${List}
    Remove Values From List    ${List}    A
    Log To Console    Remove A --> ${List}
    Reverse List    ${List}
    Log To Console    Reverse List --> ${List}

How to use Collections Dictionary
    Log To Console    xxxxx
    &{animals}    Create Dictionary    Dog=4    Spider=8    Human=2
    ${valueLeg}    Get From Dictionary    ${animals}    Human
    Remove From Dictionary    ${animals}    Human
    Log To Console    ${animals}
    Set To Dictionary    ${animals}    Human=2
    Log To Console    ${animals}
    Set To Dictionary    ${animals}    Money=2
    Log To Console    ${animals}
    Log Dictionary    ${animals}
    &{headers}    Create Dictionary    Content-Type=applcation/json    Token= Bearer xxxxxx

How to use Capture Screen
    Open Web Mendix
    Capture Page Screenshot    C:\\Robot_Training\\LAB_WEB\\Screenshot\\screen01.png
    Close Browser

How to use For Loop
    @{animalList}    Create List    Human    Dog    Cat    Spider    Pig
    Log To Console    ${EMPTY}
    FOR    ${index}    IN RANGE    0    5
        Log To Console    Loop1 Animal --> ${animalList}[${index}]
    END
    FOR    ${index}    IN    1
        Log To Console    Loop2 Animal --> ${animalList}[${index}]
    END

How to use IF Condition
    ${point}    Set Variable    80
    ${grade}    Set Variable If    ${point} >= 80    A    B
    Set Suite Variable    ${Message1}    ${grade}
    Show Grade

How to use Run Keyword If
    ${point}    Set Variable    40
    Log To Console    Point = ${point}
    Run Keyword If    ${point} >=80    Log To Console    Grade A
    ...    ELSE IF    80 > ${point} >= 70    Log To Console    Grade B
    ...    ELSE IF    70 > ${point} >= 60    Log To Console    Grade C
    ...    ELSE    Log To Console    Grade D

How to use Excel
    Set Library Search Order    ExcelRobot
    Open Excel    C:\\Robot_Training\\LAB_WEB\\Excel\\TestData1.xlsx
    ${columnCountInput}    Get Column Count    INPUT
    ${rowCountInput}    Get Row Count    INPUT
    ${columnCountOutput}    Get Column Count    OUTPUT
    @{resultUsernameList}    Create List    ${EMPTY}
    @{resultPasswordList}    Create List    ${EMPTY}
    FOR    ${input}    IN RANGE    1    ${rowCountInput}
        ${tag}    Read Cell Data    INPUT    0    ${input}
        Run Keyword If    '${tag}' != 'Run'    Continue For Loop
        ${username}    Read Cell Data    INPUT    1    ${input}
        ${password}    Read Cell Data    INPUT    2    ${input}
        Append To List    ${resultUsernameList}    ${username}
        Append To List    ${resultPasswordList}    ${password}
    END
    Remove From List    ${resultUsernameList}    0
    Remove From List    ${resultPasswordList}    0
    ${rowCountOutput}    Get Length    ${resultUsernameList}
    Open Excel To Write    C:\\Robot_Training\\LAB_WEB\\Excel\\TestData1.xlsx    new_path=C:\\Robot_Training\\LAB_WEB\\Excel\\TestData1Result.xlsx    override=override
    FOR    ${output}    IN RANGE    0    ${rowCountOutput}
        ${index}    Evaluate    ${output} + 2
        Write To Cell By Name    OUTPUT    A${index}    PASS    data_type=TEXT
        Write To Cell By Name    OUTPUT    B${index}    SUCCESS    data_type=TEXT
        Write To Cell By Name    OUTPUT    C${index}    ${resultUsernameList}[${output}]    data_type=TEXT
        Write To Cell By Name    OUTPUT    D${index}    ${resultPasswordList}[${output}]    data_type=TEXT
    END
    Save Excel

ATM
    Log To Console    ${EMPTY}
    ${random}    Evaluate    random.randint(0,999999)
    Set Suite Variable    ${money}    ${random}
    Log To Console    I have ${money} baht
    ${balance}    Evaluate    ${money}%1000
    ${bank1000}    Evaluate    (${money}-${balance})/1000
    ${bank1000}    Convert To Integer    ${bank1000}
    Run Keyword If    ${bank1000}!=0    Log To Console    I get Bank 1000 : ${bank1000} Bank
    ${balance500}    Evaluate    ${balance}%500
    ${bank500}    Evaluate    (${balance}-${balance500})/500
    ${bank500}    Convert To Integer    ${bank500}
    Run Keyword If    ${bank500}!=0    Log To Console    I get Bank 500 : ${bank500} Bank
    ${balance100}    Evaluate    ${balance500}%100
    ${bank100}    Evaluate    (${balance500}-${balance100})/100
    ${bank100}    Convert To Integer    ${bank100}
    Run Keyword If    ${bank100}!=0    Log To Console    I get Bank 100 : ${bank100} Bank
    ${balance50}    Evaluate    ${balance100}%50
    ${bank50}    Evaluate    (${balance100}-${balance50})/50
    ${bank50}    Convert To Integer    ${bank50}
    Run Keyword If    ${bank50}!=0    Log To Console    I get Bank 50 : ${bank50} Bank
    ${balance20}    Evaluate    ${balance50}%20
    ${bank20}    Evaluate    (${balance50}-${balance20})/20
    ${bank20}    Convert To Integer    ${bank20}
    Run Keyword If    ${bank20}!=0    Log To Console    I get Bank 20 : ${bank20} Bank
    ${balance10}    Evaluate    ${balance20}%10
    ${coin10}    Evaluate    (${balance20}-${balance10})/10
    ${coin10}    Convert To Integer    ${coin10}
    Run Keyword If    ${coin10}!=0    Log To Console    I get Coin 10 : ${coin10} Coin
    ${balance5}    Evaluate    ${balance10}%5
    ${coin5}    Evaluate    (${balance10}-${balance5})/5
    ${coin5}    Convert To Integer    ${coin5}
    Run Keyword If    ${coin5}!=0    Log To Console    I get Coin 5 : ${coin5} Coin
    ${balance2}    Evaluate    ${balance5}%2
    ${coin2}    Evaluate    (${balance5}-${balance2})/2
    ${coin2}    Convert To Integer    ${coin2}
    Run Keyword If    ${coin2}!=0    Log To Console    I get Coin 2 : ${coin2} Coin
    ${balance1}    Evaluate    ${balance2}%1
    ${coin1}    Evaluate    (${balance2}-${balance1})/1
    ${coin1}    Convert To Integer    ${coin1}
    Run Keyword If    ${coin1}!=0    Log To Console    I get Coin 1 : ${coin1} Coin

Count Percentage
    Log To Console    XXXXXX
    @{number}    Create List    1    -3    -5    0    4    5    9
    ${length}    Get Length    ${number}
    ${count}    Set Variable    0
    FOR    ${index}    IN    @{number}
        Run Keyword If    ${index}<1    Continue For Loop
        ${count}    Evaluate    ${count}+1
    END
    ${percentage}    Evaluate    (${count}/${length})*100
    ${percentage}    Convert To Number    ${percentage}    2
    Log To Console    ${percentage} %

Square of OX
    Log To Console    ${EMPTY}
    ${value}    Get Value From User    Please input value:
    @{row}    Create List
    FOR    ${i}    IN RANGE    0    ${value}
    FOR    ${j}    IN RANGE    0    ${value}
        Run Keyword If    ${i}==${j}    Append To List    ${row}    X
        Append To List    ${row}    O
    END
    Remove From List    ${row}    ${value}
    Log To Console    ${row}
    Remove Values From List    ${row}    X    O
    END

Prime Number
    Log To Console    ${EMPTY}
    ${value}    Get Value From User    Please input value between 1 < X <= 1000
    @{primenumber}    Create List
    FOR    ${number}    IN RANGE    0    ${value}+1
        Run Keyword If    ${number}==0 or ${number}==1    Continue For Loop
        Prime Number Calculator    ${number}    ${primenumber}
    END
    ${primelength}    Get Length    ${primenumber}
    Log To Console    Total Prime Number: ${primelength}
    Run Keyword If    ${primelength}>0    Log To Console    Prime Number Is: ${primenumber}
    ...    ELSE    Log To Console    Prime Number Not Found!!

3 Cups Monte
    Log To Console    ${EMPTY}
    ${value}    Get Value From User    Please input value A, B, C:
    ${valueUpperCase}    Convert To Upper Case    ${value}
    Log To Console    Input Is: ${value}
    ${valueResult}    Remove String    ${valueUpperCase}    AA    BB    CC
    &{cups}    Create Dictionary    Cup1=1    Cup2=0    Cup3=0
    ${valuelength}    Get Length    ${valueResult}
    ${check}    Set Variable    0
    FOR    ${index}    IN RANGE    0    ${valuelength}
        Continue For Loop If    '${valueResult}[${index}]'=='A' or '${valueResult}[${index}]'=='B' or '${valueResult}[${index}]'=='C'
        Set Suite Variable    ${check}    1
        Exit For Loop
    END
    Run Keyword If    ${check}==0    3 Cups Calculator    ${valuelength}    ${cups}    ${valueResult}
    Run Keyword If    ${check}>0    Log To Console    Error!! Input is invalid, You must input only A, B, C

Open Web and Get Text
    Open Web Robot Framework
    Close Browser

*** Keywords ***
Open Web Testit
    [Arguments]    ${URL}    ${Browser}
    Open Browser    ${URL}    ${Browser}    options=add_experimental_option("detach", True)
    Maximize Browser Window

Open Web Mendix
    Open Browser    https://www.mendix.com    chrome
    Maximize Browser Window
    Wait Until Page Contains Element    //*[@id="button-top-nav-sign-up"]/span    10s
    ${text}    Get Text    //*[@id="button-top-nav-sign-up"]/span
    Run Keyword If    '${text}' == 'Try for free'    Log To Console    Open Web Mendix Success
    ...    ELSE    Log To Console    Open Web Mendix Fail

Show Grade
    Log To Console    ${Message1}

Prime Number Calculator
    [Arguments]    ${number}    ${primenumber}
    ${check}    Set Variable    0
    FOR    ${index}    IN RANGE    2    ${number}
        Run Keyword If    ${check}>0    Exit For Loop
        Run Keyword If    ${number}%${index}!=0    Continue For Loop
        ${check}    Evaluate    ${check}+1
    END
    Run Keyword If    ${check}==0    Append To List    ${primenumber}    ${number}

3 Cups Calculator
    [Arguments]    ${valuelength}    ${cups}    ${valueResult}
    FOR    ${index}    IN RANGE    0    ${valuelength}
        ${Cup1Value}    Get From Dictionary    ${cups}    Cup1
        ${Cup2Value}    Get From Dictionary    ${cups}    Cup2
        ${Cup3Value}    Get From Dictionary    ${cups}    Cup3
        Run Keyword If    '${valueResult}[${index}]'=='A'    Set To Dictionary    ${cups}    Cup1=${Cup2value}    Cup2=${Cup1value}
        Run Keyword If    '${valueResult}[${index}]'=='B'    Set To Dictionary    ${cups}    Cup2=${Cup3value}    Cup3=${Cup2value}
        Run Keyword If    '${valueResult}[${index}]'=='C'    Set To Dictionary    ${cups}    Cup1=${Cup3value}    Cup3=${Cup1value}
    END
    ${Cup1Value}    Get From Dictionary    ${cups}    Cup1
    ${Cup2Value}    Get From Dictionary    ${cups}    Cup2
    ${Cup3Value}    Get From Dictionary    ${cups}    Cup3
    Run Keyword If    ${Cup1Value}==1    Log To Console    Output Is: Cup 1
    ...    ELSE IF    ${Cup2Value}==1    Log To Console    Output Is: Cup 2
    ...    ELSE IF    ${Cup3Value}==1    Log To Console    Output Is: Cup 3

Open Web Robot Framework
    Open Browser    https://robotframework.org/    chrome
    Maximize Browser Window
    Wait Until Page Contains Element    //div[@style="top: 190px; height: 19px;"]//span[@class="mtk24 mtki"]    10s
    ${text}    Get Text    //div[@style="top: 190px; height: 19px;"]//span[@class="mtk24 mtki"]
    ${textResult}    Remove String    ${text}    ${SPACE}
    Log To Console    ${EMPTY}
    Log To Console    ${textResult}
