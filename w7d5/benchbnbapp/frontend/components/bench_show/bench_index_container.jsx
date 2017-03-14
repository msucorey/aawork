// frontend/components/bench_index_container.jsx
import { connect } from 'react-redux';
import BenchIndex from './bench_index';
import { fetchBenches } from '../../actions/bench_actions';

const mapStateToProps = ({benches}) => ({
  benches: Object.keys(benches).map(id => (benches[id]))
});

const mapDispatchToProps = dispatch => ({
  fetchBenches: () => dispatch(fetchBenches())
});

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(BenchIndex);
