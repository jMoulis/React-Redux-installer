# React-Redux-installer (For Unix)

Small script for lazy react dev:

Comes with following modules:
React, Redux,Router, Axios, Babel, Brunch, Eslint and friends.

And a installerComponent already copied in your app folder (Don't forget to set as executable ``` chmod +x installComponent.sh ```, and then execute it with ``` ./installComponent.sh ```, but if needed you have the file in the repo

Here are the tools that you'll need:
1. Node - npm
2. yarn 
3. Brunch
4. Git
5. Optional: Atom

#### Install process

The lazy way:
  Copy the scrit into your root folder
  Make sure the script is executable by running in the terminal: ``` chmod +x installer.sh ```
  Then run command: ``` ./installer.sh ```
  And follow the installation

You can also copy the file to your /usr/local/bin then you'll be able to run the script from anywhere. (I'm not sure if it is a best practice)


#### Script

Don't forget to insert into your package.json the following scripts, if you want cli shorcut
```json
"scripts": {
    "start:node": "node server/index.js",
    "start:brunch": "brunch watch",
    "save-deps": "rm -rf node_modules && npm update --save && npm update --save-dev",
    "lint": "eslint --fix app",
    "test": "mocha tests/.setup.js tests/**/*.test.js",
    "test:watch": "mocha --watch tests/.setup.js tests/**/*.test.js",
    "test:one": "mocha --watch tests/.setup.js $1"
  }
  ```
I'm a newbee so the script is really simple and probably holds a lot off error, so feel free to make it better :-)
