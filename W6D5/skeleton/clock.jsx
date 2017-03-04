import React from "react";
import ReactDOM from "react-dom";

class Clock extends React.Component {

  constructor (props) {
    super(props);
    this.intervalID = undefined;
    this.state = { date: new Date() };
  }

  componentDidMount() {
    this.intervalID = setInterval(() =>
      this.setState({ date: new Date() }),
      1000
    );
  }

  componentWillUnmount() {
    this.intervalID.clearInterval();
  }

  render() {
    return (
      <div>
        <span className="time-str">{ this.state.date.toTimeString()}</span>
        <br/>
        <span className="date-str">{ this.state.date.toDateString()}</span>
        <img src="https://c.tadst.com/gfx/750w/fb-worldclocks.png?1"/>
      </div>
    );
  }
}

export default Clock;
