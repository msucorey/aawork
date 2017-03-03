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

const DOMNodeCollection = __webpack_require__(1);

function $l(selectors) {
  let qdFns = [];
  if (typeof selectors === "function") {
    qdFns.unshift(selectors);
    if (document.readyState === "complete") {
      for (var i = 0; i < qdFns.length; i++) {
        qdFns[i].call();
      }
    }
  }
  if (selectors instanceof HTMLElement) {
    return new DOMNodeCollection([selectors]);
  }
  let nodeList = document.querySelectorAll(selectors);
  let nodeArr = [];
  for (i = 0; i < nodeList.length; i++) {
    nodeArr.push(nodeList[i]);
  }
  let result = new DOMNodeCollection(nodeArr);
  return result;

  function extend(...objs) {
    let newObj = {};
    for (i = 0; i < objs.length; i++) {
      for (var j = 0; j < objs[i].keys().length; i++) {
        if (!newObj.keys().includes(objs[i].keys()[j])) {
          newObj[objs[i].keys()[j]] = objs[i][objs[i].keys()[j]];
        }
      }
    }
    return newObj;
  }

  function ajax(options) {
    let defaults = {
      success: () => console.log("success"),
      error: () => console.log("error"),
      url: "localhost:3000",
      method: "GET",
      data: null,
      contentType: "JSON",
    };
    for (var i = 0; i < defaults.keys().length; i++) {
      if (!options.keys().includes(defaults.keys()[i])) {
        options[defaults.keys()[i]] = defaults[defaults.keys()[i]];
      }
    }
    //step 1 - create xhr object
    const xhr = new XMLHttpRequest();
    // step 2 - specify path and verb
    xhr.open(options["method"], options["url"]);
    // step 3 - register a callback
    xhr.onload = function () {
      console.log(xhr.status); // for status info
      console.log(xhr.responseType); //the type of data that was returned
      console.log(xhr.response); //the actual response. For json api calls, this will be a json string
    }
    // step 4 - send off the request with optional data
    const optionalData = options["data"];
    xhr.send(optionalData);
  }
}

window.$l = $l;

// Add an ajax function to the $l function object. It should receive one
// options object argument.
// It will help to know what you expect the behavior to be.
// Reference a sample ajax request to know what your inputs are and when
// you expect functions to run.
// Your ajax function does not have to return a Promise. We'll implement
// that in the bonus.
// Test out your $l.ajax code using the same endpoint as the sample
// request.
// Make a defaults object. Check the jQuery ajax API document to get a
// sense of what the defaults should be. Provide defaults for success,
// error, url, method, data, and contentType.
// Merge the options onto the defaults
// Review this reading to learn how to implement an AJAX request using
// the native JavaScript API. It's actually quite easy!
// Using the options supplied by the user, make the request. Be sure to
// deliver the proper response to the success/error callback. This
// response should be an object (use JSON.parse) and not a string.

// Let's implement a super simple function to merge JavaScript objects.
// The arguments will be two or more objects.
// For example:
// const objA = {a: 'a', b: 'a', c: 'a'};
// const objB = {b: 'b', c: 'b'};
// const objC = {c: 'c'};
// $l.extend(objA, objB, objC); //=> {a: 'a', b: 'b', c: 'c'}
// objA //=> {a: 'a', b: 'b', c: 'c'}
// // For this phase of the project we will be adding this functionality to
// // our core $l function. We will need to change the code inside of our
// // main function, the one we used to create an instance of
// // DomNodeCollection.
// // Change the $l function so that if it receives a function, it will push
// // that function into an array (queue) of functions to be executed when
// // the document is ready.
// // If the document is already ready, trigger the function immediately.
// // See if you can find a way (using your Google skillz) to check if the
// // document is ready using Vanilla JavaScript. There are some VERY simple
// // solutions.
// // Once the document has become ready, trigger all your callbacks!

