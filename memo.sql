SELECT
  lo.object_id,
  ao.object_name,
  vs.sid,
  vs.serial#,
  vs.username,
  vs.osuser,
  vs.status
FROM
  v$locked_object lo
  JOIN dba_objects ao ON lo.object_id = ao.object_id
  JOIN v$session vs ON lo.session_id = vs.sid
WHERE
  ao.object_name = 'YOUR_TABLE_NAME';  -- ここにテーブル名を指定
