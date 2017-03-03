const DOMNodeCollection = require('./dom_node_collection.js');

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
