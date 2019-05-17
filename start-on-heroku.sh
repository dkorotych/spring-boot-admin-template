#!/usr/bin/env bash

java -Dserver.port=${PORT} -jar build/libs/admin-console.jar
if [ -f hs_err_pid*.log ]; then
  cat hs_err_pid*.log
fi
