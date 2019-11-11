#!/bin/bash -eu

pushd govmomi/govc

echo "Building for Linux..."
GOOS=linux GOARCH=amd64 go build
mv govc ../../release/govc_linux_amd64

echo "Building for OS X..."
GOOS=darwin GOARCH=amd64 go build
mv govc ../../release/govc_darwin_amd64

popd

echo "govmomi" > release/name
if [ "${DRAFT}" == "true" ]; then
  COMMIT_HASH=$(cat govmomi/.git/ref)
  echo "$(cat version/version | sed 's/-.*//')-${COMMIT_HASH}" > release/tag
fi
