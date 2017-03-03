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
