SELECT 
  docid,
  COUNT(word) as document_length
FROM
  exploded
GROUP BY
  docid