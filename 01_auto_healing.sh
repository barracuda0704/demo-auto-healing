#!/bin/sh

PRJ_NAME=sample-eap-app
EXTERNAL=1 #INTERNAL=0, EXTERNAL=1


echo -e "\033[32m[S]=============================================================================\033[0m"
echo -e "\033[46m@@@[S]_[AUTO HEALING TEST SETTING]\033[0m"

echo -e "\033[44m[Create Project - ${PRJ_NAME}]\033[0m"
oc new-project ${PRJ_NAME}
oc project ${PRJ_NAME}

if [ ${EXTERNAL} == 1 ]; then
    echo -e "\033[44m[External Setting]\033[0m"

    oc process -n openshift eap73-basic-s2i \
	-p APPLICATION_NAME=${PRJ_NAME} \
	-p SOURCE_REPOSITORY_URL="https://github.com/barracuda0704/sample-source.git" \
	-p SOURCE_REPOSITORY_REF="" \
	-p CONTEXT_DIR="" | oc create -f -
else
    echo -e "\033[44m[Internal Setting]\033[0m"
fi


echo -e "\033[36m@@@[E]_[AUTO HEALING TEST SETTING]\033[0m"
echo -e "\033[32m=============================================================================[E]\033[0m"
