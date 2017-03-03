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
