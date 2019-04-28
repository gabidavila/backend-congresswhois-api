#!/bin/bash
/opt/cloud_sql_proxy --instances=$INSTANCE_CONNECTION_NAME=tcp:5432 &
rails server -b "0.0.0.0"