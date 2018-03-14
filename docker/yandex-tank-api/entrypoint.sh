#!/bin/bash
set -e
# To achieve the top most performance you should tune the source server system limits
ulimit -n 30000
cd /tank-api-workdir
. /appenv/bin/activate
/appenv/bin/yandex-tank-api-server --work-dir /tank-api-workdir

exec "$@"