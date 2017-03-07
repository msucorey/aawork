import React from 'react';

class StepForm extends React.Component {
  constructor(props) {
    super(props);
    this.state ={ title: "", description: "" };
    this.updateTitle = this.updateTitle.bind(this);
    this.updateDescription = this.updateDescription.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  updateTitle(e) {
    this.setState({ title: e.target.value });
  }

  updateDescription(e) {
    this.setState({ description: e.target.value });
  }

  handleSubmit(e) {
    e.preventDefault();
    const uniqueId = new Date().getTime();
    this.props.receiveStep({
      id: uniqueId,
      title: this.state.title,
      description: this.state.description,
      done: false,
      todo_id: this.props.todoId
    });
    this.setState({ title: "", description: "" });
  }

  render() {
    return (
      <form onSubmit={this.handleSubmit}>
        <input
          type="text"
          onChange={this.updateTitle}
          value={this.state.title}
        />
      <textarea
        onChange={this.updateDescription}
        value={this.state.description}>
      </textarea>
        <button>Add Step</button>
      </form>
    );
  }
}

export default StepForm;
