	EXEC SQL declare cursor ORD_GE_K1 for
	select ORD_CODE,ORD_CUSTOMER,ORD_DETAIL
	from ORDER where ORD_CODE >= :ORD-CODE
	order by ORD_CODE END-EXEC.
	...
	EXEC SQL declare cursor ORD_GE_K2 for
	select ORD_CODE,ORD_CUSTOMER,ORD_DETAIL
	from ORDER where ORD_CUSTOMER >= :ORD-CUSTOMER
	ORDER BY ORD_CUSTOMER END-EXEC.
	...
	MOVE CUS-CODE TO ORD-CUSTOMER.
	EXEC SQL open ORD_GE_K2 END-EXEC.
	MOVE "ORD_GE_K2" to ORD-SEQ.
	MOVE 0 TO END-FILE.
	PERFORM READ-ORD UNTIL END-FILE = 1.
READ-ORD SECTION.
BEG-ORD.
	IF ORD-SEQ = "ORD_GE_K1"
	THEN
	EXEC SQL fetch ORD_GE_K1 into :ORD-CODE,
	:ORD-CUSTOMER,:ORD-DETAIL END-EXEC
	ELSE IF ORD-SEQ = "ORD_GE_K2"
	THEN
	EXEC SQL fetch ORD_GE_K2 into :ORD-CODE,
	:ORD-CUSTOMER,:ORD-DETAIL END-EXEC
	ELSE IF ...
	END-IF.
	IF SQLCODE NOT = 0 THEN
		MOVE 1 TO END-FILE GO TO NO-ORD.
	<<processing current ORD record>>
EXIT-ORD.
	EXIT.