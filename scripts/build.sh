#!/bin/bash

# Functions
function init {
	echo "Initializing git"
	mkdir _site
	cd _site
	git init
	// server is asking for password
	git remote add deploy "engineroom@199.58.81.155:/var/www/diig-malawi/"
	git config user.name "Travis CI"
	git config user.email "mayarichman@gmail.com"
	echo "Fetching from remote"
	git fetch deploy
	git checkout -b master
	cd ..
}

function build {
	echo "Building..."
	grunt build --verbose # Build with Grunt; see Gruntfile.js for more details.
	echo "Committing the build"
	cp -r dist/* _site/
	cp .htaccess _site/
	cp -r data/  _site/
	cd _site
	ls .
	git add -A
	git commit -m "Build #$TRAVIS_BUILD_NUMBER"
	cd ..
}

init
build
