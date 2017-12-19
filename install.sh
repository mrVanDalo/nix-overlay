#!/usr/bin/env bash


NAME=mrVanDalo-overlay.nix
OVERLAY_DIR=${HOME}/.config/nixpkgs/overlays

echo "Installing ${NAME} as an overlay to ${OVERLAY_DIR}"

set -x
set -e

cd "$(dirname "$0")" || exit
mkdir -p "${OVERLAY_DIR}"
ln -s "${PWD}/${NAME}" "${OVERLAY_DIR}/${NAME}"
