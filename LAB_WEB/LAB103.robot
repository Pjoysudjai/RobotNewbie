*** Settings ***
Library           SeleniumLibrary
Library           Collections
Library           BuiltIn
Library           JSONLibrary
Library           RequestsLibrary
Library           String

*** Test Cases ***
GET LIST USERS
    Create Session    url    https://reqres.in    verify=True
    ${resp}    Get Request    url    /api/users?page=2
    Log To Console    ${EMPTY}
    Log To Console    ${resp}
    Log To Console    ${resp.json()}
    Status Should Be    200    ${resp}
    ${data_list}    Get Length    ${resp.json()["data"]}
    ${name_list}    Create List    Michael    Lindsay    Tobias    Byron    George    Rachel
    FOR    ${i}    IN RANGE    0    ${data_list}
        Should Be Equal As Strings    ${name_list[${i}]}    ${resp.json()["data"][${i}]["first_name"]}
    END

GET SINGLE USER
    Create Session    url    https://reqres.in    verify=True
    ${resp}    Get Request    url    /api/users/2
    Log To Console    ${EMPTY}
    Log To Console    ${resp}
    Log To Console    ${resp.json()}
    Status Should Be    200    ${resp}
    ${first_name}    Set Variable    Janet
    Should Be Equal As Strings    ${first_name}    ${resp.json()["data"]["first_name"]}

GET SINGLE USER NOT FOUND
    Create Session    url    https://reqres.in    verify=True
    ${resp}    Get Request    url    /api/users/23
    Log To Console    ${EMPTY}
    Log To Console    ${resp}
    Log To Console    ${resp.json()}
    Status Should Be    404    ${resp}
    ${empty}    Set Variable    {}
    Should Be Equal As Strings    ${empty}    ${resp.json()}

GET LIST <RESOURCE>
    Create Session    url    https://reqres.in    verify=True
    ${resp}    Get Request    url    /api/unknown
    Log To Console    ${EMPTY}
    Log To Console    ${resp}
    Log To Console    ${resp.json()}
    Status Should Be    200    ${resp}
    ${data_list}    Get Length    ${resp.json()["data"]}
    ${name_list}    Create List    cerulean    fuchsia rose    true red    aqua sky    tigerlily    blue turquoise
    FOR    ${i}    IN RANGE    0    ${data_list}
        Should Be Equal As Strings    ${name_list[${i}]}    ${resp.json()["data"][${i}]["name"]}
    END

GET SINGLE <RESOURCE>
    Create Session    url    https://reqres.in    verify=True
    ${resp}    Get Request    url    /api/unknown/2
    Log To Console    ${EMPTY}
    Log To Console    ${resp}
    Log To Console    ${resp.json()}
    Status Should Be    200    ${resp}
    ${color}    Set Variable    '#C74375'
    ${color}    Remove String    ${color}    '
    Should Be Equal As Strings    ${color}    ${resp.json()["data"]["color"]}

GET SINGLE <RESOURCE> NOT FOUND
    Create Session    url    https://reqres.in    verify=True
    ${resp}    Get Request    url    /api/unknown/23
    Log To Console    ${EMPTY}
    Log To Console    ${resp}
    Log To Console    ${resp.json()}
    Status Should Be    404    ${resp}
    ${empty}    Set Variable    {}
    Should Be Equal As Strings    ${empty}    ${resp.json()}

POST CREATE
    Create Session    url    https://reqres.in    verify=True
    ${head}    Create Dictionary    content-type=application/json
    ${body}    Create Dictionary    name=morpheus    job=leader
    ${resp}    Post Request    url    /api/users    headers=${head}    data=${body}
    Log To Console    ${EMPTY}
    Log To Console    ${resp}
    Log To Console    ${resp.json()}
    Status Should Be    201    ${resp}
    Should Be Equal As Strings    morpheus    ${resp.json()["name"]}
    Should Be Equal As Strings    leader    ${resp.json()["job"]}

