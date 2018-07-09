import React from "react"
import DatePicker from 'react-datepicker';
import moment from 'moment';

import 'react-datepicker/dist/react-datepicker.css';

class ShiftForm extends React.Component {
    constructor(props){
        super();
        this.state = {
            start_date: moment(),
            end_date: moment()
        };
        this.handleStartDateChange = this.handleStartDateChange.bind(this);
        this.handleEndDateChange = this.handleEndDateChange.bind(this);
    }

    handleStartDateChange(e) {
        this.setState({start_date: moment(e).format()});
        console.log(this.state.start_date)
    }

    handleEndDateChange(e) {
        this.setState({end_date: moment(e).format()});
    }



    render() {
        return(
         <form className="form-group col-md-6">
             <div className="form-group col-md-6">
                 <label>Start Date</label>
                 <DatePicker
                     showTimeSelect
                     timeFormat="HH:mm"
                     timeIntervals={15}
                     dateFormat="LLL"
                     timeCaption="Time"
                     selected={this.state.start_date}
                     name="shift[start_date]"
                     onChange={this.handleStartDateChange}
                     className="form-control"
                 />
             </div>
             <div className="form-group col-md-6">
                 <label>End Date</label>
                 <DatePicker
                     showTimeSelect
                     timeFormat="HH:mm"
                     timeIntervals={15}
                     dateFormat="LLL"
                     timeCaption="Time"
                     selected={this.state.end_date}
                     name="shift[end_date]"
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

