/*
Pregunta
===========================================================================

Para el archivo `data.tsv` Calcule la cantidad de registros por clave de la 
columna 3. En otras palabras, cuántos registros hay que tengan la clave 
`aaa`?

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

datos = LOAD 'data.tsv' AS (letra:chararray, letras:bag{}, pares:map[]);

paresAplanados = FOREACH datos GENERATE FLATTEN(pares) AS paresSolos;

paresTokenizados = FOREACH paresAplanados GENERATE FLATTEN(TOKENIZE(paresSolos,',')) AS clavesSolas;

paresAgrupados = GROUP paresTokenizados BY clavesSolas;

totalClaves = FOREACH paresAgrupados GENERATE group, COUNT(paresTokenizados);

STORE totalClaves INTO 'output' USING PigStorage(',');