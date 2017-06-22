USE BrazukaScript
/*
EXEC BrazukaScript.dbo.sp_inativa_aluno 
		@p_txtSenhaAtual		= '87654321'
,		@p_txtSenhaNova			= '12345678'
,		@p_txtSenhaNovaConfirma	= '12345678'
,		@p_txtEmail				= 'alberto@email.com'

select * from BrazukaScript.dbo.Aluno where txtemail = 'alberto@email.com'
*/


GO

IF EXISTS(select * from sys.objects where name = 'sp_inativa_aluno')BEGIN
	DROP PROCEDURE dbo.sp_inativa_aluno
END

GO

CREATE PROCEDURE dbo.sp_inativa_aluno
		@p_txtEmail					VARCHAR(50)	 = ''
    
AS
                

-- Tratamento de entradas
IF @p_txtEmail				IS NULL	SET @p_txtEmail				= ''				
	ELSE SET @p_txtEmail				= LOWER(LTRIM(RTRIM(@p_txtEmail)))


-- Todos os parametros devem ser passados
IF(@p_txtEmail = '') BEGIN
	
	SELECT 0 AS SUCESSO, 'Parâmetro(s) obrigatório(s) não informado(s)' AS MGS

-- Verifica se é um email válido
END ELSE IF (CHARINDEX('@',@p_txtEmail) <= 0 OR CHARINDEX('.', @p_txtEmail) <= 0) BEGIN
	
	SELECT 0 AS SUCESSO, 'Email informado não é um email válido.' AS MGS

-- Verifica se o email já foi cadastrado
END ELSE IF NOT EXISTS (SELECT 1 FROM BrazukaScript.dbo.Aluno WHERE TxtEmail = @p_txtEmail) BEGIN
    
	SELECT 0 AS SUCESSO, 'Email não cadastrado, verifique o email informado.' AS MGS

END ELSE BEGIN

	UPDATE [BrazukaScript].[dbo].[Aluno]
	SET DtaFimCadastro = GETDATE()
	,	ConfirmadoEmail = 0
	WHERE TxtEmail = @p_txtEmail
    
	SELECT 1 AS SUCESSO, 'Aluno inativado.' AS MGS
    
    
END

