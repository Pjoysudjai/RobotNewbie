*** Settings ***
Library           SeleniumLibrary
Library           BuiltIn
Library           String
Library           Collections
Library           ExcelRobot
Library           Dialogs

*** Test Cases ***
Login and Edit City
    Log To Console    ${EMPTY}
    Set Library Search Order    ExcelRobot
    Open Excel    C:\\Robot_Training\\LAB_WEB\\Excel\\EditCity.xlsx
    ${rowCountInput}    Get Row Count    Input
    @{resultUsernameList}    Create List    ${EMPTY}
    @{resultPasswordList}    Create List    ${EMPTY}
    @{resultCityList}    Create List    ${EMPTY}
    @{userList}    Create List    ${EMPTY}
    @{cityList}    Create List    ${EMPTY}
    FOR    ${input}    IN RANGE    1    ${rowCountInput}
        ${tag}    Read Cell Data    Input    0    ${input}
        Run Keyword If    '${tag}' != 'run'    Continue For Loop
        ${username}    Read Cell Data    Input    1    ${input}
        ${password}    Read Cell Data    Input    2    ${input}
        ${city}    Read Cell Data    Input    3    ${input}
        Append To List    ${resultUsernameList}    ${username}
        Append To List    ${resultPasswordList}    ${password}
        Append To List    ${resultCityList}    ${city}
        Remove From List    ${resultUsernameList}    0
        Remove From List    ${resultPasswordList}    0
        Remove From List    ${resultCityList}    0
        Login For Edit City    ${resultUsernameList}    ${resultPasswordList}    ${resultCityList}
        Close Browser
        Append To List    ${userList}    ${userResult}
        Append To List    ${cityList}    ${cityResult}
    END
    Remove From List    ${resultUsernameList}    0
    Remove From List    ${resultPasswordList}    0
    Remove From List    ${resultCityList}    0
    Remove From List    ${userList}    0
    Remove From List    ${cityList}    0
    ${rowCountOutput}    Get Length    ${userList}
    Open Excel To Write    C:\\Robot_Training\\LAB_WEB\\Excel\\EditCity.xlsx    new_path=C:\\Robot_Training\\LAB_WEB\\Excel\\EditCityResult.xlsx    override=override
    FOR    ${output}    IN RANGE    0    ${rowCountOutput}
        ${index}    Evaluate    ${output} + 2
        Write To Cell By Name    Output    A${index}    Pass    data_type=TEXT
        Write To Cell By Name    Output    B${index}    ${userList}[${output}]    data_type=TEXT
        Write To Cell By Name    Output    C${index}    ${cityList}[${output}]    data_type=TEXT
    END
    Save Excel

