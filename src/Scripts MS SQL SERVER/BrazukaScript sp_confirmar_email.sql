USE BrazukaScript
/*

EXEC BrazukaScript.dbo.sp_confirmar_email 
		@p_txtKey ='1192391604303245979'
,		@p_nroAluno ='1115'

select * from BrazukaScript.dbo.Aluno
*/


GO

IF EXISTS(select * from sys.objects where name = 'sp_confirmar_email')BEGIN
	DROP PROCEDURE dbo.sp_confirmar_email
END

GO

CREATE PROCEDURE dbo.sp_confirmar_email    
		@p_txtKey		VARCHAR(40) = '' 
,		@p_nroAluno		INT			= 0

AS

DECLARE @txtKey		VARCHAR(40)

-- Tratamento de entradas
IF @p_txtKey	IS NULL	SET @p_txtKey	= ''
IF @p_nroAluno	IS NULL	SET @p_nroAluno = 0
                
        
-- Todos os campos not null devem ser passados
IF(@p_txtKey = '' OR @p_nroAluno = 0) BEGIN
	
	SELECT 0 AS SUCESSO, 'Parâmetro(s) obrigatório(s) não informado(s)' AS MGS

-- Verifica se o email já foi cadastrado
END ELSE IF NOT EXISTS (SELECT 1 FROM BrazukaScript.dbo.Aluno WHERE NroAluno = @p_nroAluno) BEGIN
    
	SELECT 0 AS SUCESSO, 'Usuário não cadastrado.' AS MGS

END ELSE IF ISNULL((SELECT ConfirmadoEmail FROM BrazukaScript.dbo.Aluno WHERE NroAluno = @p_nroAluno), 0) = 1 BEGIN
    
	SELECT 0 AS SUCESSO, 'Email já confirmado.' AS MGS

END ELSE BEGIN

	SELECT	@txtKey = HashBytes('SHA1',REVERSE(txtSenha)) + HashBytes('SHA1',CONVERT(VARCHAR,DtaInicioCadastro,113))
	FROM	BrazukaScript.dbo.Aluno
	where	NroAluno = @p_nroAluno

	SET		@txtKey = SIGN(convert(bigint,HashBytes('SHA2_256', @txtKey))) * convert(bigint,HashBytes('SHA2_256', @txtKey))

    IF	@txtKey <> @p_txtKey BEGIN
		
		SELECT 0 AS SUCESSO, 'Usuário não cadastrado.' AS MGS

	END ELSE BEGIN

		UPDATE [BrazukaScript].[dbo].[Aluno]
		SET ConfirmadoEmail = 1
		WHERE	NroAluno = @p_nroAluno

		SELECT	1 AS SUCESSO, * 
		FROM	BrazukaScript.dbo.Aluno
		WHERE	NroAluno = @p_nroAluno
    
	END

END