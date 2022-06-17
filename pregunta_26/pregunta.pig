/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código equivalente a la siguiente consulta SQL.

   SELECT 
       firstname 
   FROM 
       u 
   WHERE 
       SUBSTRING(firstname, 0, 1) >= 'm';

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

datos = LOAD 'data.csv' USING PigStorage(',') AS (id:int, nombre:chararray);

posicion = FOREACH datos GENERATE nombre, SUBSTRING(nombre, 0,1) AS subStr;

posicionFiltrado = FILTER posicion BY subStr >= 'M';

nombresFinales = FOREACH posicionFiltrado GENERATE nombre;

STORE nombresFinales INTO 'output';