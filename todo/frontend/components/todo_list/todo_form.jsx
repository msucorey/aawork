import React from 'react';

class TodoForm extends React.Component {
  constructor(props) {
    super(props);
    this.state ={ title: "", body: "" };
    this.updateTitle = this.updateTitle.bind(this);
    this.updateBody = this.updateBody.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  updateTitle(e) {
    this.setState({ title: e.target.value });
  }

  updateBody(e) {
    this.setState({ body: e.target.value });
  }

  handleSubmit(e) {
    e.preventDefault();
    const uniqueId = new Date().getTime();
    this.props.receiveTodo({
      id: uniqueId,
      title: this.state.title,
      body: this.state.body,
      done: false
    });
    this.setState({ title: "", body: "" });
  }

  render() {
    return (
      <form onSubmit={this.handleSubmit}>
        <input
          type="text"
          onChange={this.updateTitle}
          value={this.state.title}
        />
      <textarea onChange={this.updateBody} value={this.state.body}></textarea>
        <button>Add Todo Item</button>
      </form>
    );
  }
}

export default TodoForm;
