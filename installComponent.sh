#!/bin/bash
# Installer for linux:

# Abort Function
function finish() {
	echo "
	Bye bye!"
	exit 1;
}
trap finish SIGINT

# Create Component
function createComponentFolder() {
tput bold;
read -p "Enter Component Name: " componentName

cd app/src

if [ ! -d "components" ]; then
	mkdir components
fi

cd ..
cd ..

mkdir app/src/components/$componentName
touch app/src/components/$componentName/$componentName.styl
echo "/*
 * Npm import
 */
import React from 'react';
import PropTypes from 'prop-types';

/*
 * Local import
 */


/*
 * Code
 */

const $componentName = () => (
  <div id=\"app\">
    <h1 id=\"app-hello\">Hello World</h1>
  </div>
);

/* Standard propTypes declaration structure
 *
 * $componentName.propTypes = {
 * item: PropTypes.string.isRequired,
 * };
 */


/*
 * Export Default
 */
export default $componentName;
" > app/src/components/$componentName/index.js
}

createComponentFolder

while [[ $? -ne 0 ]]; do
tput setaf 1;
tput bold;
echo "Reminder: your compopnent's name is a folder name and has to be unique,
Please choose another component name";
tput sgr0;
createComponentFolder
done

tput bold;
read -p "Do you want to create a container [y/n] ?" -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
cd app/src

if [ ! -d "containers" ]; then
	mkdir containers
fi

cd ..
cd ..
mkdir app/src/containers/$componentName
Container="Container"

echo "/*
 * Npm import
 */
import { connect } from 'react-redux';


/*
 * Local import
 */
import $componentName from 'src/components/$componentName';


/*
 * Code
 */
// State
const mapStateToProps = state => ({

});

// Actions
const mapDispatchToProps = dispatch => ({
  actions: {

  }
});


/*
 * Export default
 */
const createContainer = connect(mapStateToProps, mapDispatchToProps);
const "$componentName$Container" = createContainer($componentName);
export default $componentName$Container;
" > app/src/containers/$componentName/index.js
tput setaf 2;
fi
echo "
"
