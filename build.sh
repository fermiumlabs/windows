#!/bin/bash

VIRTUALBOX_S3_BUCKET="s3://fermiumlabs-vagrant-boxes/virtualbox/"
export VIRTUALBOX_S3_BUCKET
VMWARE_S3_BUCKET="s3://fermiumlabs-vagrant-boxes/vmware/"
export VMWARE_S3_BUCKET
PARALLELS_S3_BUCKET="s3://fermiumlabs-vagrant-boxes/parallels/"
export PARALLELS_S3_BUCKET

export HEADLESS=true

make list | grep eval | while read -r image; do
	echo "building $image for virtualbox"
	make virtualbox/$image || true
	aws s3 sync box/virtualbox/  $VIRTUALBOX_S3_BUCKET || true
	#aws s3 sync box/vmware/ $VMWARE_S3_BUCKET || true
	#aws s3 sync box/parallels/  $PARALLELS_S3_BUCKET || true
	make clean || true;
done

