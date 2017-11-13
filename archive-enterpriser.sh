#!/usr/bin/env bash

# parametrs

APP_VERSION=${1-"5.9.4"}
APP_NAME=${2-"LVMH"}
BUNDLEID=${3-"com.secoo.test06"}
FIR_SHORT_URL=${4-"test06"}
CONFIGURATION=${5-Release}

# const

TEAMID=RQW526M45R
METHOD=enterprise

DIR_CURRENT=$(cd "$(dirname "$0")";pwd)

# archive

bash $DIR_CURRENT/archive.sh $TEAMID $METHOD $APP_VERSION $BUNDLEID $APP_NAME $CONFIGURATION $FIR_SHORT_URL 1 1

