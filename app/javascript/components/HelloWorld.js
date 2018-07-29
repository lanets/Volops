import React from "react"
import PropTypes from "prop-types"
class HelloWorld extends React.Component {
  render () {
    const REACT_VERSION = React.version;
    return (
      <React.Fragment>
        Current version of React: {REACT_VERSION}
      </React.Fragment>
    );
  }
}

HelloWorld.propTypes = {
  greeting: PropTypes.string
};
export default HelloWorld
