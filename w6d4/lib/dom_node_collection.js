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
