import React from "react"
import Scheduler, {SchedulerData, ViewTypes, DATE_FORMAT} from 'react-big-scheduler'
//include `react-big-scheduler/lib/css/style.css` for styles, link it in html or import it here
import 'react-big-scheduler/lib/css/style.css'
import moment from 'moment'
import withDragDropContext from './withDnDContext'

class SchedulerViewer extends React.Component {
    constructor(props) {
        super(props);
        this.events = props.events;
        this.resources = props.resources;
        let schedulerData = new SchedulerData(moment(props.eventDate).format(DATE_FORMAT), ViewTypes.Day);
        schedulerData.setResources(props.resources);
//set events here or later,
//the event array should be sorted in ascending order by event.start property, otherwise there will be some rendering errors
        schedulerData.setEvents(this.events);
        this.state = {
            viewModel: schedulerData
        }
    }

    render() {
        const {viewModel} = this.state;
        console.log(this.events);
        console.log(this.resources);
        return (
            <div>
                <Scheduler schedulerData={viewModel}
                           prevClick={this.prevClick}
                           nextClick={this.nextClick}
                           onSelectDate={this.onSelectDate}
                           onViewChange={this.onViewChange}
                           eventItemClick={this.eventClicked}
                />
            </div>


        )
    }

    prevClick = (schedulerData)=> {
        schedulerData.prev();
        schedulerData.setEvents(this.events);
        this.setState({
            viewModel: schedulerData
        })
    }

    nextClick = (schedulerData)=> {
        schedulerData.next();
        schedulerData.setEvents(this.events);
        this.setState({
            viewModel: schedulerData
        })
    }

    onViewChange = (schedulerData, view) => {
        schedulerData.setViewType(view.viewType, view.showAgenda, view.isEventPerspective);
        schedulerData.setEvents(this.events);
        this.setState({
            viewModel: schedulerData
        })
    }

    onSelectDate = (schedulerData, date) => {
    };

    eventClicked = (schedulerData, event) => {
    };

}

export default withDragDropContext(SchedulerViewer)