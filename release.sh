#! /bin/bash

set -u
set -e

VERSION="$1"

py.test-2.7
py.test-3.3

if [[ -n $(hg diff) ]]; then
    echo "Error: repo has uncomitted changes"
    exit 1
fi

# Bump version.
sed -i -e "s/__version__ = '.*'/__version__ = '$VERSION'/" wake.py
hg commit -m "Update version number to $VERSION for release."
hg tag "v$VERSION"

python setup.py register
python setup.py sdist upload
