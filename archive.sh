#!/usr/bin/env bash

# parametrs

TEAMID=$1
METHOD=$2
APP_VERSION=$3
BUNDLEID=$4
APP_NAME=$5
CONFIGURATION=$6
FIR_SHORT_URL=$7
IS_ENTERPRISER=$8
IS_UPLOAD=$9

# const

SCHEME=Secoo-iPhone
DIR_CURRENT=$(cd "$(dirname "$0")";pwd)
DIR_SUPPER=$(cd "$(dirname "$0")"; cd ..;pwd)
DATE=$(date +%Y-%m-%d)
TIME=$(date +%H.%M.%S)
DATE_TIME="$DATE-$TIME"
NAME="$SCHEME-$DATE_TIME"
ARCHIVE_NAME="$NAME.xcarchive"

INFO_PLIST_PATH=$DIR_SUPPER/$SCHEME/Info.plist
ENTITLEMENT_PATH=$DIR_SUPPER/$SCHEME/$SCHEME.entitlements

# define

INFO_PLIST_NAME=Info.plist
ENTITLEMENTS_NAME=Entitlements.entitlements
BUILD_INFO_PLIST=$DIR_CURRENT/$INFO_PLIST_NAME
BUILD_ENTITLEMENTS=$DIR_CURRENT/$ENTITLEMENTS_NAME

PROJECT_PATH=$DIR_SUPPER/$SCHEME.xcodeproj
INFOPLIST_FILE=$DIR_CURRENT/$INFO_PLIST_NAME
EXPORT_OPTIONS_PATH=$DIR_CURRENT/ExportOptions.plist

ARCHIVE_DIR=$HOME/Library/Developer/Xcode/Archives/$DATE
EXPORT_DIR=$DIR_CURRENT/Results
ARCHIVE_PATH=$ARCHIVE_DIR/$ARCHIVE_NAME
EXPORT_PATH=$EXPORT_DIR/$NAME

EXPORT_PATH_IPA=$EXPORT_PATH/$SCHEME.ipa
EXE_UPLOAD_SH=$HOME/fir-upload.sh

# configure

cp -f $INFO_PLIST_PATH $BUILD_INFO_PLIST
cp -f $ENTITLEMENT_PATH $BUILD_ENTITLEMENTS
cp -f $DIR_CURRENT/fir-upload.sh $EXE_UPLOAD_SH

echo -e "\033[1m setting ExportOptions plist file ... \033[0m"
/usr/libexec/PlistBuddy -c "Set :teamID $TEAMID" $EXPORT_OPTIONS_PATH
/usr/libexec/PlistBuddy -c "Set :method $METHOD" $EXPORT_OPTIONS_PATH

echo -e "\033[1m setting info plist file ... \033[0m"
/usr/libexec/PlistBuddy -c "Set :CFBundleIdentifier $BUNDLEID" $BUILD_INFO_PLIST
/usr/libexec/PlistBuddy -c "Set :CFBundleDisplayName $APP_NAME" $BUILD_INFO_PLIST
/usr/libexec/PlistBuddy -c "Set :CFBundleShortVersionString $APP_VERSION" $BUILD_INFO_PLIST

if [[ $IS_ENTERPRISER == 1 ]]; then
	echo -e "\033[1m setting entitlements file ... \033[0m"
	/usr/libexec/PlistBuddy -c "Delete :aps-environment" $ENTITLEMENT_PATH
	/usr/libexec/PlistBuddy -c "Delete :com.apple.developer.in-app-payments" $ENTITLEMENT_PATH
	/usr/libexec/PlistBuddy -c "Delete :com.apple.developer.associated-domains" $ENTITLEMENT_PATH
fi

# archive ipa

bash $DIR_CURRENT/archive-ipa.sh $PROJECT_PATH $SCHEME $CONFIGURATION $BUNDLEID $TEAMID $INFOPLIST_FILE $ARCHIVE_PATH $EXPORT_PATH $EXPORT_OPTIONS_PATH

# clear

cp -f $BUILD_ENTITLEMENTS $ENTITLEMENT_PATH
rm $BUILD_ENTITLEMENTS
rm $BUILD_INFO_PLIST

# upload ipa to fir

if [[ $IS_UPLOAD == 1 ]]; then
	echo -e "\033[1;32m Uploading ipa to fir ... \033[0m"
	echo ""
	cd $HOME
	bash $EXE_UPLOAD_SH $EXPORT_PATH_IPA $FIR_SHORT_URL
	cd $DIR_CURRENT
fi

