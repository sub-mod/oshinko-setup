#!/usr/bin/env bash
oc login -u system:admin > /dev/null
oc project default > /dev/null 2>&1

REGISTRY=$(oc get service docker-registry --no-headers=true | awk -F ' ' '{print $2":"$4}' | sed "s,/TCP$,,")

WEBROUTEIP=$1
TEMPLATE=$2

oc login -u oshinko -p oshinko
oc new-project oshinko
oc create sa oshinko
oc policy add-role-to-user admin -z oshinko

oc process -f $2 \
OSHINKO_SERVER_IMAGE=submod/oshinko-rest1:latest \
OSHINKO_WEB_ROUTE_HOSTNAME=mywebui.$WEBROUTEIP.xip.io > oshinko-template.json
