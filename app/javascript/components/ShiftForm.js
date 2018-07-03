import React from "react"
import PropTypes from "prop-types"

class ShiftForm extends React.Component {
    constructor(props){
        super();
        this.state = {
            start_date: props.shift.start_date,
            end_date: props.shift.end_date
        };
        this.handleStartDateChange = this.handleStartDateChange.bind(this);
        this.handleEndDateChange = this.handleEndDateChange.bind(this);
    }

    handleStartDateChange(e) {
        this.setState({start_date: e.target.value});
    }

    handleEndDateChange(e) {
        this.setState({end_date: e.target.value});
    }



    render() {
        return(
         <form className="form-group col-md-6">
             <div className="form-group col-md-6">
                 <label>Start Date</label>
                 <input
                     type="text"
                     name="shift[start_date]"
                     value={this.state.start_date}
                     onChange={this.handleStartDateChange}
                     className="form-control"
                 />
             </div>
             <div className="form-group col-md-6">
                 <label>End Date</label>
                 <input
                     type="text"
                     name="shift[end_date]"
                     value={this.state.end_date}
                     onChange={this.handleEndDateChange}
                     className="form-control"
                 />
             </div>
             <button className="btn btn-primary" type="submit">Create Shift</button>
         </form>
        )
    }

}
export default ShiftForm

