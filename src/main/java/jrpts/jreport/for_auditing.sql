 WITH auditing AS (
         SELECT count(*) AS mgatawo
           FROM (SELECT DISTINCT
		    jobworker.uniqkey,
                    jobarrange.jobyear,
                    (jobworker.bank_acct IS NULL) AS nonatm
                 FROM
		    psnl.jobworker INNER JOIN cbo.jobarrange
		    ON jobworker.uniqkey = jobarrange.empkey
                  WHERE
		    --(date_part('YEAR'::text, jobarrange.frdate) = 2022) AND
		    /*(('2022-10-01'::date BETWEEN jobarrange.frdate AND jobarrange.todate) OR 
		       ('2022-12-31'::date BETWEEN jobarrange.frdate AND jobarrange.todate))*/
		    ((jobarrange.frdate BETWEEN '2022-12-01'::date AND '2022-12-31'::date) OR
                     (jobarrange.todate BETWEEN '2022-12-01'::date AND '2022-12-31'::date))
		) distincted
        ), nabunosan AS (
         SELECT count(*) AS nakabunos
           FROM psnl.nabunosan nabunosan_1
          WHERE (nabunosan_1.bunos <> (0)::double precision)
        )
 SELECT
     auditing.mgatawo,
     nabunosan.nakabunos,
     ((nabunosan.nakabunos::double precision / auditing.mgatawo::double precision) * 100.0) AS purcento,
     now() AS karon
 FROM (auditing CROSS JOIN nabunosan);