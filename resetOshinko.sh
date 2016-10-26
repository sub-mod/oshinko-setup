#!/usr/bin/env bash


oc login -u oshinko -p oshinko
oc project oshinko

oc delete sa oshinko
oc delete deploymentconfigs --all
oc delete services --all
oc delete rc --all
oc delete pods --all
oc delete routes --all
oc delete jobs --all
oc delete builds --all
oc delete templates --all

oc login -u system:admin
oc project default
oc delete project oshinko
oc delete ns oshinko
oc whoami
oc projects