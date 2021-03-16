#!/usr/bin/env bash
#
# SCRIPT: build docker
# AUTHOR: Davide Isoardi
# DATE:   20210310
# REV:    1.0.P (Valid are A, B, D, T, Q, and P)
#               (For Alpha, Beta, Dev, Test, QA, and Production)
#
# PLATFORM: Linux
#
# REQUIREMENTS: docker
#
# PURPOSE: Build docker image
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
    echo -e "Usage:\n $0 [-i|--image-name] [-t|--tag]\n 
$0 -i ${IMAGE_NAME} -t ${IMAGE_TAG}
\nOptions:\n \
-i, --image-name\t\tThe name of the image\n \
-d, --tag\t\tTag for image" 2>&1 ; exit 1
}

###### parsing command argument ######
parse_argument() {
    # Parse all argument mapped with getops; in this example 


    OPTS=`getopt -o hi:-t: -l help,image-name:,tag: -- "$@"`


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
            --) shift;  break
                ;;
            *)  break
                ;;
        esac
    done

    if [ -z "$IMAGE_NAME" ] || [ -z "$IMAGE_TAG" ] ; then
        echo $OPTS
        echo "-i" ${IMAGE_NAME}
        echo "-t" ${IMAGE_TAG}
        usage
        exit 1
    fi
}

##########################################################
#               BEGINNING OF MAIN
##########################################################


echo -e "Building ${IMAGE_NAME}:${IMAGE_TAG}"

docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .

# End of script
