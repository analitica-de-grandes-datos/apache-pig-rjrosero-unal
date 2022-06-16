/*
Pregunta
===========================================================================

Para el archivo `data.tsv` compute la cantidad de registros por letra de la 
columna 2 y clave de al columna 3; esto es, por ejemplo, la cantidad de 
registros en tienen la letra `b` en la columna 2 y la clave `jjj` en la 
columna 3 es:

  ((b,jjj), 216)

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

datos = LOAD 'data.tsv' AS (letra:chararray, letras:bag{}, pares:map[]);

paresAplanados = FOREACH datos GENERATE FLATTEN(letras) AS letrasAplanadas, FLATTEN(pares) AS paresSolos;

paresTokenizados = FOREACH paresAplanados GENERATE letrasAplanadas, FLATTEN(TOKENIZE(paresSolos,',')) AS clavesSolas;

paresFormados = FOREACH paresTokenizados GENERATE (letrasAplanadas, clavesSolas) AS parejas;

paresAgrupados = GROUP paresFormados BY parejas;

totalClaves = FOREACH paresAgrupados GENERATE group, COUNT(paresFormados);

STORE totalClaves INTO 'output' USING PigStorage(',');