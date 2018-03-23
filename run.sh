#!/usr/bin/env bash
set -eux

# Run influx and grafana
docker-compose up -d

# Let the services come up
sleep 10

# Create a data base in influx
curl -i -XPOST http://localhost:8086/query --data-urlencode "q=CREATE DATABASE loadtest"

# Add influx as data source to grafana
curl -X POST "http://admin:admin@localhost:3000/api/datasources" -d @docker/grafana/etc/grafana/grafana_data_source.json --header "Content-Type: application/json"

# Add Load Test dashboard to grafana
curl -X POST "http://admin:admin@localhost:3000/api/dashboards/db" -d @docker/grafana/etc/grafana/grafana_dashboard.json --header "Content-Type: application/json"

docker run --rm -v $(pwd):/var/loadtest --name tank --network tankyard_tank_yard -it tankyard_yandex-tank -c load.yml