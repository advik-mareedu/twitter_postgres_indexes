SELECT
    '#' || tag AS tag, count(*) AS count
FROM (
    SELECT DISTINCT id,(jsonb->>'text'::TEXT) AS tag from(
        SELECT 
            t1.data->> 'id' AS id,
            jsonb_array_elements(
                COALESCE(t1.data->'extended_tweet'->'entities'->'hashtags',t1.data->'entities'->'hashtags','[]') ) AS jsonb
        FROM tweets_jsonb t1
        WHERE t1.data-> 'entities' -> 'hashtags' @> '[{"text": "coronavirus"}]'
        OR t1.data -> 'extended_tweet'-> 'entities' -> 'hashtags' @> '[{"text": "coronavirus"}]'
    ) AS sub
    ORDER BY tag
) AS t 
GROUP BY tag
ORDER BY count DESC, tag
LIMIT 1000;
