DISP-ORD.
	EXEC SQL
		SELECT O.CODE, C.NAME INTO :ORD-CODE, :NAME
		FROM ORDER O, CUSTOMER C
		WHERE O.CUS_CODE = C.CODE
			AND O.CODE = :ORD-CODE
	END-EXEC.
	IF SQLCODE = 0 THEN
		DISPLAY "ORD-CODE: " ORD-CODE NAME
	ELSE
		GO TO ERR-CUS-NOT-FOUND.