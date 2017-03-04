import React from "react";
import ReactDOM from "react-dom";

class Tabs extends React.Component {
  constructor (props) {
    super(props);
    this.state = { index: 0 };
    this.tabsObjs = props.tabsObjs;
  }
  //this.setState({ index });
  render () {

    return () => (
      <ul>
        Header(this.tabsObjs, this.state)
        <article>{ this.tabsObjs[this.state.index]}</article>
      </ul>
    );
  }
}

class Header extends React.Component {

  constructor (props) {
    super(props);
  }

  render (tabsObjs, { index }) {

    const tabHeadings = tabsObjs.map((obj, i) => (
    <li key={`${obj.title}` + i}><h1 onClick={console.log("I GOT CLICKED!!!")}>{obj.title}</h1></li>
    ));

    return (
      // {tabHeadings}
      <div></div>
    );

  }
}

export default Tabs;

// Keep track of the selected tab's index in your Tabs component's state. Set it initially to zero.
//
// In the render method of Tabs, render a collection of <h1>s (with titles) in a <ul> and the content of the selected tab in an <article>.

// Add a click handler to each header that updates the selected index in the Tabs component.
//
// Remember that JSX interpolation is just syntactic sugar for passing an argument to a function, which means that it only supports expressions, so you can't use if/else inside { }. (This is also why you can't end with a semicolon.)
//
// Create an index.css file and add it to the head of your index.html file. Remember to include your CSS resets.
//
// Add a border around each tab header and the whole section. Use border-radius to add nicely curved corners to the top of your tabs.
//
// Use a flexbox to ensure that the tabs all take up the same amount of space. Add display: flex to your CSS for your tab headers.
//
// Center the tab content, both horizontally and vertically.
//
// Add a hover effect to change the background color of the tab that's being moused over. Change the cursor to be a pointer when you're mousing over the tabs to make it clear that the tabs are interactive.
//
// Add a background. Use the background-image or background-color property to change the background. Feel free to do this for every widget.
