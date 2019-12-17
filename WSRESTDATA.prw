#INCLUDE "TOTVS.CH"
#INCLUDE "RESTFUL.CH"

WSRESTFUL paging DESCRIPTION "Servico para consultas genericas em tabelas do Protheus"

    WSDATA cAlias AS String OPTIONAL
    WSDATA nIndice AS Integer OPTIONAL
    WSDATA nPagina AS Integer OPTIONAL
    WSDATA nTamanho AS Integer OPTIONAL
    WSDATA cCampos AS String OPTIONAL

    WSMETHOD GET DESCRIPTION "Retorna uma lista de itens de uma tabela do Prothues" WSSYNTAX "/paging"

END WSRESTFUL

WSMETHOD GET WSRECEIVE cAlias,nIndice,nPagina,nTamanho,cCampos WSSERVICE paging

    Local oWSRESTUtil := Nil
    Local cPage := ""
    Local aCampos := Iif(!Empty(::cCampos),StrTokArr2(::cCampos,","),{})

    oWSRESTUtil := WSRESTUtil():GetPage(::cAlias, ::nIndice, ::nPagina, ::nTamanho, aCampos)

    Self:SetContentType("application/json")

    If !oWSRESTUtil:lErro

        cPage := FwJsonSerialize(oWSRESTUtil:oRet)

        Self:SetResponse(cPage)

    Else

        SetRestFault(400,EncodeUTF8(oWSRESTUtil:cMessage))

    EndIf

Return !oWSRESTUtil:lErro
