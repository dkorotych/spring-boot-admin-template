#!/usr/bin/env bash

java -Dserver.port=${PORT} -jar build/libs/admin-console.jar
for file in hs_err_pid*.log; do
  if [ -f "$file" ]; then
    cat hs_err_pid*.log
    break
  fi
done
