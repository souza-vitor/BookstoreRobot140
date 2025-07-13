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
${user}    rob42
${password}    Rob123!!!
${isbn}    9781449325862
${content-type}    application/json

*** Test Cases ***
User Post Book
    Post user
    Create user token
    Post Book

Get Book
    ${url}    Set Variable    https://bookstore.toolsqa.com/BookStore/v1/Book?ISBN=${isbn}
    ${response}    GET    ${url}

    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response_body}

    Status Should Be    200
    Should Be Equal    ${response_body}[isbn]    ${isbn}


*** Keywords ***
Post user
    ${headers}    Create Dictionary    Content-Type=${content-type}    Accept=${content-type}
    ${body}    Create Dictionary    userName=${user}    password=${password}

    ${response}    POST    url=https://bookstore.toolsqa.com/Account/v1/User    json=${body}    headers=${headers}

    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response_body}

    Status Should Be    201
    Should Be Equal    ${response_body}[username]    ${user}

    # salva o user id para o post book
    Set Test Variable    ${user_id}    ${response_body}[userID]
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

    # salva o user token para auth
    Set Test Variable    ${token}    ${response_body}[token]
    Log To Console    ${token}

Post Book
    ${headers}    Create Dictionary    Content-Type=${content-type}    Authorization=Bearer ${token}
    
    ${isbn_dict}    Create Dictionary    isbn=${isbn}
    ${isbns_list}    Create List    ${isbn_dict}
    ${body}    Create Dictionary    userId=${user_id}    collectionOfIsbns=${isbns_list}

    ${response}    POST    url=https://bookstore.toolsqa.com/BookStore/v1/Books    json=${body}    headers=${headers}

    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response_body}

    Status Should Be    201
    Should Be Equal    ${response_body}[books][0][isbn]    ${isbn}