// We are now going to modify the core $l function. It will recieve one
// argument, but let's make it flexible.
// If the argument received is a HTML element, (i.e. an instanceof
//   HTMLElement), you should put it into an array and return an instance
//   of DOMNodeCollection.
// This will allow a HTMLElement native element to be 'wrapped' in jQuery
// lite goodness.
// So: our core function can receive either a single HTMLElement or a
// string with a CSS selector and in either case the return value will be
// a DOMNodeCollection.


/***/ }),
/* 1 */
/***/ (function(module, exports) {

class DOMNodeCollection {
  constructor(htmlElements) {
    this.htmlElements = htmlElements;
  }

  // Let's write the method html first. It can optionally receive a string
  // as a parameter.
  // If it receives an argument, this will become the innerHTML (hint hint)
  // of the each of the nodes. If it does not receive an argument, it
  // should return the innerHTML of the first node in the array.
  html(string = "") {
    if (string === "") {
      return this.htmlElements[0].innerHTML;
    } else {
      for (var i = 0; i < this.htmlElements.length; i++) {
        this.htmlElements[i].innerHTML = string;
      }
    }
  }

  // This method clears out the content of all nodes in the internal array.
  // I set the html of all nodes to an empty string.
  empty() {
    for (var i = 0; i < this.htmlElements.length; i++) {
      this.htmlElements[i].innerHTML = "";
    }
  }

  // Take a look here. This method should accept either a jQuery-lite
  // wrapped collection, an HTML element, or a string. Append the outerHTML
  // of each element in the argument to the innerHTML of each element in
  // the DOMNodeCollection. Don't worry about converting strings into HTML
  // elements; just pass them straight through to the elements' innerHTML.
  append(item) {
    if (typeof item === 'string') {
      let appendage = item;
    } else {
      let appendage = item.outerHTML;
    }
    for (var i = 0; i < this.htmlElements.length; i++) {
      this.htmlElements[i].innerHTML += item.outerHTML;
    }
  }
  // attr, addClass, and removeClass
  attr(arg, ass) {
    if (ass) {
      for (var i = 0; i < this.htmlElements.length; i++) {
        this.htmlElements[i].setAttribute(arg, ass);
      }
    } else {
      let result = [];
      for (i = 0; i < this.htmlElements.length; i++) {
        result.push(this.htmlElements[i].getAttribute(arg));
      }
      return result;
    }
  }

  addClass(newClass) {
    for (var i = 0; i < this.htmlElements.length; i++) {
      this.htmlElements[i].className += newClass;
    }
  }

  removeClass(delClass) {
    for (var i = 0; i < this.htmlElements.length; i++) {
      this.htmlElements[i].classList.remove(delClass);
    }
  }

  // Return a DOMNodeCollection of the parents of each of the nodes
  parent() {
    let result = [];
    for (var i = 0; i < this.htmlElements.length; i++) {
      result.push(this.htmlElements[i].parentElement);
    }
    return new DOMNodeCollection(result);
  }

  // Returns a DOMNodeCollection of all the nodes matching the selector
  // passed in as an argument that are descendants of the nodes. This
  // might come in handy.
  find(selector) {
    let result = [];
    for (var i = 0; i < this.htmlElements.length; i++) {
      result.concat(this.htmlElements[i].querySelectorAll(selector));
    }
    return new DOMNodeCollection(result);
  }

  // This should remove the html of all the nodes in the array from the
  // DOM.  It should also remove all nodes from the array.
  remove() {
    for (var i = 0; i < this.htmlElements.length; i++) {
      this.htmlElements[i].parent.removeChild(this.htmlElements[i]);
    }
    this.htmlElements = [];
  }

  on(action, callback) {
    for (var i = 0; i < this.htmlElements.length; i++) {
      this.htmlElements[i].addEventListener(action, callback, false);
      if (this.htmlElements[i].actions) {
        this.htmlElements[i].actions[action] = callback;
      } else {
        this.htmlElements[i].actions = {action: callback};
      }
    }
  }

  off(action) {
    let callback = this.htmlElements[0].actions[action];
    for (var i = 0; i < this.htmlElements.length; i++) {
      this.htmlElements[i].removeEventListener(action, callback);
    }
  }
}

module.exports = DOMNodeCollection;


/***/ })
/******/ ]);