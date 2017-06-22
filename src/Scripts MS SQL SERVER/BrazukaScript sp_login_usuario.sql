USE BrazukaScript
/*
exec BrazukaScript.dbo.sp_login_usuario 12345678, 'alberto@email.com'
*/


GO

IF EXISTS(select * from sys.objects where name = 'sp_login_usuario')BEGIN
	DROP PROCEDURE dbo.sp_login_usuario
END

GO

CREATE PROCEDURE dbo.sp_login_usuario    
		@p_txtSenha		VARCHAR(50) = ''
,		@p_txtEmail		VARCHAR(50)	 = ''

AS

DECLARE @txtSenha	VARCHAR(50)
,		@txtEmail	VARCHAR(50)

-- Tratamento de entradas
IF @p_txtSenha	IS NULL	SET @txtSenha = ''	ELSE SET @txtSenha = LTRIM(RTRIM(@p_txtSenha))
IF @p_txtEmail	IS NULL SET @txtEmail = ''	ELSE SET @txtEmail = LOWER(LTRIM(RTRIM(@p_txtEmail)))
                
        
-- Todos os campos not null devem ser passados
IF(@txtSenha = '' OR @txtEmail = '') BEGIN
	
	SELECT 0 AS SUCESSO, 'Par�metro(s) obrigat�rio(s) n�o informado(s)' AS MGS

-- Verifica se � um email v�lido
END ELSE IF (CHARINDEX('@',@txtEmail) <= 0 OR CHARINDEX('.', @txtEmail) <= 0) BEGIN
	
	SELECT 0 AS SUCESSO, 'O email informado n�o � um email v�lido.' AS MGS

-- Verifica se o email j� foi cadastrado
END ELSE IF NOT EXISTS (SELECT 1 FROM BrazukaScript.dbo.Aluno WHERE TxtEmail = @txtEmail) BEGIN
    
	SELECT 0 AS SUCESSO, 'Email n�o cadastrado. Fa�a seu cadastro.' AS MGS

-- Verifica email e senha
END ELSE IF NOT EXISTS (SELECT 1 FROM BrazukaScript.dbo.Aluno WHERE TxtEmail = @txtEmail and CAST(TxtSenha AS varbinary(MAX)) = CAST(@p_txtSenha AS varbinary(MAX))) BEGIN
    
	SELECT 0 AS SUCESSO, 'As informa��es est�o incorretas.' AS MGS

END ELSE IF ISNULL((SELECT DtaFimCadastro FROM BrazukaScript.dbo.Aluno WHERE TxtEmail = @txtEmail and TxtSenha = @p_txtSenha),0) <> 0 BEGIN
    
	SELECT 0 AS SUCESSO, 'Aluno inativo, para reativar acesse "cadastre-se" e informe seus dados.' AS MGS

END ELSE IF ISNULL((SELECT ConfirmadoEmail FROM BrazukaScript.dbo.Aluno WHERE TxtEmail = @txtEmail and TxtSenha = @p_txtSenha),0) = 0 BEGIN
    
	SELECT 0 AS SUCESSO, 'Email n�o confirmado, favor acessar o link de confirma��o encaminhado ao seu email.' AS MGS

END ELSE BEGIN

   SELECT	1 AS SUCESSO, 
			Aluno.*, 
			QtdAmigos = (Select Count(NroSolicitante) from BrazukaScript.dbo.Amigos Amigos where Amigos.NroSolicitado = Aluno.NroAluno AND Amigos.DtaInicio IS NULL)
   FROM		BrazukaScript.dbo.Aluno Aluno
   WHERE	TxtEmail = @p_txtEmail
    
    
END