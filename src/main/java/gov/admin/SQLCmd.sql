UPDATE
    pay.laborpaid
SET
    alobs = NULL
WHERE
    (ctrlno IN('2023~005059', '2023~005013'))
    /*(opesina NOT LIKE '1021%') AND
    (entered::DATE BETWEEN '2023-10-01' AND NOW()::DATE) AND
    (pay_ref is null) AND
    (acctg_ref IS NULL) AND
    (advicekey IS NULL) AND
    (alobs IS NULL);*/