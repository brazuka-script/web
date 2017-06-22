USE BrazukaScript
/*

select * from BrazukaScript.dbo.Algoritmo
*/


GO

IF EXISTS(select * from sys.objects where name = 'sp_save_arquivo')BEGIN
	DROP PROCEDURE dbo.sp_save_arquivo
END

GO

CREATE PROCEDURE dbo.sp_save_arquivo    
		@p_nroAluno			INT = NULL
,		@p_txtConteudo		NTEXT = NULL
,		@p_nroAlgoritmo		INT = 0
,		@p_nmeAlgoritmo		varchar(50) = ''

AS

DECLARE @nroAlgoritmo	INT
,		@ultimoNroNome	INT

IF @p_nroAlgoritmo IS NULL SET @p_nroAlgoritmo = 0
        
-- Todos os campos not null devem ser passados
IF(@p_txtConteudo IS NULL OR @p_nroAluno IS NULL) BEGIN
	
	SELECT 0 AS SUCESSO, 'Parâmetro(s) obrigatório(s) não informado(s)' AS MGS

--END IF (CONVERT(VARBINARY(MAX),@p_imgAluno) <= 0x) BEGIN
	
--	SELECT 0 AS SUCESSO, 'Imagem não encontrada ou arquivo corrompido' AS MGS

END ELSE BEGIN
	
	-- Confirma se já existe o nome do arquivo, para ser alterado colocando o número referente ao que existe entre colchetes exemplo: 'algoritmo', 'algoritmo[1]', 'algoritmo[2]'
	IF EXISTS (SELECT 1 FROM BrazukaScript.dbo.Algoritmo WHERE NroAluno = @p_nroAluno AND NroAlgoritmo <> @p_nroAlgoritmo AND NmeAlgoritmo = @p_nmeAlgoritmo) BEGIN

		-- Verifica se no nome existe "[x]", para atualizar
		IF CHARINDEX(']',@p_nmeAlgoritmo) = LEN(@p_nmeAlgoritmo) AND CHARINDEX('[',@p_nmeAlgoritmo) = LEN(@p_nmeAlgoritmo) - 2 BEGIN
			
			-- retira "[x]"
			SET @p_nmeAlgoritmo = SUBSTRING(@p_nmeAlgoritmo, 1, LEN(@p_nmeAlgoritmo)-3)

		END	
		    
			-- Retorna o ultimo número do arquivo, se tem o ultimo mais um ou apenas 1
			SELECT @ultimoNroNome = SUBSTRING(MAX([NmeAlgoritmo]), LEN(@p_nmeAlgoritmo) + 2, 1) + 1 FROM [BrazukaScript].[dbo].[Algoritmo] WHERE NmeAlgoritmo like @p_nmeAlgoritmo + '%'

			SET @p_nmeAlgoritmo =  @p_nmeAlgoritmo + '[' + CONVERT(VARCHAR,@ultimoNroNome) + ']'
		
	END
	IF NOT EXISTS( SELECT 1 FROM BrazukaScript.dbo.Algoritmo WHERE NroAluno = @p_nroAluno AND NroAlgoritmo = @p_nroAlgoritmo) BEGIN
		
		SELECT	@nroAlgoritmo = ISNULL(MAX(NroAlgoritmo),0) + 1
		FROM	BrazukaScript.dbo.Algoritmo
		WHERE	NroAluno = @p_nroAluno

		INSERT INTO [dbo].[Algoritmo]
			   ([NroAlgoritmo]
			   ,[NroAluno]
			   ,[DtaCriacao]
			   ,[StaPublico]
			   ,[TxtArquivoConteudo]
			   ,[NmeAlgoritmo])
		 VALUES
			   (@nroAlgoritmo
			   ,@p_nroAluno
			   ,GETDATE()
			   ,1
			   ,@p_txtConteudo
			   ,@p_nmeAlgoritmo )
	
		SELECT 1 AS SUCESSO, 'Arquivo inserido com sucesso.' AS MGS

	END ELSE BEGIN

		UPDATE [dbo].[Algoritmo]
		SET [DtaModificacao] = GETDATE()
			,[TxtArquivoConteudo] = @p_txtConteudo
		WHERE NroAluno = @p_nroAluno AND NroAlgoritmo = @p_nroAlgoritmo

		SELECT 1 AS SUCESSO, 'Arquivo atualizado com sucesso.' AS MGS
	END

END

