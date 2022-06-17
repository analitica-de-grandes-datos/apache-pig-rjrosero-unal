/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código equivalente a la siguiente consulta SQL.

   SELECT 
       firstname,
       color
   FROM 
       u 
   WHERE color = 'blue' AND firstname LIKE 'Z%';

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

*/

datos = LOAD 'data.csv' USING PigStorage(',') AS (id:int, nombre:chararray, apellido:chararray, fecha:chararray, color:chararray);

parejas = FOREACH datos GENERATE REGEX_EXTRACT(nombre, '(^Z.*)',1) AS nombreLike, color;

parejasSinNULL = FILTER parejas BY nombreLike is not null;

parejasFiltradas = FILTER parejasSinNULL BY color == 'blue';

STORE parejasFiltradas INTO 'output' USING PigStorage(' ');