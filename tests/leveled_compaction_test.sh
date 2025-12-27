#!/bin/bash

# Payload: 1KB
PAYLOAD=$(printf 'A%.0s' {1..1024})

echo "🐢 Starting Level Ordered Compaction Stress Test..."
# This should create and display level ordered files, and when levels were chanced
for i in {1..200}; do
   # 1. Send Request to Leader
   curl -L -s -o /dev/null "http://localhost:8002/put?key=safe-$i&val=$PAYLOAD"
   echo -n "."


   sleep 0.2

   # Every 19 requests, give a longer pause for Compaction to catch up
   if (( $i % 25 == 0 )); then
       echo -n " [Cooling Down] "
       sleep 1
   fi
done

echo -e "\n✅ Done safely."