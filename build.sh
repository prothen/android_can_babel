#!/usr/bin/env bash
#
#
# Author: Philipp Rothenhäusler, Stockholm 2020
#

APP_DIR=/home/flip/workspaces/sml/rcve_ui

cwd="$(readlink -m "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd )")"

if [ -z "$(command -v mvn)" ]; then
    sudo apt install -y mvn
fi

echo "[x] Maven installation has been found."
echo "Building CANBabel.jar ..."
cd $cwd/external/canbabel && mvn clean install
echo "[x] Maven installation has been found."
echo "Installing CANBabel.jar ..."
mkdir -p ${APP_DIR}/app/libs
mv target/CANBabel-2.1-jar-with-dependencies.jar ${APP_DIR}/app/libs/CANBabel.jar
echo "[x] Maven installation successfull. Ensure that dependencies to app/libs have been defined."
