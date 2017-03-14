// frontend/components/bench_index.jsx
import React from 'react';

class BenchIndex extends React.Component {

  constructor (props) {
    super(props);
  }

  componentDidMount() {
    this.props.fetchBenches();
    debugger
  }

  render() {
    debugger
    const benches = this.props.benches.map(bench => (
      <li key={bench.id}>{bench.description}</li>
    ));
    return (
    <ul>
      holla!
      {benches}
    </ul>);
  }
}

export default BenchIndex;
