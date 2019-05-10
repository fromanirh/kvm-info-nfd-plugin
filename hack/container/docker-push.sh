#!/bin/bash

set -e

VERSION="${1:-devel}"

if [ -z "$QUAY_BOT_PASS" ] || [ -z "$QUAY_BOT_USER" ]; then
	echo "missing QUAY_BOT_{USER,PASS} env vars"
	exit 1
fi

echo "$QUAY_BOT_PASS" | docker login -u="$QUAY_BOT_USER" --password-stdin quay.io
docker build -t quay.io/fromani/kvm-info-nfd-plugin:$VERSION .
docker push quay.io/fromani/kvm-info-nfd-plugin:$VERSION
docker logout quay.io
