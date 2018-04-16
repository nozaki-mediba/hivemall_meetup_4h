select
  docid,
  collect_list(feature(word, cw)) as bm25
from
  bm25
group by
  docid
