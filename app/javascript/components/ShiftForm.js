import React from "react"
import DatePicker from 'react-datepicker';
import moment from 'moment';



class ShiftForm extends React.Component {
    constructor(props){
        super();
        this.state = {
            start_time: props.shift.start_time? moment(props.shift.start_time) : moment(),
            end_time: props.shift.end_time? moment(props.shift.end_time) : moment()
        };
        this.edit = props.edit
        this.handleStartDateChange = this.handleStartDateChange.bind(this);
        this.handleEndDateChange = this.handleEndDateChange.bind(this);
        this.postURL = '/events/' + props.event.id + '/shifts'
        this.csrfToken = $('meta[name="csrf-token"]')[0].content
    }

    handleStartDateChange(e) {
        this.setState({start_time: e});
    }

    handleEndDateChange(e) {
        this.setState({end_time: e});
    }

    render() {
        let button
        if(this.edit) {
            button = <button className="btn btn-primary" type="submit">Edit</button>
        } else {
            button = <button className="btn btn-primary" type="submit">Create Shift</button>
        }
        return(
         <form method="POST" action={this.postURL}>
             <div className="form-group">
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
             <div className="form-group">
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
             <input name="authenticity_token" type="hidden" value={this.csrfToken} />
             {button}
         </form>
        )
    }

}
export default ShiftForm

