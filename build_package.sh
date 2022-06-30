#!/bin/bash
set -eo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")"

rm -rf package release
mkdir package release

if [[ -z $ERDA_VERSION ]]; then
    echo "ERDA_VERSION is empty"
    exit
fi

echo "${ERDA_VERSION}" > release/VERSION

# install third_party_packages
mkdir -p release/third_party_package

wget https://github.com/reconquest/orgalorg/releases/download/1.0.1/orgalorg_1.0.1_linux_amd64.tar.gz -O release/third_party_package/orgalorg_1.0.1_linux_amd64.tar.gz

cp -r README.md release/README.md
cp -r charts release/charts
cp -r scripts release/scripts

tar -cvzf package/erda-linux.tar.gz release