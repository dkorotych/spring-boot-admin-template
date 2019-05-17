#!/usr/bin/env bash

java -Dserver.port=${PORT} -jar target/admin-console.jar
if [ -f hs_err_pid*.log ]; then
  cat hs_err_pid*.log
fi
