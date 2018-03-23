#!/bin/bash
set -e
# To achieve the top most performance you should tune the source server system limits
ulimit -n 30000
cd /var/loadtest
. /appenv/bin/activate
yandex-tank

exec "$@"