import React from 'react';

class StepListItem extends React.Component {

  constructor(props) {
    super(props);
    this.handleClickDel = this.handleClickDel.bind(this);
    this.handleClickDone = this.handleClickDone.bind(this);
    this.state = { done: false };
  }

  handleClickDel() {
    console.log("deleting!");
    console.log(this.props.step);
    this.props.removeStep(this.props.step);
  }

  handleClickDone() {
    console.log("done!");
    this.setState({ done: !this.state.done });
  }

  render() {
    const { step } = this.props;
    const buttonText = this.state.done ? "Undone" : "Done";

    return (
      <li>
        <h5>{step.title}</h5>
        <p>{step.body}</p>
        <button type="button" onClick={this.handleClickDel}>Delete</button>
        <button type="button" onClick={this.handleClickDone}>{buttonText}</button>
      </li>
    );
  }
}

export default StepListItem;
