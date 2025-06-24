*** Settings ***
Library           SeleniumLibrary
Library           DateTime
Library           String
Library           Collections
Library           OperatingSystem
Library           BuiltIn
Library           Dialogs
Library           ExcelRobot
Library           RequestsLibrary
Library           JSONLibrary
Library           XML

*** Test Cases ***
Timeline Stat JSON File
    Set Suite Variable    ${excelRootPath}    C:\\Robot_Training\\LAB_WEB\\Excel
    Set Suite Variable    ${fileName}    ${excelRootPath}\\TimelineStat.xlsx
    Log To Console    ${EMPTY}
    Get Timeline JSON

Add Object To Json
    ${json_object}    Load JSON From File    D:\\Extosoft\\Robot\\Training\\COVID19\\example.json
    ${profile}    Create Dictionary    first_name=Mr.Jacky    last_name=Chan
    ${address}    Create Dictionary    street=101 robot    province=Bangkok
    ${data_json_object}    Add Object To Json    ${json_object}    $..profile    ${profile}
    ${data_json_object}    Add Object To Json    ${json_object}    $..address    ${address}

Delete Object From Json
    ${json_object}    Load JSON From File    D:\\Extosoft\\Robot\\Training\\COVID19\\example.json
    ${profile}    Create Dictionary    first_name=Mr.Jacky    last_name=Chan
    ${address}    Create Dictionary    street=101 robot    province=Bangkok
    ${data_json_object}    Add Object To Json    ${json_object}    $..profile    ${profile}
    ${data_json_object}    Add Object To Json    ${json_object}    $..address    ${address}
    ${data_json_object}    Delete Object From Json    ${json_object}    $..address.street

Update Value To Json
    ${json_object}    Load JSON From File    D:\\Extosoft\\Robot\\Training\\COVID19\\example.json
    ${profile}    Create Dictionary    first_name=Mr.Jacky    last_name=Chan
    ${address}    Create Dictionary    street=101 robot    province=Bangkok
    ${data_json_object}    Add Object To Json    ${json_object}    $..profile    ${profile}
    ${data_json_object}    Add Object To Json    ${json_object}    $..address    ${address}
    ${data_json_object}    Delete Object From Json    ${json_object}    $..address.street
    ${data_json_object}    Update Value To Json    ${json_object}    $..address.province    Chiang Mai

*** Keywords ***
Get Timeline JSON
    ${jsonObject}    Load JSON From File    C:\\Robot_Training\\LAB_WEB\\JSON\\timeline.json
    @{dataTempList}    Set Data Timeline JSON    ${jsonObject}
    ${dataTempListCount}    Get Length    ${dataTempList}
    Set Library Search Order    ExcelRobot
    ${newConfirmCount}    Set Variable    0
    ${newRecoveredCount}    Set Variable    0
    ${newHospitalizedCount}    Set Variable    0
    ${newDeathsCount}    Set Variable    0
    ${confirmCount}    Set Variable    0
    ${recoveredCount}    Set Variable    0
    ${hospitalizedCount}    Set Variable    0
    ${deathsCount}    Set Variable    0
    Clear Data Excel
    Open Excel To Write    ${fileName}    override=override
    Write To Cell By Name    Timeline    B1    ${updateDate}[0]    data_type=TEXT
    Write To Cell By Name    Timeline    D1    ${devBy}[0]    data_type=TEXT
    FOR    ${output}    IN RANGE    0    ${dataTempListCount}
        ${index}    Evaluate    ${output} + 3
        Write To Cell By Name    Timeline    A${index}    ${dataTempList}[${output}][0][0]    data_type=TEXT
        Write To Cell By Name    Timeline    B${index}    ${dataTempList}[${output}][1][0]    data_type=TEXT
        Write To Cell By Name    Timeline    C${index}    ${dataTempList}[${output}][2][0]    data_type=TEXT
        Write To Cell By Name    Timeline    D${index}    ${dataTempList}[${output}][3][0]    data_type=TEXT
        Write To Cell By Name    Timeline    E${index}    ${dataTempList}[${output}][4][0]    data_type=TEXT
        Write To Cell By Name    Timeline    F${index}    ${dataTempList}[${output}][5][0]    data_type=TEXT
        Write To Cell By Name    Timeline    G${index}    ${dataTempList}[${output}][6][0]    data_type=TEXT
        Write To Cell By Name    Timeline    H${index}    ${dataTempList}[${output}][7][0]    data_type=TEXT
        Write To Cell By Name    Timeline    I${index}    ${dataTempList}[${output}][8][0]    data_type=TEXT
        ${newConfirmCount}    Convert To Integer    ${${dataTempList}[${output}][1][0]+${newConfirmCount}}
        ${newRecoveredCount}    Convert To Integer    ${${dataTempList}[${output}][2][0]+${newRecoveredCount}}
        ${newHospitalizedCount}    Convert To Integer    ${${dataTempList}[${output}][3][0]+${newHospitalizedCount}}
        ${newDeathsCount}    Convert To Integer    ${${dataTempList}[${output}][4][0]+${newDeathsCount}}
        ${confirmCount}    Convert To Integer    ${${dataTempList}[${output}][5][0]+${confirmCount}}
        ${recoveredCount}    Convert To Integer    ${${dataTempList}[${output}][6][0]+${recoveredCount}}
        ${hospitalizedCount}    Convert To Integer    ${${dataTempList}[${output}][7][0]+${hospitalizedCount}}
        ${deathsCount}    Convert To Integer    ${${dataTempList}[${output}][8][0]+${deathsCount}}
    END
    Write To Cell By Name    Timeline    A${${dataTempListCount}+3}    SUMMARY    data_type=TEXT
    Write To Cell By Name    Timeline    B${${dataTempListCount}+3}    ${newConfirmCount}    data_type=TEXT
    Write To Cell By Name    Timeline    C${${dataTempListCount}+3}    ${newRecoveredCount}    data_type=TEXT
    Write To Cell By Name    Timeline    D${${dataTempListCount}+3}    ${newHospitalizedCount}    data_type=TEXT
    Write To Cell By Name    Timeline    E${${dataTempListCount}+3}    ${newDeathsCount}    data_type=TEXT
    Write To Cell By Name    Timeline    F${${dataTempListCount}+3}    ${confirmCount}    data_type=TEXT
    Write To Cell By Name    Timeline    G${${dataTempListCount}+3}    ${recoveredCount}    data_type=TEXT
    Write To Cell By Name    Timeline    H${${dataTempListCount}+3}    ${hospitalizedCount}    data_type=TEXT
    Write To Cell By Name    Timeline    I${${dataTempListCount}+3}    ${deathsCount}    data_type=TEXT
    Save Excel

