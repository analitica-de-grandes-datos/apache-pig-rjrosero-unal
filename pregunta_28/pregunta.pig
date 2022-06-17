/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código equivalente a la siguiente consulta SQL.

   SELECT 
       birthday, 
       DATE_FORMAT(birthday, "yyyy"),
       DATE_FORMAT(birthday, "yy"),
   FROM 
       persons
   LIMIT
       5;

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

datos = LOAD 'data.csv' USING PigStorage(',') AS (id:int, nombre:chararray, apellido:chararray, fecha:datetime);

fechaReg = FOREACH datos GENERATE ToString(fecha, 'YYYY') AS anioCuatro, ToString(fecha, 'YY') AS anioDos;

/*fechaLim = LIMIT fechaReg 5;*/

STORE fechaReg INTO 'output' USING PigStorage(',');