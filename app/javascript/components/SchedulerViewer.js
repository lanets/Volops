import React, {Component} from 'react'
import Scheduler, {SchedulerData, ViewTypes, DATE_FORMAT} from 'react-big-scheduler'
import moment from 'moment'
import withDragDropContext from './withDnDContext'
import DemoData from './DemoData'

class SchedulerViewer extends Component {
    constructor(props) {
        super(props);
        this.events = props.events;
        this.eventDate = props.eventDate;
        this.resources = props.resources;
        let schedulerData = new SchedulerData(moment(props.eventDate).format(DATE_FORMAT), ViewTypes.Day);
        schedulerData.localeMoment.locale('en');
        schedulerData.setResources(props.resources);
        schedulerData.setEvents(this.events);
        /*
        let schedulerData = new SchedulerData('2017-12-18', ViewTypes.Week);
        schedulerData.isEventPerspective = true;
        schedulerData.localeMoment.locale('en');
        schedulerData.setResources(DemoData.resources);
        schedulerData.setEvents(DemoData.events);
        */
        this.state = {
            viewModel: schedulerData
        }
    }

    render() {
        const {viewModel} = this.state;
        return (

            <button onClick={this.prevClick}>Previous Date</button>
            <button onClick={this.nextClick}>Next Date</button>
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

    prevClick = (schedulerData) => {
        schedulerData.prev();
        schedulerData.setEvents(this.events);
        this.setState({
            viewModel: schedulerData
        })
    };

    nextClick = (schedulerData) => {
        schedulerData.next();
        schedulerData.setEvents(this.events);
        this.setState({
            viewModel: schedulerData
        })
    };

    onViewChange = (schedulerData, view) => {
        schedulerData.setViewType(view.viewType, view.showAgenda, view.isEventPerspective);
        schedulerData.setEvents(this.events);
        this.setState({
            viewModel: schedulerData
        })
    };

    onSelectDate = (schedulerData, date) => {
        schedulerData.setDate(date);
        schedulerData.setEvents(this.events);
        this.setState({
            viewModel: schedulerData
        })
    };

    eventClicked = (schedulerData, event) => {
        alert(`You just clicked an event: {id: ${event.id}, title: ${event.title}}`);
    };

}

export default withDragDropContext(SchedulerViewer)