Login and Buy Tablet
    Log To Console    ${EMPTY}
    Set Library Search Order    ExcelRobot
    Open Excel    C:\\Robot_Training\\LAB_WEB\\Excel\\BuyTablet.xlsx
    ${rowCountInput}    Get Row Count    Input
    @{resultUsernameList}    Create List    ${EMPTY}
    @{resultPasswordList}    Create List    ${EMPTY}
    @{userList}    Create List    ${EMPTY}
    @{productNameList}    Create List    ${EMPTY}
    @{quantityList}    Create List    ${EMPTY}
    @{priceList}    Create List    ${EMPTY}
    FOR    ${input}    IN RANGE    1    ${rowCountInput}
        ${tag}    Read Cell Data    Input    0    ${input}
        Run Keyword If    '${tag}' != 'run'    Continue For Loop
        ${username}    Read Cell Data    Input    1    ${input}
        ${password}    Read Cell Data    Input    2    ${input}
        ${quantityInput}    Read Cell Data    Input    3    ${input}
        Append To List    ${resultUsernameList}    ${username}
        Append To List    ${resultPasswordList}    ${password}
        Remove From List    ${resultUsernameList}    0
        Remove From List    ${resultPasswordList}    0
        Login For Buy Tablet    ${resultUsernameList}    ${resultPasswordList}    ${quantityInput}
        Close Browser
        Append To List    ${userList}    ${userResult}
        Append To List    ${productNameList}    ${productName}
        Append To List    ${quantityList}    ${quantity}
        Append To List    ${priceList}    ${price}
    END
    Remove From List    ${resultUsernameList}    0
    Remove From List    ${resultPasswordList}    0
    Remove From List    ${userList}    0
    Remove From List    ${productNameList}    0
    Remove From List    ${quantityList}    0
    Remove From List    ${priceList}    0
    ${rowCountOutput}    Get Length    ${userList}
    Open Excel To Write    C:\\Robot_Training\\LAB_WEB\\Excel\\BuyTablet.xlsx    new_path=C:\\Robot_Training\\LAB_WEB\\Excel\\BuyTabletResult.xlsx    override=override
    FOR    ${output}    IN RANGE    0    ${rowCountOutput}
        ${index}    Evaluate    ${output} + 2
        Write To Cell By Name    Output    A${index}    ${Status}    data_type=TEXT
        Write To Cell By Name    Output    B${index}    ${Message}    data_type=TEXT
        Write To Cell By Name    Output    C${index}    ${userList}[${output}]    data_type=TEXT
        Write To Cell By Name    Output    D${index}    ${productNameList}[${output}]    data_type=TEXT
        Write To Cell By Name    Output    E${index}    ${quantityList}[${output}]    data_type=TEXT
        Write To Cell By Name    Output    F${index}    ${priceList}[${output}]    data_type=TEXT
    END
    Save Excel

*** Keywords ***
Login For Edit City
    [Arguments]    ${resultUsernameList}    ${resultPasswordList}    ${resultCityList}
    Open Browser    http://advantageonlineshopping.com/    chrome
    Maximize Browser Window
    Wait Until Page Contains Element    //*[@id="headphonesImg"]    10s
    Click Element    //*[@id="menuUserLink"]
    Sleep    2s
    ${Username}    Get From List    ${resultUsernameList}    0
    ${Password}    Get From List    ${resultPasswordList}    0
    Input Text    //*[@name="username"]    ${Username}
    Input Text    //*[@name="password"]    ${Password}
    Wait Until Page Contains Element    //*[@id="sign_in_btnundefined"]
    Click Element    //*[@id="sign_in_btnundefined"]
    Wait Until Page Contains Element    //*[@class="hi-user containMiniTitle ng-binding"]
    ${userResult}    Get Text    //*[@class="hi-user containMiniTitle ng-binding"]
    Set Suite Variable    ${userResult}
    Run Keyword If    '${userResult}'=='${Username}'    Edit City    ${resultCityList}

Edit City
    [Arguments]    ${resultCityList}
    Log To Console    Account Match
    Click Element    //*[@class="hi-user containMiniTitle ng-binding"]
    Wait Until Page Contains Element    //*[@id="loginMiniTitle"]//*[@ng-click="accountSection()"]
    Click Element    //*[@id="loginMiniTitle"]//*[@ng-click="accountSection()"]
    Wait Until Page Contains Element    //*[@class="deleteBtnText"]
    Click Element    //*[@class="blueLink ng-binding"]//*[@class="floatRigth ng-scope"]
    Wait Until Page Contains Element    //*[@id="save_btnundefined"]
    ${city}    Get From List    ${resultCityList}    0
    Input Text    //*[@class="inputContainer ng-scope"]//*[@name="cityAccountDetails"]    ${city}
    Wait Until Page Contains Element    //*[@name="cityAccountDetails"][@class="ng-valid ng-scope ng-dirty ng-valid-parse ng-touched in-focus"]
    Click Element    //*[@id="save_btnundefined"]
    Wait Until Page Contains Element    //*[@class="deleteBtnText"]
    ${cityResult}    Get Text    //*[@data-ng-hide="accountDetails.cityName == ''"]
    Set Suite Variable    ${cityResult}
    Run Keyword If    '${cityResult}'=='${city}'    Log To Console    ===== Edit Success =====
    ...    ELSE    Log To Console    ===== Edit Failed!! =====
    Click Element    //*[@class="hi-user containMiniTitle ng-binding"]
    Wait Until Page Contains Element    //*[@ng-click="signOut($event)"]
    Click Element    //*[@ng-click="signOut($event)"]
    Wait Until Page Contains Element    //*[@id="headphonesImg"]    10s

