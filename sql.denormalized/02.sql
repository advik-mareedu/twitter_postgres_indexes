SELECT
    '#' || (jsonb->>'text'::TEXT) AS tag, count(*) AS count
FROM (
    SELECT DISTINCT 
        t1.data->> 'id',
        jsonb_array_elements(
                COALESCE(t2.data->'entities'->'hashtags','[]') ||
                COALESCE(t2.data->'extended_tweet'->'entities'->'hashtags','[]')
            ) AS jsonb
    FROM tweets_jsonb t1
    JOIN tweets_jsonb t2 ON (t1.data->> 'id' = t2.data->> 'id')
    WHERE t1.data-> 'extended_tweet'-> 'entities' -> 'hashtags' @> '[{"text": "coronavirus"}]'
        OR t1.data -> 'extended_tweet'-> 'entities' -> 'hashtags' @> '[{"text": "coronavirus"}]'
) t 
GROUP BY tag
ORDER BY count DESC, tag
LIMIT 1000;