Set Data Timeline JSON
    [Arguments]    ${JSONData}
    @{dataTemp}    Create List
    @{dataList}=    JSONLibrary.Get Value From Json    ${JSONData}    $..Data
    ${updateDate}=    Get Value From JSON    ${JSONData}    $..UpdateDate
    ${devBy}=    Get Value From JSON    ${JSONData}    $..DevBy
    Set Suite Variable    ${updateDate}
    Set Suite Variable    ${devBy}
    ${dataCount}    Get Length    @{dataList}
    Set Suite Variable    ${dataCount}
    FOR    ${i}    IN RANGE    ${dataCount}
        @{temp}    Create List
        ${Date}=    JSONLibrary.Get Value From Json    ${JSONData}    $..Data[${i}].Date
        ${NewConfirmed}=    JSONLibrary.Get Value From Json    ${JSONData}    $..Data[${i}].NewConfirmed
        ${NewRecovered}=    JSONLibrary.Get Value From Json    ${JSONData}    $..Data[${i}].NewRecovered
        ${NewHospitalized}=    JSONLibrary.Get Value From Json    ${JSONData}    $..Data[${i}].NewHospitalized
        ${NewDeaths}=    JSONLibrary.Get Value From Json    ${JSONData}    $..Data[${i}].NewDeaths
        ${Confirmed}=    JSONLibrary.Get Value From Json    ${JSONData}    $..Data[${i}].Confirmed
        ${Recovered}=    JSONLibrary.Get Value From Json    ${JSONData}    $..Data[${i}].Recovered
        ${Hospitalized}=    JSONLibrary.Get Value From Json    ${JSONData}    $..Data[${i}].Hospitalized
        ${Deaths}=    JSONLibrary.Get Value From Json    ${JSONData}    $..Data[${i}].Deaths
        Append To List    ${temp}    ${Date}
        Append To List    ${temp}    ${NewConfirmed}
        Append To List    ${temp}    ${NewRecovered}
        Append To List    ${temp}    ${NewHospitalized}
        Append To List    ${temp}    ${NewDeaths}
        Append To List    ${temp}    ${Confirmed}
        Append To List    ${temp}    ${Recovered}
        Append To List    ${temp}    ${Hospitalized}
        Append To List    ${temp}    ${Deaths}
        Append To List    ${dataTemp}    ${temp}
    END
    [Return]    @{dataTemp}

Clear Data Excel
    Open Excel    ${fileName}
    ${rowCountInput}    Get Row Count    Timeline
    Open Excel To Write    ${fileName}    override=override
    Write To Cell By Name    Timeline    B1    ${EMPTY}    data_type=TEXT
    Write To Cell By Name    Timeline    D1    ${EMPTY}    data_type=TEXT
    FOR    ${output}    IN RANGE    0    ${rowCountInput}
        ${index}    Evaluate    ${output} + 3
        Write To Cell By Name    Timeline    A${index}    ${EMPTY}    data_type=TEXT
        Write To Cell By Name    Timeline    B${index}    ${EMPTY}    data_type=TEXT
        Write To Cell By Name    Timeline    C${index}    ${EMPTY}    data_type=TEXT
        Write To Cell By Name    Timeline    D${index}    ${EMPTY}    data_type=TEXT
        Write To Cell By Name    Timeline    E${index}    ${EMPTY}    data_type=TEXT
        Write To Cell By Name    Timeline    F${index}    ${EMPTY}    data_type=TEXT
        Write To Cell By Name    Timeline    G${index}    ${EMPTY}    data_type=TEXT
        Write To Cell By Name    Timeline    H${index}    ${EMPTY}    data_type=TEXT
        Write To Cell By Name    Timeline    I${index}    ${EMPTY}    data_type=TEXT
    END
    Save Excel
