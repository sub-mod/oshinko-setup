#!/usr/bin/env bash
oc login -u system:admin > /dev/null
oc project default > /dev/null 2>&1

REGISTRY=$(oc get service docker-registry --no-headers=true | awk -F ' ' '{print $2":"$4}' | sed "s,/TCP$,,")

WEBROUTEIP=$1
TEMPLATE=$2

oc login -u oshinko -p oshinko
oc project oshinko

oc process -f $2 \
OSHINKO_SERVER_IMAGE=$REGISTRY/oshinko/oshinko-rest \
OSHINKO_WEB_ROUTE_HOSTNAME=mywebui.$WEBROUTEIP.xip.io > oshinko-template.json
oc create -f oshinko-template.json

oc new-app oshinko

REST_SERVICE=`oc get svc | grep oshinko-rest | cut -d' ' -f1`

oc expose service $REST_SERVICE --hostname=oshinko-rest.$WEBROUTEIP.xip.io




----
#!/usr/bin/env bash

WEBROUTEIP=$1
oc login -u oshinko -p oshinko
oc project oshinko
oc create sa oshinko
oc policy add-role-to-user admin -z oshinko






curl https://gist.githubusercontent.com/sub-mod/725b96c80e736f5f799ca296c9fab95d/raw/019a099dd7dfb8cc9b54e2c06d69a3cb0cc40204/oashinko.yaml  | oc create -f -

oc new-app oshinko


REST_SERVICE=`oc get svc | grep oshinko-rest | cut -d' ' -f1`

oc expose service $REST_SERVICE --hostname=oshinko-rest.$WEBROUTEIP.xip.io