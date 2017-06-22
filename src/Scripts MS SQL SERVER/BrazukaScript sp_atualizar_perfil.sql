USE BrazukaScript
/*

select * from BrazukaScript.dbo.Aluno
*/


GO

IF EXISTS(select * from sys.objects where name = 'sp_atualizar_perfil')BEGIN
	DROP PROCEDURE dbo.sp_atualizar_perfil
END

GO

CREATE PROCEDURE dbo.sp_atualizar_perfil    
		@p_txtEmail		VARCHAR(50)	= ''
,		@p_imgAluno		IMAGE		= NULL
,		@p_imgTipo		VARCHAR(4)	= NULL

AS

DECLARE	@txtEmail	VARCHAR(50)	

-- Tratamento de entradas
IF @p_txtEmail IS NULL	SET @txtEmail = '' ELSE SET @txtEmail = LOWER(LTRIM(RTRIM(@p_txtEmail)))
                
        
-- Todos os campos not null devem ser passados
IF(@txtEmail = '' OR @p_imgAluno IS NULL) BEGIN
	
	SELECT 0 AS SUCESSO, 'Campo ARQUIVO é de preenchimento obrigatório.' AS MGS


END IF (CONVERT(VARBINARY(MAX),@p_imgAluno) <= 0x) BEGIN
	
	SELECT 0 AS SUCESSO, 'Imagem não encontrada ou arquivo corrompido' AS MGS

END ELSE IF DATALENGTH(@p_imgAluno) > 2097152 BEGIN
    
	SELECT 0 AS SUCESSO, 'Imagem maior que o permitido. A imagem deve conter no máximo 2MB.' AS MGS

-- Verifica o tipo da imagem UC.07
END ELSE IF @p_imgTipo IS NOT NULL AND @p_imgTipo <> '' AND LOWER(@p_imgTipo) <> 'jpg' AND LOWER(@p_imgTipo) <> 'jpeg' AND LOWER(@p_imgTipo) <> 'gif'  BEGIN
    
	SELECT 0 AS SUCESSO, 'Imagem em formato não permitido. A imagem selecionada deve estar no formato “.jpg” ou “.gif.' AS MGS

-- Verifica se é um email válido UC.E2
END ELSE BEGIN


    UPDATE [BrazukaScript].[dbo].[Aluno]
		SET [ImgAluno]	= @p_imgAluno
		, ImgTipo		= @p_imgTipo
	WHERE TxtEmail	= @txtEmail
    
	SELECT 1 AS SUCESSO, 'Imagem alterada com sucesso.' AS MGS

END

