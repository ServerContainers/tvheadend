#!/bin/sh

cat <<EOF
################################################################################

Welcome to the ghcr.io/servercontainers/tvheadend

################################################################################

You'll find this container sourcecode here:

    https://github.com/ServerContainers/tvheadend

The container repository will be updated regularly.

################################################################################


EOF

##
# CONTAINER GENERAL
##

# nothing needed...

##
# CMD
##
echo ">> CMD: exec docker CMD"
echo "$@"
exec "$@"
