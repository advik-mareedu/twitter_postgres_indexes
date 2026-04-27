CREATE INDEX ON tweets_jsonb USING gin ((data-> 'entities' -> 'hashtags'));
CREATE INDEX ON tweets_jsonb USING gin ((data->'extended_tweet'->'entities'->'hashtags'));
