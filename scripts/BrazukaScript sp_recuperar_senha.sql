USE BrazukaScript
/*
EXEC BrazukaScript.dbo.sp_recuperar_senha @p_txtEmail = 'alberto@email.com'


*/


GO

IF EXISTS(select * from sys.objects where name = 'sp_recuperar_senha')BEGIN
	DROP PROCEDURE dbo.sp_recuperar_senha
END

GO

CREATE PROCEDURE dbo.sp_recuperar_senha
		@p_txtEmail		VARCHAR(50)	 = NULL
    
AS

-- Todos os parametros devem ser passados
IF(@p_txtEmail IS NULL) BEGIN
	
	SELECT 0
    PRINT 'Parâmetro(s) obrigatório(s) não informado(s)'

-- Verifica se é um email válido
END ELSE IF (CHARINDEX('@',@p_txtEmail) <= 0 OR CHARINDEX('.', @p_txtEmail) <= 0) BEGIN
	
	SELECT 0
    PRINT 'Email informado não é um email válido.'

-- Verifica se o email já foi cadastrado
END ELSE IF NOT EXISTS (SELECT 1 FROM BrazukaScript.dbo.Aluno WHERE txtEmail = @p_txtEmail) BEGIN

	SELECT 0    
    PRINT 'Email não cadastrado. Faça seu cadastro.'

END ELSE BEGIN

	SELECT	txtSenha
	FROM	BrazukaScript.dbo.Aluno
	WHERE	txtEmail = @p_txtEmail
	
	
--    SELECT  TxtSenha 
--    INTO      p_senha 
--    FROM     brazuka_site.aluno 
--    WHERE   TxtEmail = @p_txtEmail;
    
--    SET p_msg = 'Localizado com sucesso.';
    
    
END

