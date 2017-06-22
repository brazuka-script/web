USE BrazukaScript
/*
execute BrazukaScript.dbo.sp_cancelar_exclui_amigo 6, 1
*/


GO

IF EXISTS(select * from sys.objects where name = 'sp_cancelar_exclui_amigo')BEGIN
	DROP PROCEDURE dbo.sp_cancelar_exclui_amigo
END

GO

CREATE PROCEDURE dbo.sp_cancelar_exclui_amigo
		@p_NroSolicitante		INT			= 0
,		@p_NroSolicitado		INT			= 0
    
AS
                

-- Tratamento de entradas
IF @p_NroSolicitante		IS NULL	SET @p_NroSolicitante		= 0			
IF @p_NroSolicitado			IS NULL	SET @p_NroSolicitado		= 0			



-- Todos os parametros devem ser passados
IF(@p_NroSolicitante = 0 OR @p_NroSolicitado = 0) BEGIN
	
	SELECT 0 AS SUCESSO, 'Parâmetro(s) obrigatório(s) não informado(s)' AS MGS

-- Verifica se aluno que adicionou existe ou se é válido
END ELSE IF NOT EXISTS (SELECT 1 FROM BrazukaScript.dbo.Aluno WHERE nroAluno = @p_NroSolicitante AND DtaFimCadastro IS NULL AND ConfirmadoEmail = 1) BEGIN
    
	SELECT 0 AS SUCESSO, 'Aluno não encontrado ou não é válido.' AS MGS

-- Verifica se amigo adicionado existe ou se é válido
END ELSE IF NOT EXISTS (SELECT 1 FROM BrazukaScript.dbo.Aluno WHERE nroAluno = @p_NroSolicitado AND DtaFimCadastro IS NULL AND ConfirmadoEmail = 1) BEGIN
    
	SELECT 0 AS SUCESSO, 'Amigo não encontrado ou não é válido.' AS MGS

-- Verifica se já foi excluido o vinculo entre os alunos
END ELSE IF EXISTS (SELECT 1 FROM BrazukaScript.dbo.Amigos WHERE NroSolicitante = @p_NroSolicitante and NroSolicitado = @p_NroSolicitado and DtaFim IS NOT NULL) AND
	EXISTS (SELECT 1 FROM BrazukaScript.dbo.Amigos WHERE NroSolicitante = @p_NroSolicitado and NroSolicitado = @p_NroSolicitante and DtaFim IS NOT NULL) BEGIN
    
	SELECT 0 AS SUCESSO, 'Amigo já excluido ou cancelado.' AS MGS

-- Verifica se existe pedido ou vinculo de amizade
END ELSE IF NOT EXISTS (SELECT 1 FROM BrazukaScript.dbo.Amigos WHERE NroSolicitante = @p_NroSolicitante and NroSolicitado = @p_NroSolicitado) AND
	NOT EXISTS (SELECT 1 FROM BrazukaScript.dbo.Amigos WHERE NroSolicitante = @p_NroSolicitado and NroSolicitado = @p_NroSolicitante) BEGIN

	SELECT 0 AS SUCESSO, 'Vinculo não encontrado.' AS MGS

END ELSE BEGIN
		
	IF EXISTS (SELECT 1 FROM BrazukaScript.dbo.Amigos WHERE NroSolicitante = @p_NroSolicitado and NroSolicitado = @p_NroSolicitante) BEGIN
		
		UPDATE [dbo].[Amigos]
		   SET [DtaFim] = GETDATE()
		 WHERE NroSolicitante = @p_NroSolicitado and NroSolicitado = @p_NroSolicitante

	END  
	
	IF EXISTS (SELECT 1 FROM BrazukaScript.dbo.Amigos WHERE NroSolicitante = @p_NroSolicitante and NroSolicitado = @p_NroSolicitado) BEGIN
		
		UPDATE [dbo].[Amigos]
		   SET [DtaFim] = GETDATE()
		 WHERE NroSolicitante = @p_NroSolicitante and NroSolicitado = @p_NroSolicitado

	END

    SELECT 1 AS SUCESSO, 'Amigo excluido com sucesso.' AS MGS
END

