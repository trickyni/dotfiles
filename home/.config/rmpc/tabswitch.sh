#!/bin/sh
if [ "$(rmpc remote --pid "$PID" query)" = "Lyrics" ]; then
  rmpc remote --pid "$PID" switchtab "Queue"
else
  rmpc remote --pid "$PID" switchtab "Lyrics"
fi