Login For Buy Tablet
    [Arguments]    ${resultUsernameList}    ${resultPasswordList}    ${quantityInput}
    Open Browser    http://advantageonlineshopping.com/    chrome
    Maximize Browser Window
    Wait Until Page Contains Element    //*[@id="tabletsImg"]    10s
    Click Element    //*[@id="menuUserLink"]
    Sleep    1s
    ${Username}    Get From List    ${resultUsernameList}    0
    ${Password}    Get From List    ${resultPasswordList}    0
    Input Text    //*[@name="username"]    ${Username}
    Input Text    //*[@name="password"]    ${Password}
    Wait Until Page Contains Element    //*[@id="sign_in_btnundefined"]
    Click Element    //*[@id="sign_in_btnundefined"]
    Wait Until Page Contains Element    //*[@class="hi-user containMiniTitle ng-binding"]
    ${userResult}    Get Text    //*[@class="hi-user containMiniTitle ng-binding"]
    Set Suite Variable    ${userResult}
    Run Keyword If    '${userResult}'=='${Username}'    Buy Tablet    ${quantityInput}

Buy Tablet
    [Arguments]    ${quantityInput}
    Log To Console    Account ${userResult} Match
    Click Element    //*[@id="tabletsImg"]
    Wait Until Page Contains Element    //*[@id="16"]
    Click Element    //*[@id="16"]
    Wait Until Page Contains Element    //*[@id="mainImg"]
    Click Element    //*[@title="GRAY"]
    Run Keyword If    ${quantityInput}<=0    Log To Console    Failed!! input must more than 0
    Run Keyword If    ${quantityInput}==1    Log To Console    Pass for input = 1
    ...    ELSE    Click Add Quantity    ${quantityInput}
    Click Element    //*[@name="save_to_cart"]
    Wait Until Page Contains Element    //*[@id="checkOutPopUp"]
    Click Element    //*[@id="menuCart"]
    Wait Until Page Contains Element    //*[@id="checkOutButton"]
    ${productName}    Get Text    //*[@class="roboto-regular productName ng-binding"]
    ${quantity}    Get Text    //*[@class="smollCell quantityMobile"]//*[@class="ng-binding"]
    ${price}    Get Text    //*[@class="smollCell"]//*[@class="price roboto-regular ng-binding"]
    ${price}    Remove String    ${price}    $
    Set Suite Variable    ${productName}
    Set Suite Variable    ${quantity}
    Set Suite Variable    ${price}
    Click Element    //*[@data-ng-click="removeProduct($index)"]
    Wait Until Page Contains Element    //*[@id="shoppingCart"]/div/a
    Check Point
    Click Element    //*[@class="hi-user containMiniTitle ng-binding"]
    Wait Until Page Contains Element    //*[@ng-click="signOut($event)"]
    Click Element    //*[@ng-click="signOut($event)"]

Click Add Quantity
    [Arguments]    ${quantityInput}
    FOR    ${index}    IN RANGE    0    ${${quantityInput}-1}
        Click Element    //*[@class="plus"]
    END

Check Point
    Page Should Contain    Your shopping cart is empty
    ${Result}    Get Text    //*[@id="shoppingCart"]/div/label
    Log To Console    Result --> ${Result}
    Run Keyword If    '${Result}'=='Your shopping cart is empty'    Set Suite Variable    ${Status}    Pass
    ...    ELSE    Set Suite Variable    ${Status}    Fail
    Run Keyword If    '${Status}'=='Pass'    Set Suite Variable    ${Message}    Search Successfully
    ...    ELSE    Set Suite Variable    ${Message}    Fail
    Log To Console    Status --> ${Status}
    Log To Console    Message --> ${Message}
