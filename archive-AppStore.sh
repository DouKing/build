#!/usr/bin/env bash

# parametrs

APP_VERSION=${1-"5.9.4"}
APP_NAME=${2-"寺库奢侈品"}
BUNDLEID=${3-"com.secoo.test06"}
FIR_SHORT_URL=${4-"test06"}
CONFIGURATION=${5-Release}

# const

TEAMID=K2VBE95LX6
METHOD="app-store"

DIR_CURRENT=$(cd "$(dirname "$0")";pwd)

# archive

bash $DIR_CURRENT/archive.sh $TEAMID $METHOD $APP_VERSION $BUNDLEID $APP_NAME $CONFIGURATION $FIR_SHORT_URL 0 0

