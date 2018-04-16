SELECT 
  SUM(document_length)/ COUNT(docid) as ave_dl
FROM
  document_length