# rest-advpl
 Serviços REST genéricos para o ERP TOTVS Protheus®

 ## Configuração

 1) Compile os fontes WSRESTUtil.prw e WSRESTDATA.prw em seu repositório
 
 2) Configure seu appserver.ini como servidor REST. Por exemplo:
    
    [ONSTART]
    JOBS=HTTPJOB
    REFRESHRATE=120

    [HTTPJOB]
    MAIN=HTTP_START
    ENVIRONMENT=P12.1.25

    [HTTPV11]
    Enable=1
    Sockets=HTTPREST

    [HTTPREST] 
    Port=8080
    IPsBind=
    URIs=HTTPURI
    Security=1
    Public=/ping

    [HTTPURI]
    URL=/rest
    PrepareIn=T1,D MG 01
    Instances=1,1
    CorsEnable=1
    AllowOrigin=*

 3) Reinicie seu appserver.exe

 ## Autenticação

 Os serviços implementados utilizam autenticação Basic Auth

 ## Serviços Implementados

 ### GET /paging

 #### Descrição

 Retorna uma lista de registros de uma tabela do ERP Protheus®

 #### Parâmetros de Query String

 ##### cAlias

 Alias da tabela em que se deseja realizar a consulta. Exemplo: SB1

 ##### nIndice

 Índice utilizado para ordenação dos registros da tabela. Exemplo: 1

 ##### nPagina

 Página desejada. Exemplo: 2

 ##### nTamanho

 Quantidade de itens por página. Exemplo: 10

 ##### cCampos

 Campos da tabela que se deseja no retorno. Exemplo: B1_FILIAL,B1_COD,B1_DESC

 #### Exemplo de requisição

    GET /rest/paging?cAlias=SB2&nIndice=1&nPagina=1&nTamanho=10&cCampos=B2_FILIAL,B2_COD,B2_LOCAL,B2_QATU HTTP/1.1
    Host: localhost:8080
    Authorization: Basic YWRtaW46ICAgICAgICAgICAgICAgICAgICAgICAgIA==
    User-Agent: PostmanRuntime/7.20.1
    Accept: */*
    Cache-Control: no-cache
    Postman-Token: 516d0ff4-27ec-47c3-95c4-1b5471f504a5,182f0041-fc4e-44d1-a412-d13e779731d1
    Host: localhost:8080
    Accept-Encoding: gzip, deflate
    Connection: keep-alive
    cache-control: no-cache

#### Exemplo de retorno

    {
        "alias": "SB2",
        "items": [
            {
                "B2_LOCAL": "01",
                "B2_COD": "23228PROD000001",
                "B2_QATU": 422,
                "B2_FILIAL": "D MG 01 "
            },
            {
                "B2_LOCAL": "01",
                "B2_COD": "23288PROD000001",
                "B2_QATU": 100,
                "B2_FILIAL": "D MG 01 "
            },
            {
                "B2_LOCAL": "01",
                "B2_COD": "23342PROD000001",
                "B2_QATU": 128,
                "B2_FILIAL": "D MG 01 "
            },
            {
                "B2_LOCAL": "01",
                "B2_COD": "23342PROD000002",
                "B2_QATU": 9941,
                "B2_FILIAL": "D MG 01 "
            },
            {
                "B2_LOCAL": "01",
                "B2_COD": "23446PROD000001",
                "B2_QATU": 10,
                "B2_FILIAL": "D MG 01 "
            },
            {
                "B2_LOCAL": "01",
                "B2_COD": "23446PROD000002",
                "B2_QATU": 40,
                "B2_FILIAL": "D MG 01 "
            },
            {
                "B2_LOCAL": "01",
                "B2_COD": "23451PROD000001",
                "B2_QATU": 0,
                "B2_FILIAL": "D MG 01 "
            },
            {
                "B2_LOCAL": "02",
                "B2_COD": "23451PROD000001",
                "B2_QATU": 0,
                "B2_FILIAL": "D MG 01 "
            },
            {
                "B2_LOCAL": "01",
                "B2_COD": "23767PROD000001",
                "B2_QATU": 78,
                "B2_FILIAL": "D MG 01 "
            },
            {
                "B2_LOCAL": "02",
                "B2_COD": "23767PROD000001",
                "B2_QATU": 10,
                "B2_FILIAL": "D MG 01 "
            }
        ],
        "size": 10,
        "index": 1,
        "hasNext": true,
        "page": 1
    }
