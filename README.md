# **Auto Healing Test를 위한 사전 환경 셋팅**

<br>

## **Guide 진행 절차**
> **Auto Healing 동작을 확인하기 위한 Sample Application 배포 및 설정에 대한 가이드 입니다. **

<br>

1. Sample Application은 다음 git source를 기반으로 S2I한 이미지를 사용합니다. 
   - https://github.com/barracuda0704/sample-source.git

2. 배포는 기본 제공되는 템플릿을 사용하여 배포합니다. 
   - eap73-basic-s2i

3. 다음 shell를 통해 배포 합니다. 

```bash
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
```

<br>

배포된 환경에서 명령어 혹은 Web Console을 통해 Auto Healing Test를 수행합니다. 
