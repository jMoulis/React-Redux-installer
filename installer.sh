#!/bin/bash
# Installer for linux:

# Abort Function
function finish() {
tput setaf 2;
tput bold;
echo "
Bye bye! If needed, don't forget to delete the created folders"
exit 1;
}
trap finish SIGINT

tput setaf 2;
tput bold;
echo "Hello people! Welcome to my lazy brunch babel react react-redux installer";
tput sgr0;

# Check dependencies node and yarn and brunch
# Check Npm
command -v npm >/dev/null 2>&1 || {
tput setaf 1;
tput bold;
echo >&2 "I require npm but it's not installed. https://nodejs.org/en/download/  Aborting.";
tput sgr0;
exit 1;
}
# Check yarn
command -v yarn >/dev/null 2>&1 || {
tput setaf 1;
tput bold;
echo >&2 "I require yarn but it's not installed. https://yarnpkg.com/en/docs/install Aborting.";
tput sgr0;
exit 1;
}
# Check Brunch
command -v brunch >/dev/null 2>&1 || {
tput setaf 1;
tput bold;
echo >&2 "I require Brunch but it's not installed. yarn add brunch Aborting.";
tput sgr0;
exit 1;
}

# Check Git
command -v git >/dev/null 2>&1 || {
tput setaf 1;
tput bold;
echo >&2 "I require Brunch but it's not installed. yarn add git Aborting.";
tput sgr0;
exit 1;
}

# Create App
function createAppFolder() {
tput bold;
read -p "Enter Application Name: " appName
mkdir $appName
}

createAppFolder

while [[ $? -ne 0 ]]; do
tput setaf 1;
tput bold;
echo "Reminder: your app's name is a folder name and has to be unique,
Please choose another app name";
tput sgr0;
createAppFolder
done

# Create tree folder (based on brunch - react-redux)
# Architecture example:
# app/
# app/assets
# app/src
# app/src/components
# app/src/containers
# app/src/store
# app/styles
#########
mkdir $appName/app


# app/assets Folder
# Create folder and index.html
mkdir $appName/app/assets
# IndexHtml default
echo "<!DOCTYPE html>
<html>
	<head>
		<meta charset=\"utf-8\" />
		<meta name=\"viewport\" content=\"width=device-width,initial-scale=1\" />
		<title>$appName</title>
		<link rel=\"stylesheet\" href=\"css/app.css\" />
	</head>
	<body>
		<div id=\"root\"></div>
		<script src=\"js/app.js\"></script>
		<script>require('src/index');</script>
	</body>
</html>" > $appName/app/assets/index.html


#### Create SRC Folder and content #######
# app/src Folder
mkdir $appName/app/src

# Create root index.js
echo "/*
 * Npm import
 */
import 'babel-polyfill';
import React from 'react';
import { render } from 'react-dom';
import { Provider } from 'react-redux';


/*
 * Local import
 */
import App from 'src/components/App';
import store from 'src/store';

/*
 * Code
 */
document.addEventListener('DOMContentLoaded', () => {
  const provider = (
    <Provider store={store}>
      <App />
    </Provider>
  );
  render(provider, document.getElementById('root'));
});" > $appName/app/src/index.js

mkdir $appName/app/src/components

################################################
# Create Default component                     #
################################################

# Create folder app
mkdir $appName/app/src/components/App

## Create default app index.js
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

const App = () => (
  <div id=\"app\">
    <h1 id=\"app-hello\">Hello World</h1>
  </div>
);

/* Standard propTypes declaration structure
 *
 * App.propTypes = {
 * item: PropTypes.string.isRequired,
 * };
 */


/*
 * Export Default
 */
export default App;
" > $appName/app/src/components/App/index.js

##############################################
# Create Containers folder                 ###
##############################################
mkdir $appName/app/src/containers

##############################################
# Create store folder and content           ##
##############################################

