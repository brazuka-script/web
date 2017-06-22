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
		@p_txtEmail		VARCHAR(50)	 = ''
    
AS
DECLARE	@txtEmail	VARCHAR(50)

-- Tratamento de entradas
IF @p_txtEmail IS NULL	SET @txtEmail = '' ELSE SET @txtEmail = LOWER(LTRIM(RTRIM(@p_txtEmail)))
                

-- Todos os parametros devem ser passados
IF(@txtEmail = '') BEGIN
	
	SELECT 0 AS SUCESSO, 'Parâmetro(s) obrigatório(s) não informado(s)' AS MGS

-- Verifica se é um email válido
END ELSE IF (CHARINDEX('@',@txtEmail) <= 0 OR CHARINDEX('.', @txtEmail) <= 0) BEGIN
	
	SELECT 0 AS SUCESSO, 'Email informado não é um email válido.' AS MGS

-- Verifica se o email já foi cadastrado
END ELSE IF NOT EXISTS (SELECT 1 FROM BrazukaScript.dbo.Aluno WHERE txtEmail = @txtEmail) BEGIN

	SELECT 0 AS SUCESSO, 'Email não cadastrado. Faça seu cadastro.' AS MGS    

END ELSE BEGIN

	SELECT	1 AS SUCESSO,'Uma mensagem foi encaminhada ao email cadastro contendo a senha para o acesso.' as MGS, txtSenha
	FROM	BrazukaScript.dbo.Aluno
	WHERE	txtEmail = @txtEmail
	
	
--    SELECT  TxtSenha 
--    INTO      p_senha 
--    FROM     brazuka_site.aluno 
--    WHERE   TxtEmail = @p_txtEmail;
    
--    SET p_msg = 'Localizado com sucesso.';
    
    
END

