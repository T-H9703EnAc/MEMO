SELECT s.sid, t.xidusn, t.xidsqn, t.xidslt, l.object_id, o.object_name
FROM v$lock l, v$transaction t, dba_objects o, v$session s
WHERE t.xidusn = l.id1
  AND l.type = 'TX'
  AND l.sid = s.sid
  AND o.object_id = l.id2;