# Create folder
mkdir $appName/app/src/store

# Create index store
echo "/*
 * Npm import
*/
import { createStore } from 'redux';

/*
 * Local Import
*/
import reducer from './reducer';

/*
 * Code
*/
// DevTools
let devTools;
if (window.devToolsExtension) {
  devTools = window.devToolsExtension();
}
const store = createStore(reducer, devTools);

/*
 * Export default
*/
export default store;
"> $appName/app/src/store/index.js

# Create main reducer store
echo "/*
 * Npm Import
 */

/*
 * Local Import
 */

/*
 * Types
 */
const HELLO_WORLD = 'HELLO_WORLD';

/*
 * State
*/
const initialState = {
  value: 'default',
};

/*
 * Reducer
 */
const reducer = (state = initialState, action = {}) => {
  switch (action.type) {
		case HELLO_WORLD:
			console.log('Hello World');

    default:
      return state;
  }
};

/*
 *Action creators
 */
export const defaultAction = () => ({
	type: HELLO_WORLD,
})

/*
 * Export default
*/
export default reducer;
"> $appName/app/src/store/reducer.js

#################################################
# Create styles folders and contents          ###
#################################################

# Create syle folder
mkdir $appName/app/styles

# OPTIONS:

tput setaf 2;
tput bold;
echo 'Options'
tput sgr0;
# Create reset.css
function getResetCss() {
reset=`wget -P $appName/app/styles/ 'http://meyerweb.com/eric/tools/css/reset/reset.css'`
if [[ $? -eq 0 ]]
then
tput setaf 2;
tput bold;
echo '
Reset downloaded successfully. So far so good.
'
tput sgr0;
else
tput setaf 1;
tput bold;
echo 'OUPS... A problem occurs while attempting to download the reset file. You can google it ;-)
http://meyerweb.com/eric/tools/css/reset/reset.css'
fi
tput sgr0;
}

tput bold;
read -p "Do you want to install a reset.css [y/n] ? " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
	getResetCss
fi
tput sgr0;

echo "
"
# Create style and stylintrc
tput bold;
read -p "Do you use stylus [y/n] ?" -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
tput bold;
tput setaf 2;
echo "
Stylus lintrc installed
"
tput sgr0;
# Stylintrc
echo '{
  "blocks": false,
  "brackets": "never",
  "colons": "always",
  "colors": "always",
  "commaSpace": "always",
  "commentSpace": "always",
  "cssLiteral": false,
  "depthLimit": 6,
  "duplicates": false,
  "efficient": "always",
  "exclude": ["vendor/**/*", "node_modules/**/*"],
  "extendPref": "@extends",
  "globalDupe": false,
  "indentPref": false,
  "leadingZero": false,
  "maxErrors": false,
  "maxWarnings": false,
  "mixed": true,
  "mixins": [],
  "namingConvention": "lowercase-dash",
  "namingConventionStrict": true,
  "none": "never",
  "noImportant": true,
  "parenSpace": false,
  "placeholders": "always",
  "prefixVarsWithDollar": "always",
  "quotePref": "double",
  "semicolons": "never",
  "sortOrder": false,
  "stackedProperties": "never",
  "trailingWhitespace": "never",
  "universal": false,
  "valid": true,
  "zeroUnits": "never",
  "zIndexNormalize": false
}' > $appName/.stylintrc


# Css default app
echo '/*
 * Colors
 */
$gray = #444

/*
 * App
 */
#app
	display: flex
	height: 100vh

	&-hello
		color: $gray
		font-size: 4em
		font-weight: 700
		text-align: center
		margin: auto' > $appName/app/src/components/App/app.styl

touch $appName/app/styles/style.styl
else
echo '/*
 * Colors
 */
$gray = #444

/*
 * App
 */
