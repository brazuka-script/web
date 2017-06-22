USE BrazukaScript
/*
exec BrazukaScript.dbo.sp_recuperar_lista_arquivos 1
select * from BrazukaScript.dbo.Algoritmo
*/


GO

IF EXISTS(select * from sys.objects where name = 'sp_recuperar_lista_arquivos')BEGIN
	DROP PROCEDURE dbo.sp_recuperar_lista_arquivos
END

GO

CREATE PROCEDURE dbo.sp_recuperar_lista_arquivos    
		@p_nroAluno				INT = NULL


AS
                
        
-- Todos os campos not null devem ser passados
IF (@p_nroAluno IS NULL) BEGIN
	
	SELECT 0 AS SUCESSO, 'Parâmetro(s) obrigatório(s) não informado(s)' AS MGS

--END IF @p_nroAluno <> @p_nroAlunoPesquisante AND 
--	((NOT EXISTS (SELECT 1 FROM BrazukaScript.dbo.Amigos WHERE NroSolicitante = @p_nroAluno and NroSolicitado = @p_nroAlunoPesquisante AND DtaInicio IS NOT NULL AND DtaFim IS NULL) AND
--	NOT EXISTS (SELECT 1 FROM BrazukaScript.dbo.Amigos WHERE NroSolicitante = @p_nroAlunoPesquisante and NroSolicitado = @p_nroAluno AND DtaInicio IS NOT NULL AND DtaFim IS NULL)) OR
--	(SELECT StaPublico FROM BrazukaScript.dbo.Algoritmo WHERE NroAlgoritmo = @p_nroAlgoritmo and NroAluno = @p_nroAluno) = 0) BEGIN

--		SELECT 0 AS SUCESSO, 'Não possui autorização, para acesso' AS MGS

END IF NOT EXISTS (SELECT 1 FROM BrazukaScript.dbo.Aluno WHERE NroAluno = @p_nroAluno) BEGIN
	
	SELECT 0 AS SUCESSO, 'Aluno não encontrado' as MGS

END ELSE BEGIN
	
	SELECT 1 AS SUCESSO, NroAlgoritmo,NroAluno,DtaCriacao,DtaModificacao,DtaExclusao,StaPublico,TxtArquivoConteudo,NmeAlgoritmo 
    FROM BrazukaScript.dbo.Algoritmo 
	WHERE NroAluno = @p_nroAluno

END

