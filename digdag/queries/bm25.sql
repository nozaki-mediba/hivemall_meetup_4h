WITH excluded_stopwords AS (
  select
    t.docid,
    t.word
  from
    exploded t
  where
    t.word NOT IN (select s.word from ${stopwords} s)
),
tf AS (
  select
    docid,
    word,
    freq
  from (
    select
      docid,
      tf(word) as word2freq
    from
      excluded_stopwords
    group by
      docid
  ) t
  LATERAL VIEW explode(word2freq) t2 as word, freq
)
-- DIGDAG_INSERT_LINE
select
  tf.docid,
  tf.word,
  -- tf.freq * (log(10, CAST(${td.last_results.n_docs} as FLOAT) / max2(1, df.docs)) + 1.0) as tfidf
  -- tfidf(tf.freq, df.docs, ${td.last_results.n_docs}) as tfidf, --tfidf
--   tfidf(tf.freq, df.docs, ${n_docs}) as tfidf, --tfidf
  (tf.freq*(log(10, CAST(${n_docs} as FLOAT)))*(2+1))/(2*((1-0.75)+(0.75*(document_length.document_length/${td.last_results.ave_dl})+tf.freq))) as cw -- bm25  ${td.last_results.ave_dl} -- http://sonickun.hatenablog.com/entry/2014/11/12/122806
from
  tf
  JOIN document_length ON (tf.docid = document_length.docid)
order by
  cw desc
