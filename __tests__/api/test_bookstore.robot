# cria o usuario 
# gera o token dele
# testa se esta autorizado
# com o userID, monta um json com o isbn e cria o livro
# faz um put com o resto das informações
# faz um get com o isbn e faz o check de status code, titulo, subtitulo e autor
# sobe no github e faz a gravação depois

*** Settings ***
Library    RequestsLibrary


*** Variables ***
${user}    rob21
${password}    Rob123!!!
${content-type}    application/json

*** Test Cases ***
Post user
    ${headers}    Create Dictionary    Content-Type=${content-type}    Accept=${content-type}
    ${body}    Create Dictionary    userName=${user}    password=${password}

    ${response}    POST    url=https://bookstore.toolsqa.com/Account/v1/User    json=${body}    headers=${headers}

    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response_body}

    Status Should Be    201
    Should Be Equal    ${response_body}[username]    ${user}

    # salva o user id para auth
    ${user_id}    Set Variable    ${response_body}[userID]
    Log To Console    ${user_id}

Create user token
    #header opcional?
    ${headers}    Create Dictionary    Content-Type=${content-type}    Accept=${content-type}
    ${body}    Create Dictionary    userName=${user}    password=${password}

    ${response}    POST    url=https://bookstore.toolsqa.com/Account/v1/GenerateToken    json=${body}    headers=${headers}

    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response_body}

    Status Should Be    200
    Should Be Equal    ${response_body}[status]    Success
    Should Be Equal    ${response_body}[result]    User authorized successfully.

Post authorized
    #header opcional?
    ${headers}    Create Dictionary    Content-Type=${content-type}    Accept=${content-type}
    ${body}    Create Dictionary    userName=${user}    password=${password}

    ${response}    POST    url=https://bookstore.toolsqa.com/Account/v1/Authorized    json=${body}    headers=${headers}

    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response_body}

    Status Should Be    200
    Should Be True    ${response_body}