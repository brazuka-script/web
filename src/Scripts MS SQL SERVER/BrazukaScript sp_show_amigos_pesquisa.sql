USE BrazukaScript
/*
EXEC sp_show_amigos_pesquisa @p_NroAluno=1134 , @p_NmeAmigoPesquisa='S'
*/


GO

-- Exibe todos os alunos que ainda não pertence a sua rede de amigos
IF EXISTS(select * from sys.objects where name = 'sp_show_amigos_pesquisa')BEGIN
	DROP PROCEDURE dbo.sp_show_amigos_pesquisa
END

GO

CREATE PROCEDURE dbo.sp_show_amigos_pesquisa
		@p_NroAluno			INT		= 0
,		@p_NmeAmigoPesquisa	VARCHAR(70)	= ''
    
AS

-- Tratamento de entradas
IF @p_NroAluno			IS NULL	SET @p_NroAluno			= 0			
IF @p_NmeAmigoPesquisa	IS NULL	SET @p_NmeAmigoPesquisa	= ''


-- Todos os parametros devem ser passados
IF(@p_NroAluno = 0) BEGIN
	
	SELECT 0 AS SUCESSO, 'Parâmetro(s) obrigatório(s) não informado(s)' AS MGS

-- Verifica se aluno existe
END ELSE IF NOT EXISTS (SELECT 1 FROM BrazukaScript.dbo.Aluno WHERE nroAluno = @p_NroAluno AND DtaFimCadastro IS NULL AND ConfirmadoEmail = 1) BEGIN
    
	SELECT 0 AS SUCESSO, 'Aluno não encontrado ou não é válido.' AS MGS

END ELSE BEGIN

	SELECT [NroAluno], [NmeAluno] 
	FROM [BrazukaScript].[dbo].[Aluno]
	WHERE ConfirmadoEmail = 1 AND
			DtaFimCadastro IS NULL AND
			NroAluno <> @p_NroAluno AND
			NmeAluno LIKE '%' + @p_NmeAmigoPesquisa + '%' AND
			NroAluno NOT IN (SELECT NroAmigo = CASE WHEN NroSolicitado = @p_NroAluno THEN NroSolicitante ELSE NroSolicitado END
						  FROM [BrazukaScript].[dbo].[Amigos]
						  WHERE (NroSolicitado = @p_NroAluno OR NroSolicitante = @p_NroAluno)
						  AND DtaFim IS NULL)
	ORDER BY NmeAluno;

END