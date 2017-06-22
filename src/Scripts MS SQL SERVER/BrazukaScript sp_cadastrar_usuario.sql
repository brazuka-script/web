 USE BrazukaScript
/*

EXEC BrazukaScript.dbo.sp_cadastrar_usuario 
		@p_nmeAluno='luIz marmota'
,		@p_txtSenha='12345678'
,		@p_txtEmail='lu@email.com'

select * from BrazukaScript.dbo.Aluno

delete from BrazukaScript.dbo.Aluno

*/


--------------------------------------------------------------------------------

print '*** dbo.sp_cadastrar_usuario   Versao:17/11/2012'

/* Caso de Uso Manter Aluno */
--------------------------------------------------------------------------------


GO

IF EXISTS(select * from sys.objects where name = 'sp_cadastrar_usuario')BEGIN
	DROP PROCEDURE dbo.sp_cadastrar_usuario
END

GO

CREATE PROCEDURE dbo.sp_cadastrar_usuario    
		@p_nmeAluno		VARCHAR(70) = '' 
,		@p_txtSenha		VARCHAR(50) = ''
,		@p_txtEmail		VARCHAR(50)	 = ''
,		@p_nroCPF		VARCHAR(11) = ''
,		@p_sexo			CHAR(1) = NULL
,		@p_imgAluno		IMAGE = NULL
,		@p_imgTipo		VARCHAR(4) = NULL

AS

DECLARE	@nmeAluno	VARCHAR(70)
,		@txtSenha	VARCHAR(50)
,		@txtEmail	VARCHAR(50)
,		@txtKey		VARCHAR(40)
,		@msg		VARCHAR(200)

SET @msg = ''

-- Tratamento de entradas
IF @p_nmeAluno IS NULL	SET @nmeAluno = '' ELSE SET @nmeAluno = LTRIM(RTRIM(@p_nmeAluno))
IF @p_txtSenha IS NULL	SET @txtSenha = '' ELSE SET @txtSenha = LTRIM(RTRIM(@p_txtSenha))
IF @p_txtEmail IS NULL	SET @txtEmail = '' ELSE SET @txtEmail = LOWER(LTRIM(RTRIM(@p_txtEmail)))
                
        
-- Todos os campos not null devem ser passados UC.E1
IF(@nmeAluno = '' ) SET @msg = 'Campo NOME é de preenchimento obrigatório.\n'
IF(@txtSenha = '' ) SET @msg = @msg + 'Campo SENHA é de preenchimento obrigatório.\n'
IF(@txtEmail = '' ) SET @msg = @msg +'Campo EMAIL é de preenchimento obrigatório.'
IF( @msg  <> '') BEGIN
	
	SELECT 0 AS SUCESSO, @msg AS MGS

-- Verifica se foi desativado para reativar o aluno
END ELSE IF ISNULL((SELECT DtaFimCadastro FROM BrazukaScript.dbo.Aluno WHERE TxtEmail = @txtEmail),0) <> 0 BEGIN
    
	IF EXISTS(SELECT 1 FROM BrazukaScript.dbo.Aluno WHERE TxtEmail = @txtEmail AND NmeAluno = @p_nmeAluno AND ISNULL(NroCPF,'0') = ISNULL(@p_nroCPF,'0'))BEGIN
		
		UPDATE [BrazukaScript].[dbo].[Aluno]
		SET DtaFimCadastro = null
		,	TxtSenha		= @p_txtSenha
		WHERE TxtEmail = @p_txtEmail

		SELECT	@txtKey = HashBytes('SHA1',REVERSE(@txtSenha)) + HashBytes('SHA1',CONVERT(VARCHAR,DtaInicioCadastro,113))
		FROM	BrazukaScript.dbo.Aluno
		where	TxtEmail = @txtEmail

		SELECT	1 AS SUCESSO
		,		'Reativação com sucesso, acesse seu email para concluir reativação.' AS MGS
		--,		convert(varchar,HashBytes('MD5', @txtKey))
		,		SIGN(convert(bigint,HashBytes('SHA2_256', @txtKey))) * convert(bigint,HashBytes('SHA2_256', @txtKey))
		,		NroAluno
		FROM	BrazukaScript.dbo.Aluno
		WHERE	TxtEmail = @txtEmail

	END ELSE BEGIN

		SELECT 0 AS SUCESSO, 'Aluno inativo. Para reativação informe os parametros corretos.' AS MGS

	END

