#!/usr/bin/env bash
#
# SCRIPT: run docker
# AUTHOR: Davide Isoardi
# DATE:   20210310
# REV:    1.0.A (Valid are A, B, D, T, Q, and P)
#               (For Alpha, Beta, Dev, Test, QA, and Production)
#
# PLATFORM: Linux
#
# REQUIREMENTS: docker
#
# PURPOSE: Run cdp-cli docker image
#
# REV LIST:
#        DATE: DATE_of_REVISION
#        BY:   AUTHOR_of_MODIFICATION
#        MODIFICATION: Describe what was modified, new features, etc--
#
#
# set -n   # Uncomment to check script syntax, without execution.
#          # NOTE: Do not forget to put the # comment back in or
#          #       the shell script will never execute!
# set -x   # Uncomment to debug this shell script
#
##########################################################
#         DEFINE FILES AND VARIABLES HERE
##########################################################

THIS_SCRIPT=$(basename $0)
THIS_SCRIPT_PATH=$(dirname $0)

IMAGE_NAME='cdp-cli'
IMAGE_TAG='1.0.P'

##########################################################
#              DEFINE FUNCTIONS HERE
##########################################################

###### method usage ######
usage() {
    echo -e "Usage:\n $0 [-i|--image-name] [-t|--tag] [-s|--script]\n 
$0 -i ${IMAGE_NAME} -t ${IMAGE_TAG} -s `pwd`
\nOptions:\n \
-i, --image-name\t\tThe name of the image\n \
-d, --tag\t\tTag for image\n \
-s, --script\t\tLocal path to the script direcotry, mount in home of the running container" 2>&1 ; exit 1
}

###### parsing command argument ######
parse_argument() {
    # Parse all argument mapped with getops; in this example 


    OPTS=`getopt -o hi:-t:-s: -l help,image-name:,tag:,script: -- "$@"`


    eval set -- "$OPTS"

    while true; do
        case "$1" in
            -h | --help)
                usage
                ;;
            -i | --image-name)
                IMAGE_NAME=$2
                shift 2
                ;;
            -t | --tag)
                IMAGE_TAG=${2:=DEATCH}
                shift 2
                ;;
            -s | --script)
                SCRIPT_PATH=${2:=DEATCH}
                shift 2
                ;;
            --) shift;  break
                ;;
            *)  break
                ;;
        esac
    done

    if [ -z "$IMAGE_NAME" ] || [ -z "$IMAGE_TAG" ] || [ -z "$SCRIPT_PATH" ]; then
        echo $OPTS
        echo "-i" ${IMAGE_NAME}
        echo "-t" ${IMAGE_TAG}
        echo "-s" ${SCRIPT_PATH}
        usage
        exit 1
    fi
}

##########################################################
#               BEGINNING OF MAIN
##########################################################

parse_argument $@

echo -e "Running ${IMAGE_NAME}:${IMAGE_TAG}"

docker run --rm -ti -v ~/.cdp:/root/.cdp -v ${SCRIPT_PATH}:/root/ --name=cdp-cli ${IMAGE_NAME}:${IMAGE_TAG} bash

# End of script
