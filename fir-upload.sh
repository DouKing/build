#!/usr/bin/env bash

IPA_PATH=${1-Secoo-iPhone.ipa}
SHORT_URL=${2-"test06"}

APP_TOKEN=

fir publish $IPA_PATH -T $APP_TOKEN -s $SHORT_URL -Q