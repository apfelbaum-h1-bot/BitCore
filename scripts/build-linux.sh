#!/usr/bin/env bash
# BitCore dev_7 — Linux-Build auf Ubuntu 26.04 (GCC 15 / Boost 1.90)
# Verwendung: ./build-linux.sh [--with-wallet]
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SHIM="$ROOT/scripts/boost_placeholders_compat.h"

CONF_FLAGS=(--with-gui=no --disable-bench --without-miniupnpc --without-qrencode --disable-valgrind)
if [[ "${1:-}" == "--with-wallet" ]]; then
  CONF_FLAGS+=(--with-incompatible-bdb)   # BDB 5.3 statt 4.8: Wallet nicht binär-portabel, funktional aber ok
else
  CONF_FLAGS+=(--disable-wallet)
fi

cd "$ROOT/repo"
[ -f configure ] || ./autogen.sh --skip-ldconfig

mkdir -p "$ROOT/build" && cd "$ROOT/build"
"$ROOT/repo/configure" "${CONF_FLAGS[@]}"
make -j"$(nproc)" CXXFLAGS="-O2 -include $SHIM"

mkdir -p "$ROOT/dist/linux"
cp -v src/bitcored src/bitcore-cli "$ROOT/dist/linux/"
echo "Fertig: $ROOT/dist/linux/"
