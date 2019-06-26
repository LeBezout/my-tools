#!/bin/bash

readonly ARCHIVE_NAME="shellcheck-stable.linux.x86_64.tar.xz"
readonly ARCHIVE_URL="https://storage.googleapis.com/shellcheck/${ARCHIVE_NAME}"

echo "Downloading binary ..."
if ! curl --fail --location "${ARCHIVE_URL}" --remote-name
then
  echo "Fail to download binary !" 1>&2;
  exit 1
fi

echo "Extracting archive ..."
if ! tar -xJf "${ARCHIVE_NAME}"
then
  echo "Fail to extract archive !" 1>&2;
  exit 1
fi

if ! rm -f "${ARCHIVE_NAME}"
then
  echo "Fail to delete archive !" 1>&2;
fi

readonly EXTRACT_DIR=./shellcheck-stable
if ! -f "${EXTRACT_DIR}/shellcheck"
then
  echo "shellcheck binary not found !" 1>&2;
  exit 1
fi

# Copie du man
#sudo mv shellcheck-stable/shellcheck.1 /usr/share/man/man1

# Copie du binaire dans /usr/bin/
if ! sudo cp "${EXTRACT_DIR}/shellcheck" /usr/bin/
then
  echo "Fail to copy shellcheck binary in /usr/bin/ !" 1>&2;
  exit 1
fi

# suppression du dossier
if ! rm --force --recursive "${EXTRACT_DIR}"
then
  echo "Fail to delete ${EXTRACT_DIR} !" 1>&2;
  exit 1
fi

# OK
shellcheck --version
