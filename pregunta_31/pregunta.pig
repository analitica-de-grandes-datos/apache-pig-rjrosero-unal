/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Cuente la cantidad de personas nacidas por año.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

datos = LOAD 'data.csv' USING PigStorage(',') AS (id:int, nombre:chararray, apellido:chararray, fecha:datetime);

fechaReg = FOREACH datos GENERATE GetYear(fecha) AS anio;

anioAgrupado = GROUP fechaReg BY anio;

totalAnio = FOREACH anioAgrupado GENERATE group, COUNT(fechaReg) AS cantidad;

STORE totalAnio INTO 'output' USING PigStorage(',');