#app {
	display: flex;
	height: 100vh;
}
#app-hello {
	color: $gray;
	font-size: 4em;
	font-weight: 700;
	text-align: center;
	margin: auto;
}' > $appName/app/src/components/App/app.css
touch $appName/app/styles/style.css
fi

echo "
"

# Eslint Installation
tput bold;
read -p "Do you need esLint [y/n] ?" -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
tput setaf 2;
echo "
Done
"
tput sgr0;

echo '{
  "extends": "airbnb",
  "parser": "babel-eslint",
  "env": {
    "browser": true
  },
  "rules": {
    "brace-style": ["error", "stroustrup"],
    "no-param-reassign": ["error", { "props": false }],
    "no-mixed-operators": ["error", { "allowSamePrecedence": true }],
    "jsx-a11y/no-static-element-interactions": "off",
    "jsx-a11y/href-no-hash": "off",
    "react/jsx-filename-extension": "off",
    "react/forbid-prop-types": "off",
    "react/no-unescaped-entities": "off"
  },
  "settings": {
    "import/resolver": {
      "node": {
        "paths": ["app/"]
      }
    }
  }
}' > $appName/.eslintrc
fi

tput setaf 2;
tput bold;
echo "
General configurations
"
tput sgr0;
# Create Brunch config
echo "exports.config = {
  files: {
    stylesheets: {
      joinTo: 'css/app.css',
      order: {
        before: 'app/styles/css/app/reset.css',
      },
    },
    javascripts: {
      joinTo: 'js/app.js',
    },
  },
  plugins: {
    postcss: {
      processors: [require('autoprefixer')],
    },
    babel: {
      presets: ['env', 'react'],
      plugins: [
        'transform-object-rest-spread',
        'transform-class-properties',
      ],
    },
  },
};" > $appName/brunch-config.js

# Create Babel config
echo '{}' > $appName/.babelrc

# Create eslintIgnore
echo "
/public
/node_modules
/vendor
/brunch-config.js" > .eslintignore

tput setaf 2;
tput bold;
echo "
Yarn Installation starting, there u go
"
tput sgr0;

# Go to app folder and setup
cd $appName

yarn init
## DEV dependencies
# brunch
yarn add --dev auto-reload-brunch autoprefixer brunch postcss-brunch stylus-brunch
# Babel
yarn add --dev babel-brunch babel-eslint babel-plugin-transform-class-properties babel-plugin-transform-object-rest-spread babel-preset-env babel-preset-react
# ESLint
yarn add --dev eslint eslint-config-airbnb eslint-import-resolver-node eslint-plugin-import eslint-plugin-jsx-a11y eslint-plugin-react
# Test
yarn add --dev chai enzyme jsdom mocha
# React dev
yarn add --dev react-test-renderer

#Prod Dependencies
yarn add array-shuffle axios babel-polyfill body-parser classnames event-stream express prop-types react react-dom react-redux redux react-icons react-router-dom

installComponent= wget https://raw.githubusercontent.com/jMoulis/React-Redux-installer/master/installComponent.sh

tput setaf 2;
tput bold;
echo "
Installation done, have fun
"
tput sgr0;


####################################
# GIT Management ###################
####################################
tput bold;
read -p "Do you want to init git repo [y/n] ?" -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
# Git init
cd git init
# Create gitIgnore
echo "node_modules" > .gitignore
tput setaf 2;
echo "
Git done
"
fi
tput sgr0;
echo "
"
tput bold;
read -p "Do you want to start Atom [y/n] ?" -n 1 -r
echo "
"
if [[ $REPLY =~ ^[Yy]$ ]]
then
tput setaf 2;
echo "
Let's go to work, have good coding session
"
tput sgr0;
atom .
fi

tput bold;
read -p "Do you want to start the brunch server [y/n] ?" -n 1 -r
echo "
"y
if [[ $REPLY =~ ^[Yy]$ ]]
then
tput setaf 2;
echo "
Server Brunch started
"
tput sgr0;
brunch watch --server
fi
