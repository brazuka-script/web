USE BrazukaScript
/*
EXEC BrazukaScript.dbo.sp_atualizar_senha 
		@p_txtSenhaAtual		= '87654321'
,		@p_txtSenhaNova			= '12345678'
,		@p_txtSenhaNovaConfirma	= '12345678'
,		@p_txtEmail				= 'alberto@email.com'

select * from BrazukaScript.dbo.Aluno where txtemail = 'alberto@email.com'
*/


GO

IF EXISTS(select * from sys.objects where name = 'sp_atualizar_senha')BEGIN
	DROP PROCEDURE dbo.sp_atualizar_senha
END

GO

CREATE PROCEDURE dbo.sp_atualizar_senha
		@p_txtSenhaAtual			VARCHAR(50) = ''
,		@p_txtSenhaNova				VARCHAR(50) = ''
,		@p_txtSenhaNovaConfirma		VARCHAR(50) = ''
,		@p_txtEmail					VARCHAR(50)	 = ''
    
AS
                

-- Tratamento de entradas
IF @p_txtSenhaAtual			IS NULL	SET @p_txtSenhaAtual		= ''			
	ELSE SET @p_txtSenhaAtual			= LTRIM(RTRIM(@p_txtSenhaAtual))

IF @p_txtSenhaNova			IS NULL	SET @p_txtSenhaNova			= ''			
	ELSE SET @p_txtSenhaNova			= LTRIM(RTRIM(@p_txtSenhaNova))

IF @p_txtSenhaNovaConfirma	IS NULL	SET @p_txtSenhaNovaConfirma = ''	
	ELSE SET @p_txtSenhaNovaConfirma	= LTRIM(RTRIM(@p_txtSenhaNovaConfirma))

IF @p_txtEmail				IS NULL	SET @p_txtEmail				= ''				
	ELSE SET @p_txtEmail				= LOWER(LTRIM(RTRIM(@p_txtEmail)))



-- Todos os parametros devem ser passados
IF(@p_txtSenhaAtual = '' OR @p_txtSenhaNova = '' OR @p_txtSenhaNovaConfirma = '' OR @p_txtEmail = '') BEGIN
	
	SELECT 0 AS SUCESSO, 'Parâmetro(s) obrigatório(s) não informado(s)' AS MGS

-- Verifica se é um email válido
END ELSE IF (CHARINDEX('@',@p_txtEmail) <= 0 OR CHARINDEX('.', @p_txtEmail) <= 0) BEGIN
	
	SELECT 0 AS SUCESSO, 'Email informado não é um email válido.' AS MGS

-- Verifica se o email já foi cadastrado
END ELSE IF NOT EXISTS (SELECT 1 FROM BrazukaScript.dbo.Aluno WHERE TxtEmail = @p_txtEmail) BEGIN
    
	SELECT 0 AS SUCESSO, 'Email não cadastrado, verifique o email informado.' AS MGS

-- Verifica senha atual
END ELSE IF @p_txtSenhaAtual <> (SELECT TxtSenha FROM BrazukaScript.dbo.Aluno WHERE TxtEmail = @p_txtEmail) BEGIN
    
	SELECT 0 AS SUCESSO, 'Senha atual inválida.' AS MGS

-- Verifica senha se valida
END ELSE IF (LEN(@p_txtSenhaNova) < 8) BEGIN
	
	SELECT 0 AS SUCESSO, 'A nova senha deve conter pelo menos 8 digitos.' AS MGS

END ELSE IF @p_txtSenhaNova <> @p_txtSenhaNovaConfirma BEGIN

	SELECT 0 AS SUCESSO, 'Senha nova diferente da senha de confirmação.' AS MGS    

END ELSE IF @p_txtSenhaNova = @p_txtSenhaAtual BEGIN

	SELECT 0 AS SUCESSO, 'Senha nova igual a senha atual.' AS MGS    

END ELSE BEGIN

	UPDATE [BrazukaScript].[dbo].[Aluno]
	SET TxtSenha = @p_txtSenhaNova
	WHERE TxtEmail = @p_txtEmail
    
	SELECT 1 AS SUCESSO, 'Senha alterada com sucesso.' AS MGS
    
    
END

