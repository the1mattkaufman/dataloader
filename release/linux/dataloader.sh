#!/bin/bash
DATALOADER_VERSION="@@FULL_VERSION@@"
DATALOADER_SHORT_VERSION=$(echo ${DATALOADER_VERSION} | cut -d'.' -f 1)
DATALOADER_UBER_JAR_NAME="dataloader-${DATALOADER_VERSION}-uber.jar"
MIN_JAVA_VERSION=@@MIN_JAVA_VERSION@@

echo ""
echo "*************************************************************************"
echo "**            ___  ____ ___ ____   _    ____ ____ ___  ____ ____       **"
echo "**            |  \ |__|  |  |__|   |    |  | |__| |  \ |___ |__/       **"
echo "**            |__/ |  |  |  |  |   |___ |__| |  | |__/ |___ |  \       **"
echo "**                                                                     **"
echo "**  Data Loader v${DATALOADER_SHORT_VERSION} is a Salesforce supported Open Source project to   **"
echo "**  help you import data to and export data from your Salesforce org.  **"
echo "**  It requires Java JRE ${MIN_JAVA_VERSION} or later to run.                           **"
echo "**                                                                     **"
echo "**  Github Project Url:                                                **"
echo "**       https://github.com/forcedotcom/dataloader                     **"
echo "**  Salesforce Documentation:                                          **"
echo "**       https://help.salesforce.com/articleView?id=data_loader.htm    **"
echo "**                                                                     **"
echo "*************************************************************************"
echo ""

if [ ! -z "${DATALOADER_JAVA_HOME}" ]
then
    JAVA_HOME=${DATALOADER_JAVA_HOME}
    PATH=${JAVA_HOME}/bin:${PATH}
fi

JAVA_VERSION=$(java -version 2>&1 | grep -i version | cut -d'"' -f 2 | cut -d'.' -f 1)

if [ -z "${JAVA_VERSION}" ] | [ ${JAVA_VERSION} \< ${MIN_JAVA_VERSION} ]
then
    echo "Java JRE ${MIN_JAVA_VERSION} or later is not installed. For example, download and install Zulu OpenJDK ${MIN_JAVA_VERSION} or later JRE from https://www.azul.com/downloads/zulu/zulu-mac/"
else
    cd `dirname $0`
    java -jar ${DATALOADER_UBER_JAR_NAME} $@
fi
