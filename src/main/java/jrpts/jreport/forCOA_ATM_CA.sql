/**
 * Author:  felix
 * Created: 04 8, 21
 */

--SELECT LPAD(680, 5, 0)
SELECT years, refnum, ngalan, 'ATM Wages' AS details, totamt, 'ATM' AS typed FROM (
      SELECT
         split_part(timebook.advicekey, '-', 1)::SMALLINT AS years,
         split_part(timebook.advicekey, '-', 2) AS refnum,
         concat(jobworker.lastname, ', ', jobworker.firstname, ' ', COALESCE(jobworker.midname, '.')) AS ngalan, 
         advicepay.totamt
      FROM 
         pay.advicepay INNER JOIN pay.timebook
         ON advicepay.refkey = timebook.advicekey
         INNER JOIN psnl.jobworker
         ON timebook.worker = jobworker.uniqkey
      WHERE
         (DATE_PART('YEAR', advicepay.refdate) = 2021) AND
         (CONCAT(advicepay.refkey, advicepay.totamt, jobworker.lastname, jobworker.firstname, COALESCE(jobworker.midname, '_')) LIKE '%0041%')
      UNION ALL
      SELECT
         split_part(laborpaid.advicekey, '-', 1)::SMALLINT AS years,
         split_part(laborpaid.advicekey, '-', 2) AS refnum,
         concat(contractual.lastname, ', ', contractual.firstname, ' ', COALESCE(contractual.midname, '.')) AS ngalan, 
         advicepay.totamt
      FROM 
         pay.advicepay INNER JOIN pay.laborpaid
         ON advicepay.refkey = laborpaid.advicekey
         INNER JOIN psnl.contractual
         ON laborpaid.worker = contractual.uniqkey
      WHERE 
         (DATE_PART('YEAR', advicepay.refdate) = 2021) AND
         (CONCAT(advicepay.refkey, advicepay.totamt, contractual.lastname, contractual.firstname, COALESCE(contractual.midname, '_')) LIKE '%0041%')
   ) ORDER BY ngalan