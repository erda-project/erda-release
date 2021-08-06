#!/bin/bash
set -eo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")"

rm -rf package
mkdir package

rm -rf erda/scripts/erda-actions
git clone https://github.com/erda-project/erda-actions.git erda/scripts/erda-actions
rm -rf erda/scripts/erda-actions/.git

rm -rf erda/scripts/erda-addons
git clone https://github.com/erda-project/erda-addons.git erda/scripts/erda-addons
rm -rf erda/scripts/erda-addons/.git

if [[ -z $ERDA_VERSION ]]; then
    echo "ERDA_VERSION is empty"
    exit
fi

echo "${ERDA_VERSION}" > erda/VERSION

# ERDA_OS_SYSTEM: Currently only supports linux.
if [[ -z $ERDA_OS_SYSTEM ]]; then
    echo "ERDA_OS_SYSTEM is empty"
    exit
fi

rm -rf erda/How-to-install-Erda.md
rm -rf erda/How-to-install-Erda-zh.md
wget https://raw.githubusercontent.com/erda-project/erda/v${ERDA_VERSION}/docs/guides/deploy/How-to-install-Erda.md -O erda/How-to-install-Erda.md
wget https://raw.githubusercontent.com/erda-project/erda/v${ERDA_VERSION}/docs/guides/deploy/How-to-install-Erda-zh.md -O erda/How-to-install-Erda-zh.md

# install third_party_packages
rm -fr erda/third_party_package
mkdir -p erda/third_party_package

if [[ $ERDA_OS_SYSTEM == "linux" ]]; then
    wget https://github.com/reconquest/orgalorg/releases/download/1.0.1/orgalorg_1.0.1_linux_amd64.tar.gz -O erda/third_party_package/orgalorg_1.0.1_linux_amd64.tar.gz
    tar -cvzf package/erda-${ERDA_OS_SYSTEM}.tar.gz erda/
fi