-- Verifica se o email já foi cadastrado UC.E4
END ELSE IF EXISTS (SELECT 1 FROM BrazukaScript.dbo.Aluno WHERE TxtEmail = @txtEmail) BEGIN
    
	SELECT 0 AS SUCESSO, 'O E-mail já está cadastrado. Informe outro e-mail.' AS MGS

-- Verifica se o cpf é válido UC.E5
END ELSE IF @p_nroCPF is not null and @p_nroCPF <> '' and LEN(@p_nroCPF) < 11 BEGIN
    
	SELECT 0 AS SUCESSO, 'CPF inválido. Verifique o número informado.' AS MGS

-- Verifica tamanho da imagem UC.E6
END ELSE IF DATALENGTH(@p_imgAluno) > 2097152 BEGIN
    
	SELECT 0 AS SUCESSO, 'Imagem maior que o permitido. A imagem deve conter no máximo 2MB.' AS MGS

-- Verifica o tipo da imagem UC.07
END ELSE IF @p_imgTipo IS NOT NULL AND @p_imgTipo <> '' AND (LOWER(@p_imgTipo) <> 'jpg' AND LOWER(@p_imgTipo) <> 'jpeg' AND LOWER(@p_imgTipo) <> 'gif')  BEGIN
    
	SELECT 0 AS SUCESSO, 'Imagem em formato não permitido. A imagem selecionada deve estar no formato “.jpg” ou “.gif.' AS MGS

-- Verifica se é um email válido UC.E2
END ELSE IF (CHARINDEX('@',@txtEmail) <= 0 OR CHARINDEX('.', @txtEmail) <= 0) BEGIN
	
	SELECT 0 AS SUCESSO, 'E-mail inválido.' AS MGS

-- Verifica se a senha contém pelo menos 8 caracterers
END ELSE IF (LEN(@txtSenha) < 8) BEGIN
	
	SELECT 0 AS SUCESSO, 'A senha deve conter pelo menos 8 digitos.' AS MGS

END ELSE IF (CHARINDEX(' ',@nmeAluno) <=0) BEGIN
	
	SELECT 0 AS SUCESSO, 'Por favor informe seu nome e sobrenome.' AS MGS

-- Verifica se existe o mesmo nome de usuário UC.E3
END ELSE IF EXISTS (SELECT 1 FROM BrazukaScript.dbo.Aluno WHERE NmeAluno = @nmeAluno) BEGIN
	
	SELECT 0 AS SUCESSO, 'O nome informado não está disponível. Informe outro nome.' AS MGS

END ELSE BEGIN
	
	EXEC BrazukaScript.DBO.sp_formatar_nome @nmeAluno output

    INSERT INTO BrazukaScript.dbo.Aluno
        (   NmeAluno
        ,   TxtEmail
        ,   TxtSenha
        ,   DtaInicioCadastro
		,	ConfirmadoEmail
		,	ImgAluno
		,   ImgTipo
		,	NroCPF
		,	Sexo)
    VALUES 
        (   @nmeAluno
        ,   @txtEmail
        ,   @txtSenha
        ,   GETDATE()
		,	0
		,	@p_imgAluno
		,	@p_imgTipo
		,	@p_nrocpf
		,	@p_sexo)
    
	SELECT	@txtKey = HashBytes('SHA1',REVERSE(@txtSenha)) + HashBytes('SHA1',CONVERT(VARCHAR,DtaInicioCadastro,113))
	FROM	BrazukaScript.dbo.Aluno
	where	TxtEmail = @txtEmail

    SELECT	1 AS SUCESSO
	,		'Cadastrado com sucesso, acesse seu email para concluir cadastro.' AS MGS
	--,		convert(varchar,HashBytes('MD5', @txtKey))
	,		SIGN(convert(bigint,HashBytes('SHA2_256', @txtKey))) * convert(bigint,HashBytes('SHA2_256', @txtKey))
	,		NroAluno
	FROM	BrazukaScript.dbo.Aluno
	where	TxtEmail = @txtEmail
    
END

