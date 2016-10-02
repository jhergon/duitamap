#!/usr/bin/env bash

# Travis was configured to push in the remote repository.

BRANCH=master
TARGET_REPO=jhergon/jhergon.github.io.git
PELICAN_OUTPUT_FOLDER=output

echo -e "Building DuitaMap"
echo -e "$VARNAME"

if [ "$TRAVIS_PULL_REQUEST" == "false" ]; then
    echo -e "Starting to deploy to Github Pages\n"
    if [ "$TRAVIS" == "true" ]; then
        git config --global user.email "contacto@bogomap.co"
        git config --global user.name "BogoMap"
    fi
    # Using token clone gh-pages branch
    git clone --quiet --branch=$BRANCH https://${GH_TOKEN}@github.com/$TARGET_REPO built_website > /dev/null
    # Go into directory and copy data we're interested in to that directory
    cd built_website
    git rm -rf *
    # Add, commit and push files
    git add -f .
    git commit -a -m "Travis build $TRAVIS_BUILD_NUMBER pushed to Github Pages"
    git push -fq origin $BRANCH > /dev/null
    echo -e "Deploy completed\n"
fi

