/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código en Pig para manipulación de fechas que genere la siguiente 
salida.

   1971-07-08,jul,07,7
   1974-05-23,may,05,5
   1973-04-22,abr,04,4
   1975-01-29,ene,01,1
   1974-07-03,jul,07,7
   1974-10-18,oct,10,10
   1970-10-05,oct,10,10
   1969-02-24,feb,02,2
   1974-10-17,oct,10,10
   1975-02-28,feb,02,2
   1969-12-07,dic,12,12
   1973-12-24,dic,12,12
   1970-08-27,ago,08,8
   1972-12-12,dic,12,12
   1970-07-01,jul,07,7
   1974-02-11,feb,02,2
   1973-04-01,abr,04,4
   1973-04-29,abr,04,4

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

datos = LOAD 'data.csv' USING PigStorage(',') AS (id:int, nombre:chararray, apellido:chararray, fecha:datetime);

fechaReg = FOREACH datos GENERATE ToString(fecha,'yyyy-MM-dd'), 
                                  (CASE ToString(fecha, 'MMM')
                                        WHEN 'Jan' THEN 'ene'
                                        WHEN 'Feb' THEN 'feb'
                                        WHEN 'Mar' THEN 'mar'
                                        WHEN 'Apr' THEN 'abr'
                                        WHEN 'May' THEN 'may'
                                        WHEN 'Jun' THEN 'jun'
                                        WHEN 'Jul' THEN 'jul'
                                        WHEN 'Aug' THEN 'ago'
                                        WHEN 'Sep' THEN 'sep'
                                        WHEN 'Oct' THEN 'oct'
                                        WHEN 'Nov' THEN 'nov'
                                        WHEN 'Dec' THEN 'dic'
                                        ELSE 'error' END                                  
                                  ) AS nombreMes, ToString(fecha, 'MM') AS mesDos, ToString(fecha, 'M') AS mes1;

STORE fechaReg INTO 'output' USING PigStorage(',');