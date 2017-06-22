DECLARE @PassphraseEnteredByUser nvarchar(128)
,		@ENCRYP	VARBINARY(8000)
,		@teste nvarchar(100);
SET @PassphraseEnteredByUser 
    = 'A little learning is a dangerous thing!'
set	@teste = 'testedecriptografiatestedcriptografiatestedecriptografia';


-- Update the record for the user's credit card.
-- In this case, the record is number 3681.
SELECT @ENCRYP = EncryptByPassPhrase(@PassphraseEnteredByUser
    , @teste, 1, CONVERT( varbinary, '3681'))

SELECT @ENCRYP
-- Decrypt the encrypted record.
SELECT CONVERT(nvarchar(1000),
    DecryptByPassphrase(@PassphraseEnteredByUser, @ENCRYP, 1 
    , CONVERT(varbinary, '3681')))
    AS 'Decrypted card number' ;
GO




declare @key varbinary(8000)
,		@keyString BIGINT


SELECT @key = CONVERT(varbinary(8000), HashBytes('SHA2_256', 'TESTESTESTE'))
SELECT @key
SELECT @keyString = convert(BIGINT, @key) 
SELECT @keyString
select convert(varbinary(8000),@keyString) 
IF @key = (select convert(varbinary(8000),@keyString)) BEGIN
	SELECT 'IGUAL'
END	ELSE SELECT 'DIFERENTE'