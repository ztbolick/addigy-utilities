#!/bin/bash
LOCAL_ADMIN_FULLNAME="Mike Tyson"
LOCAL_ADMIN_SHORTNAME="mtyson"
LOCAL_ADMIN_PASSWORD="Shp1n4l"

if [[ $LOCAL_ADMIN_SHORTNAME == `dscl . -list /Users UniqueID | awk '{print $1}' | grep -w $LOCAL_ADMIN_SHORTNAME` ]]; then
    echo "User already exists!"
    exit 0
else
    sysadminctl -addUser $LOCAL_ADMIN_SHORTNAME -fullName "$LOCAL_ADMIN_FULLNAME" -password "$LOCAL_ADMIN_PASSWORD"  -admin
    dscl . create /Users/$LOCAL_ADMIN_SHORTNAME IsHidden 1 
    mv /Users/$LOCAL_ADMIN_SHORTNAME /var/$LOCAL_ADMIN_SHORTNAME
    dscl . -create /Users/$LOCAL_ADMIN_SHORTNAME NFSHomeDirectory /var/$LOCAL_ADMIN_SHORTNAME
    dscl . -delete "/SharePoints/$LOCAL_ADMIN_FULLNAME's Public Folder"
fi

echo "New user `dscl . -list /Users UniqueID | awk '{print $1}' | grep -w $LOCAL_ADMIN_SHORTNAME` has been created with unique ID `dscl . -list /Users UniqueID | grep -w $LOCAL_ADMIN_SHORTNAME | awk '{print $2}'`"