PUT UPDATE
    Create Session    url    https://reqres.in    verify=True
    ${head}    Create Dictionary    content-type=application/json
    ${body}    Create Dictionary    name=morpheus    job=zion resident
    ${resp}    Put Request    url    /api/users/2    headers=${head}    data=${body}
    Log To Console    ${EMPTY}
    Log To Console    ${resp}
    Log To Console    ${resp.json()}
    Status Should Be    200    ${resp}
    Should Be Equal As Strings    morpheus    ${resp.json()["name"]}
    Should Be Equal As Strings    zion resident    ${resp.json()["job"]}

PATCH UPDATE
    Create Session    url    https://reqres.in    verify=True
    ${head}    Create Dictionary    content-type=application/json
    ${body}    Create Dictionary    name=morpheus    job=zion resident
    ${resp}    Patch Request    url    /api/users/2    headers=${head}    data=${body}
    Log To Console    ${EMPTY}
    Log To Console    ${resp}
    Log To Console    ${resp.json()}
    Status Should Be    200    ${resp}
    Should Be Equal As Strings    morpheus    ${resp.json()["name"]}
    Should Be Equal As Strings    zion resident    ${resp.json()["job"]}

DELETE DELETE
    Create Session    url    https://reqres.in    verify=True
    ${resp}    Delete Request    url    /api/users/2
    Log To Console    ${EMPTY}
    Log To Console    ${resp}
    Status Should Be    204    ${resp}

POST REGISTER - SUCCESSFUL
    Create Session    url    https://reqres.in    verify=True
    ${head}    Create Dictionary    content-type=application/json
    ${body}    Create Dictionary    email=eve.holt@reqres.in    password=pistol
    ${resp}    Post Request    url    /api/register    headers=${head}    data=${body}
    Log To Console    ${EMPTY}
    Log To Console    ${resp}
    Log To Console    ${resp.json()}
    Status Should Be    200    ${resp}
    Should Be Equal As Strings    QpwL5tke4Pnpja7X4    ${resp.json()["token"]}

POST REGISTER - UNSUCCESSFUL
    Create Session    url    https://reqres.in    verify=True
    ${head}    Create Dictionary    content-type=application/json
    ${body}    Create Dictionary    email=sydney@fife
    ${resp}    Post Request    url    /api/register    headers=${head}    data=${body}
    Log To Console    ${EMPTY}
    Log To Console    ${resp}
    Log To Console    ${resp.json()}
    Status Should Be    400    ${resp}
    Should Be Equal As Strings    Missing password    ${resp.json()["error"]}

POST LOGIN - SUCCESSFUL
    Log To Console    ${EMPTY}
    Create Session    url    https://reqres.in    verify=True
    ${head}    Create Dictionary    content-type=application/json
    ${body}    Create Dictionary    email=eve.holt@reqres.in    password=cityslicka
    Log To Console    ${body}
    ${resp}    Post Request    url    /api/login    headers=${head}    data=${body}
    Log To Console    ${resp}
    Log To Console    ${resp.json()}
    Status Should Be    200    ${resp}
    Should Be Equal As Strings    QpwL5tke4Pnpja7X4    ${resp.json()["token"]}

POST LOGIN - UNSUCCESSFUL
    Create Session    url    https://reqres.in    verify=True
    ${head}    Create Dictionary    content-type=application/json
    ${body}    Create Dictionary    email=peter@klaven
    ${resp}    Post Request    url    /api/login    headers=${head}    data=${body}
    Log To Console    ${EMPTY}
    Log To Console    ${resp}
    Log To Console    ${resp.json()}
    Status Should Be    400    ${resp}
    Should Be Equal As Strings    Missing password    ${resp.json()["error"]}

GET DELAYED RESPONSE
    Create Session    url    https://reqres.in    verify=True
    ${resp}    Get Request    url    /api/users?delay=3
    Log To Console    ${EMPTY}
    Log To Console    ${resp}
    Log To Console    ${resp.json()}
    Status Should Be    200    ${resp}
    ${data_list}    Get Length    ${resp.json()["data"]}
    ${email_list}    Create List    george.bluth@reqres.in    janet.weaver@reqres.in    emma.wong@reqres.in    eve.holt@reqres.in    charles.morris@reqres.in    tracey.ramos@reqres.in
    FOR    ${i}    IN RANGE    0    ${data_list}
        Should Be Equal As Strings    ${email_list[${i}]}    ${resp.json()["data"][${i}]["email"]}
    END
