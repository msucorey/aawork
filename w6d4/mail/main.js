const Inbox = require("./inbox.js");
const Router = require("./router.js");

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
