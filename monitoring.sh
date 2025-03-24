#!/bin/bash

if [[ -n $(pgrep -x test.sh) ]]; then
  if curl -s -o /dev/null -w "%{http_code}" https://test.com/monitoring/test/api | grep -q "200"; then
    status="API is up"
  else
    status="API is down"
  fi

  log_message="$(date "+%Y-%m-%d %H:%M:%S") - $status"
  echo "$log_message" >> /var/log/monitoring.log

fi