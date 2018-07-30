import React from 'react'
import PropTypes from 'prop-types'
class HelloWorld extends React.Component {
  render() {
    const REACT_VERSION = React.version
    return (
      <React.Fragment>
        <h1> Welcome to Volops! </h1>
        <h4> Management system for volunteer operations </h4>
        Current version of React: {REACT_VERSION}
      </React.Fragment>
    )
  }
}

HelloWorld.propTypes = {
  greeting: PropTypes.string
}
export default HelloWorld
