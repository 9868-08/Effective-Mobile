#!/bin/bash

################################################################################
# 08/04/2025  Roman Ermolaev Original code.                                    #
################################################################################

# Check if the process test.sh is running
if [[ -n $(pgrep -x test.sh) ]]; then
  echo "Process test.sh is running." >&2
  
  # Send an HTTP request to the API and check the status
  http_status=$(curl -s -o /dev/null -w "%{http_code}" --connect-timeout 5 https://test.com/monitoring/test/api)
  if [[ $http_status == "000" ]]; then
    status="API is unreachable (Connection failed)"
  elif [[ $http_status -eq 200 ]]; then
    status="API is up"
  else
    status="API is down (HTTP Status: $http_status)"
  fi
  # Debugging: Print HTTP status code
  echo "Sended message to https://test.com/monitoring/test/api: $http_status" >&2
fi


  # Log the date and status
  log_message="$(date "+%Y-%m-%d %H:%M:%S") - $status"

  if echo "$log_message" >> /var/log/monitoring.log; then
    echo "Log written successfully." >&2
  else
    echo "Failed to write to log file." >&2
  fi

