
ALTER Proc [dbo].[usp_APChequeList] 
	@DATE_FROM DATE,
	@DATE_TO DATE
AS
	BEGIN
		
		SELECT 
			ROW_NUMBER() OVER (ORDER BY T2.DocDate DESC) AS 'ROW_NUMBER',
			--T0.DocNum,
			T0.CardName AS Vendor,
			T0.LicTradNum AS TaxID,
			T1.Dscription AS Description,
   			T2.DocNum AS InvoiceNumber,
			T0.DocTotal AS Amount,
			T2.DocDate AS ChequeDate,
			T5.CheckNum AS ChequeNumber
		FROM 
			OPCH T0
		INNER JOIN 
			PCH1 T1 ON T0.DocEntry = T1.DocEntry
		INNER JOIN 
			OVPM T2 ON T0.DocEntry = T2.DocEntry
		INNER JOIN 
			OCHO T5 ON T0.CardCode = T5.VendorCode
		WHERE T2.DocDate BETWEEN @DATE_FROM AND @DATE_TO
		ORDER BY 
			T2.DocDate DESC
	END 
