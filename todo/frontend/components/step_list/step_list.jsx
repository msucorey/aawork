import React from 'react';
import StepListItemContainer from './step_list_item_container';

class StepList extends React.Component {
  constructor (props) {
    super(props);
  }

  render() {
    const items = [];
    this.props.steps.forEach(step => {
      items.push(<StepListItemContainer key={step.id} step={step} />);
    });

    return (
      <div>
        <ul>
          {items}
        </ul>
      </div>
    );
  }
}

export default StepList;
