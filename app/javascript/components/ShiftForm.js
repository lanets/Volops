import React from "react"
import DatePicker from 'react-datepicker';
import moment from 'moment';

import 'react-datepicker/dist/react-datepicker.css';

class ShiftForm extends React.Component {
    constructor(props){
        super();
        this.state = {
            start_time: moment(),
            end_time: moment()
        };
        this.handleStartDateChange = this.handleStartDateChange.bind(this);
        this.handleEndDateChange = this.handleEndDateChange.bind(this);
        this.postURL = '/events/' + props.event.id + '/shifts'
    }

    handleStartDateChange(e) {
        this.setState({start_time: e});
    }

    handleEndDateChange(e) {
        this.setState({end_time: e});
    }

    render() {
        return(
         <form method="POST" action={this.postURL} className="form-group col-md-6">
             <div className="form-group col-md-6">
                 <label>Start Time</label>
                 <DatePicker
                     showTimeSelect
                     timeFormat="HH:mm"
                     timeIntervals={15}
                     dateFormat="YYYY-MM-DD HH:mm"
                     timeCaption="Time"
                     selected={this.state.start_time}
                     name="shift[start_time]"
                     onChange={this.handleStartDateChange}
                     className="form-control"
                 />
             </div>
             <div className="form-group col-md-6">
                 <label>End Time</label>
                 <DatePicker
                     showTimeSelect
                     timeFormat="HH:mm"
                     timeIntervals={15}
                     dateFormat="YYYY-MM-DD HH:mm"
                     timeCaption="Time"
                     selected={this.state.end_time}
                     name="shift[end_time]"
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

