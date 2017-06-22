USE BrazukaScript
/*

EXEC BrazukaScript.dbo.sp_cadastrar_usuario 
		@p_nmeAluno='Alberto Costa'
,		@p_txtSenha='12345678'
,		@p_txtEmail='alberto@email.com'

select * from BrazukaScript.dbo.Aluno
*/


GO

IF EXISTS(select * from sys.objects where name = 'sp_cadastrar_usuario')BEGIN
	DROP PROCEDURE dbo.sp_cadastrar_usuario
END

GO

CREATE PROCEDURE dbo.sp_cadastrar_usuario    
		@p_nmeAluno		VARCHAR(70) = NULL 
,		@p_txtSenha		VARCHAR(50) = NULL
,		@p_txtEmail		VARCHAR(50)	 = NULL

AS

DECLARE	@nmeAluno	VARCHAR(70)
,		@txtSenha	VARCHAR(50)
,		@txtEmail	VARCHAR(50)

-- Tratamento de entradas
SET @nmeAluno = LOWER(LTRIM(RTRIM(@p_nmeAluno)))
SET @txtSenha = LTRIM(RTRIM(@p_txtSenha))
SET @txtEmail = LOWER(LTRIM(RTRIM(@p_txtEmail)))
                
        
-- Todos os campos not null devem ser passados
IF(@nmeAluno IS NULL OR @txtSenha IS NULL OR @txtEmail IS NULL) BEGIN
	
	SELECT 0
    PRINT 'Parâmetro(s) obrigatório(s) não informado(s)'

-- Verifica se o email já foi cadastrado
END ELSE IF EXISTS (SELECT 1 FROM BrazukaScript.dbo.Aluno WHERE TxtEmail = @txtEmail) BEGIN
    
	SELECT 0
    PRINT 'Email já cadastrado, verifique o email informado ou click no link "Esqueci minha senha" para recuperar senha.'

-- Verifica se é um email válido
END ELSE IF (CHARINDEX('@',@txtEmail) <= 0 OR CHARINDEX('.', @txtEmail) <= 0) BEGIN
	
	SELECT 0
    PRINT 'O email informado não é um email válido.'

-- Verifica se a senha contém pelo menos 8 caracterers
END ELSE IF (LEN(@txtSenha) < 8) BEGIN
	
	SELECT 0
    PRINT 'A senha deve conter pelo menos 8 digitos.'

END ELSE IF (CHARINDEX(' ',@nmeAluno) <=0) BEGIN
	
	SELECT 0
    PRINT 'Por favor informe seu nome e sobrenome.'

END ELSE BEGIN

    INSERT INTO BrazukaScript.dbo.Aluno
        (   NmeAluno
        ,   TxtEmail
        ,   TxtSenha
        ,   DtaInicioCadastro)
    VALUES 
        (   @nmeAluno
        ,   @txtEmail
        ,   @txtSenha
        ,   GETDATE())
    
	SELECT 1
    PRINT 'Cadastrado com sucesso.'
    
    
END

