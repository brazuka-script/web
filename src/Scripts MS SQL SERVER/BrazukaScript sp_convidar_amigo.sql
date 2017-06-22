USE BrazukaScript
/*
exec BrazukaScript.dbo.sp_convidar_amigo 1, 6
*/


GO

IF EXISTS(select * from sys.objects where name = 'sp_convidar_amigo')BEGIN
	DROP PROCEDURE dbo.sp_convidar_amigo
END

GO

CREATE PROCEDURE dbo.sp_convidar_amigo
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

-- Verifica se já existe vinculo entre os alunos
END ELSE IF EXISTS (SELECT 1 FROM BrazukaScript.dbo.Amigos WHERE NroSolicitante = @p_NroSolicitante and NroSolicitado = @p_NroSolicitado and DtaFim IS NULL ) BEGIN
    
	-- Verifica se já está cadastro e/ou está aguardando
	IF EXISTS (SELECT 1 FROM BrazukaScript.dbo.Amigos WHERE NroSolicitante = @p_NroSolicitante and NroSolicitado = @p_NroSolicitado and DtaInicio IS NULL ) BEGIN
		SELECT 0 AS SUCESSO, 'Amigo já cadastrado, aguardando confirmação.' AS MGS
	END ELSE BEGIN
		SELECT 0 AS SUCESSO, 'Amigo já cadastrado.' AS MGS
	END

-- Verifica se já existe vinculo entre os alunos
END ELSE IF EXISTS (SELECT 1 FROM BrazukaScript.dbo.Amigos WHERE NroSolicitante = @p_NroSolicitado and NroSolicitado = @p_NroSolicitante and DtaInicio IS NOT NULL and DtaFim IS NULL) BEGIN
    
	SELECT 0 AS SUCESSO, 'Amigo já cadastrado.' AS MGS

	--ELSE ELE ACEITA O CADASTRO.

END ELSE BEGIN
	
	-- Faz atualização retirando as datas de inicio e fim de vinculos caso exista, NOVA SOLICITAÇÃO
	IF EXISTS (SELECT 1 FROM BrazukaScript.dbo.Amigos WHERE NroSolicitante = @p_NroSolicitante and NroSolicitado = @p_NroSolicitado AND DtaFim IS NOT NULL) AND
		NOT EXISTS (SELECT 1 FROM BrazukaScript.dbo.Amigos WHERE NroSolicitante = @p_NroSolicitado and NroSolicitado = @p_NroSolicitante AND DtaFim IS NULL) BEGIN
		
		UPDATE [dbo].[Amigos]
		   SET [DtaInicio] = NULL
			  ,[DtaFim] = NULL
		 WHERE NroSolicitante = @p_NroSolicitante and NroSolicitado = @p_NroSolicitado
	
	-- ACEITAR
	END ELSE IF EXISTS (SELECT 1 FROM BrazukaScript.dbo.Amigos WHERE NroSolicitante = @p_NroSolicitado and NroSolicitado = @p_NroSolicitante AND DtaInicio IS NULL AND DtaFim IS NULL) BEGIN
		
		UPDATE [dbo].[Amigos]
		   SET [DtaInicio] = GETDATE()
			  ,[DtaFim] = NULL
		 WHERE NroSolicitante = @p_NroSolicitado and NroSolicitado = @p_NroSolicitante

	--END ELSE IF EXISTS (SELECT 1 FROM BrazukaScript.dbo.Amigos WHERE NroSolicitante = @p_NroSolicitado and NroSolicitado = @p_NroSolicitante AND DtaFim IS NOT NULL) BEGIN
		
	--	UPDATE [dbo].[Amigos]
	--	   SET [DtaInicio] = NULL
	--		  ,[DtaFim] = NULL
	--	 WHERE NroSolicitante = @p_NroSolicitado and NroSolicitado = @p_NroSolicitante

	END ELSE BEGIN 

		INSERT INTO [dbo].[Amigos]
			   ([NroSolicitante]
			   ,[NroSolicitado])
		 VALUES
			   (@p_NroSolicitante
			   ,@p_NroSolicitado)
    
    END
    
	SELECT 1 AS SUCESSO, 'Amigo adicionado com sucesso.' AS MGS

END

