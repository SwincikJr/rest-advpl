#include "protheus.ch"

CLASS WSRESTUtil

    DATA oRet AS Object
    DATA lErro AS Boolean
    DATA cMessage AS String

    METHOD New() CONSTRUCTOR
    Static METHOD GetPage(cAlias, nIndice, nPagina, nTamanho, aCampos)

ENDCLASS

METHOD New() CLASS WSRESTUtil
Return Self

METHOD GetPage(cAlias, nIndice, nPagina, nTamanho, aCampos) CLASS WSRESTUtil

    Local lContinua := .T.
    Local nX := 0
    Local nY := 0
    Local oJsonPage := JsonObject():New()
    Local aArea := GetArea()
    Local cMessage := ""
    Local oWSRESTUtil := WSRESTUtil():New()

    If ValType(aCampos) != "A" .Or. Len(aCampos) < 1
        lContinua := .F.
        cMessage := "Lista de campos nao identificada."
    EndIf

    If lContinua .And. (ValType(cAlias) != "C" .Or. !ChkFile(cAlias))
        lContinua := .F.
        cMessage := "Alias nao identificado ou nao existe ou nao e possivel consulta-lo no momento."
    EndIf

    If lContinua .And. (ValType(nIndice) != "N" .Or. Empty(IndexKey(nIndice)))
        lContinua := .F.
        cMessage := "Indice nao identificado ou nao existe."
    EndIf

    If lContinua .And. (ValType(nPagina) != "N" .Or. nPagina < 1)
        nPagina := 1 
    EndIf

    If lContinua .And. (ValType(nTamanho) != "N" .Or. nTamanho < 1)
        nTamanho := 1
    EndIf

    If lContinua 

        oJsonPage["alias"] := cAlias
        oJsonPage["index"] := nIndice
        oJsonPage["page"] := nPagina
        oJsonPage["size"] := nTamanho
        oJsonPage["items"] := {}

        (cAlias)->(dbSetOrder(nIndice))
        (cAlias)->(dbGoTop())

        (cAlias)->(dbSkip((nPagina - 1) * nTamanho))

        For nX := 1 To nTamanho

            If !(cAlias)->(EoF())

                Aadd(oJsonPage["items"], JsonObject():New())

                For nY := 1 To Len(aCampos)

                    If ValType(aCampos[nY]) == "C" .And. (cAlias)->(ColumnPos(aCampos[nY])) > 0

                        oJsonPage["items"][nX][aCampos[nY]] := (cAlias)->&(aCampos[nY])

                    EndIf

                Next

                (cAlias)->(dbSkip())

            Else

                Exit

            EndIf

        Next

        If (cAlias)->(EoF())

            oJsonPage["hasNext"] := .F.

        Else

            oJsonPage["hasNext"] := .T.

        EndIf

        (cAlias)->(dbCloseArea())

        oWSRESTUtil:lErro := .F.
        oWSRESTUtil:cMessage := ""

    Else

        oWSRESTUtil:lErro := .T.
        oWSRESTUtil:cMessage := cMessage

    EndIf

    oWSRESTUtil:oRet := oJsonPage

    RestArea(aArea)

Return oWSRESTUtil
