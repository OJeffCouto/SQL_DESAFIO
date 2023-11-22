# VISUALIZADNO AS TABELAS

SELECT * FROM TBL_FatoDetalhes_DadosModelagem;

SELECT * FROM TBL_FatoCabecalho_DadosModelagem;

SELECT * FROM Categoria;

SELECT * FROM Cclientes;

SELECT * FROM Escritorios;

SELECT * FROM Fornecedores; 

SELECT * FROM Funcionarios; 

SELECT * FROM Produtos;

# QUESTÃO 1: Valor total das vendas e dos fretes por produto e ordem de venda;

SELECT "Data", FATOD.CupomID ,Produto, SUM((Quantidade*Valor)-(Quantidade*Desconto)) AS TOTAL_VENDAS,
SUM(Quantidade*ValorFrete) AS TOTAL_FRETE
FROM TBL_FatoCabecalho_DadosModelagem as FATOC
INNER JOIN TBL_FatoDetalhes_DadosModelagem AS FATOD ON FATOD.CupomID = FATOC.CupomID
INNER JOIN TBL_PRODUTOS AS PROD ON PROD.ProdutoID  = FATOD.ProdutoID 
GROUP BY "Data", FATOD.CupomID 
ORDER BY "Data"  DESC
;

# QUESTÃO 2:  Valor de venda por tipo de produto

SELECT Produto, SUM((Quantidade*Valor)-(Quantidade*Desconto)) AS TOTAL_VENDAS
FROM TBL_FatoCabecalho_DadosModelagem as FATOC
INNER JOIN TBL_FatoDetalhes_DadosModelagem AS FATOD ON FATOD.CupomID = FATOC.CupomID
INNER JOIN TBL_PRODUTOS AS PROD ON PROD.ProdutoID  = FATOD.ProdutoID 
GROUP BY Produto 
ORDER BY TOTAL_VENDAS DESC
;

# QUESTÃO 3: Quantidade e valor das vendas por dia, mês, ano.

SELECT FATOD.CupomID, "Data" , SUBSTRING("Data", 1,2) AS DIA, SUBSTRING("Data", 4,2) AS MES, SUBSTRING("Data", 7,4) AS ANO ,Produto, 
SUM((Quantidade*Valor)-(Quantidade*Desconto)) AS TOTAL_VENDAS
FROM TBL_FatoCabecalho_DadosModelagem as FATOC
INNER JOIN TBL_FatoDetalhes_DadosModelagem AS FATOD ON FATOD.CupomID = FATOC.CupomID
INNER JOIN TBL_PRODUTOS AS PROD ON PROD.ProdutoID  = FATOD.ProdutoID 
GROUP BY Produto, FATOD.CupomID 
ORDER BY TOTAL_VENDAS DESC;

# QUESTÃO 4: Lucro dos meses

SELECT SUBSTRING("Data", 7,4)  AS ANO,SUBSTRING("Data", 4,2)  AS MES,(Quantidade*(Valor-Desconto)-Custo) AS Lucro
FROM TBL_FatoCabecalho_DadosModelagem AS FATOC
INNER JOIN TBL_FatoDetalhes_DadosModelagem AS FatoD ON FATOC.CupomID  = FATOD.CupomID
GROUP BY ANO, MES
; 


# QUESTÃO 5:  Venda por produto 

SELECT PROD.Produto, SUM(FATOD.Quantidade) AS QNT,
FATOD.CupomID ,Produto, SUM((Quantidade*Valor)-(Quantidade*Desconto)) AS TOTAL_VENDAS
FROM TBL_FatoCabecalho_DadosModelagem AS FATOC
INNER JOIN TBL_FatoDetalhes_DadosModelagem AS FatoD ON FATOC.CupomID  = FATOD.CupomID
INNER JOIN TBL_PRODUTOS AS PROD ON PROD.ProdutoID = FatoD.ProdutoID
GROUP BY PROD.Produto
ORDER BY QNT DESC
;


# QUESTÃO 6: Venda por cliente, cidade do cliente e estado

SELECT Regiao , Cidade, Cliente,  SUM(Quantidade) AS QNT, SUM((Quantidade*Valor)-(Quantidade*Desconto)) AS TOTAL_VENDAS
FROM TBL_FatoCabecalho_DadosModelagem AS FATOC
INNER JOIN TBL_FatoDetalhes_DadosModelagem AS FatoD ON FATOC.CupomID  = FATOD.CupomID
INNER JOIN TBL_CLIENTES AS CLI ON CLI.ClienteID = FATOC.ClienteID 
GROUP BY Cliente, Regiao , Cidade 
ORDER BY QNT DESC
;

# Questão 7: Média de produtos vendidos;

SELECT AVG(SOMA) AS MEDIA_VENDAS FROM 
(SELECT FATOD.CupomID, SUM(FATOD.Quantidade) AS SOMA
FROM TBL_FatoCabecalho_DadosModelagem AS FATOC
INNER JOIN TBL_FatoDetalhes_DadosModelagem AS FatoD ON FATOC.CupomID  = FATOD.CupomID
GROUP BY FATOD.CupomID) 
;

# Questão 8: Média de compras que um cliente faz; 

SELECT AVG(MEDIA) AS MEDIA_COMPRAS FROM 
(SELECT COUNT(FATOC.ClienteID) AS MEDIA
FROM TBL_FatoCabecalho_DadosModelagem AS FATOC
INNER JOIN TBL_FatoDetalhes_DadosModelagem AS FatoD ON FATOC.CupomID  = FATOD.CupomID
INNER JOIN TBL_CLIENTES AS CLI ON CLI.ClienteID = FATOC.ClienteID 
GROUP BY CLI.Cliente
ORDER BY MEDIA DESC)
;