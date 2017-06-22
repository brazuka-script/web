/*
DECLARE @NOME VARCHAR(70)

EXEC @NOME = BrazukaScript.DBO.sp_formatar_nome 'ALBERTO COSTA DE ARAUJO'
*/
USE BrazukaScript

GO

IF EXISTS(select * from sys.objects where name = 'sp_formatar_nome')BEGIN
	DROP PROCEDURE dbo.sp_formatar_nome
END

GO

CREATE PROCEDURE dbo.sp_formatar_nome    
		@p_nmeAluno		VARCHAR(70) = '' output

AS

DECLARE @Result varchar(2000)

SET @p_nmeAluno = LOWER(@p_nmeAluno) + ' '

SET @Result = ''

WHILE 1=1 BEGIN
	IF PATINDEX('% %',@p_nmeAluno) = 0 BREAK
	SET @Result = @Result + UPPER(Left(@p_nmeAluno,1))+
	SubString  (@p_nmeAluno,2,CharIndex(' ',@p_nmeAluno)-1)
	SET @p_nmeAluno = SubString(@p_nmeAluno,
		CharIndex(' ',@p_nmeAluno)+1,Len(@p_nmeAluno))
END

SET @p_nmeAluno = Left(@Result,Len(@Result))


--RETURN @Result
--SELECT @Result