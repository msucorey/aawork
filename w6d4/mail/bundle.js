/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};

/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {

/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId])
/******/ 			return installedModules[moduleId].exports;

/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};

/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);

/******/ 		// Flag the module as loaded
/******/ 		module.l = true;

/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}


/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;

/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;

/******/ 	// identity function for calling harmony imports with the correct context
/******/ 	__webpack_require__.i = function(value) { return value; };

/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, {
/******/ 				configurable: false,
/******/ 				enumerable: true,
/******/ 				get: getter
/******/ 			});
/******/ 		}
/******/ 	};

/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};

/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };

/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";

/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ (function(module, exports, __webpack_require__) {

const Inbox = __webpack_require__(2);
const Router = __webpack_require__(1);

document.addEventListener("DOMContentLoaded", function(event) {
  console.log("loaded!!!!");
  let contentNode = document.querySelector(".content");
  let router = new Router(contentNode, routes);
  router.start();
  let sidebarNavs = document.querySelectorAll(".sidebar-nav li");
  for (var i = 0; i < sidebarNavs.length; i++) {
    let text = sidebarNavs[i].innerText;
    sidebarNavs[i].addEventListener("click", () => {
      window.location.hash = text.toLowerCase();
      router.render();
    });
  }
});

const routes = {
  inbox: Inbox
};

// Create the routes
// Create an object called routes. You don't need to create this inside
// the DOMContentLoaded callback. We could theoretically load this in
// from another file, but our routes will be simple enough to include in
// main.js.
// We are going to format this object so that its properties will be the
// names of routes, i.e. compose, inbox, and sent.
// For now just create one route by setting an inbox property with a
// value of the Inbox component (Make sure you require the Inbox module).

// Modify the DOMContentLoaded callback:
// Get the .content DOM Node with document.querySelector. This is DOM
// Node we'll be updating with the Router.
// Create a new Router, passing in the .content node.
// start() your new router.

// Use the WebAPI (i.e. vanilla DOM method) to add an event listener for
// DOMContentLoaded.
// In the callback, add an click event listener for each .sidebar-nav li
// that does the following:
// Gets the innerText of the element; this will be our new location.
// Call toLowerCase on the name to make sure there aren't case differences.
// Set window.location.hash to the lower-cased location name.
// Test that clicking on your sidebar items:
// Changes the hash fragment in the URL.
// Doesn't make a new request. You can do this easily by setting a
// variable in the console in the Dev Tools. If it is still defined after
// clicking the sidebar element, you have not made a new request.


/***/ }),
/* 1 */
/***/ (function(module, exports) {

function Router(node, routes) {

  console.log("initializing a new router!");
  let thisNode = node;
  this.routes = routes;

  this.start = function() {
    this.render();
    thisNode.addEventListener("hashchange", this.render());
  };

  this.render = function() {
    console.log("calling render");
    node.innerHTML = "";
    let newNode = document.createElement("p");
    newNode.innerHTML = this.activeRoute();
    thisNode.appendChild(newNode);
  };

  this.activeRoute = function() {
    console.log("calling activeRoute");
    let fullRouteName = window.location.hash;
    return fullRouteName.slice(1);
  };
}

module.exports = Router;

// start
// Add an event listener for hashchange and call render in the callback
// This will make the Router update the DOM every time the hash fragment
// changes.
// Immediately call render upon start() so that if someone opens a link
// to a URL with a hash fragment, or if they refresh with a hash
// fragment, the router will still update the DOM.
// render -
// This function will update the DOM by changing the content of
// this.node.
// Clear this.node using innerHTML = "". This will remove anything left
// over from a previous route.
// Call this.activeRoute() to get the name of the current route. We will
// write this function soon.
// Create a new <p> DOM Node using document.createElement to display the
// new route name that is being inserted into the DOM.
// Set the innerHTML of the new DOM Node to the route name returned from
// this.activeRoute.
// Insert the new DOM Node into this.node with appendChild
// activeRoute -
//This function will initially just return the name of the
// currently active route.
// Get the hash fragment using window.location.hash.
// Remove the # character.
// Return the result.


/***/ }),
/* 2 */
/***/ (function(module, exports) {

const Inbox = function() {

  this.render = function() {
    let container = document.createElement("ul");
    container.className = "messages";
    container.innerHTML = "An Inbox Message";
    return container;
  };
};

module.exports = Inbox;

// Create an Inbox.js file that will export our Inbox component.
// The Inbox component should be a JavaScript object.
// Create a property on the Inbox called render that is a function that
// returns a DOM Node.
// In render, create a container <ul> DOM Node using
// document.createElement.
// Set the class name of the container to messages using the className
// property. This puts our CSS styles onto the node.
// For now, set the innerHTML of the container to "An Inbox Message" so
// we can test that the component works.
// Return the <ul> container.


/***/ })
/******/ ]);