import React, {Component} from 'react'
import Scheduler, {SchedulerData, ViewTypes, DATE_FORMAT} from 'react-big-scheduler'
import moment from 'moment'
import withDragDropContext from './withDnDContext'

class SchedulerViewer extends Component {
    constructor(props) {
        super(props);
        this.events = props.events;
        this.eventDate = moment(props.eventDate).format(DATE_FORMAT);
        this.resources = props.resources;
        this.newDefault = {
            schedulerWidth: 1500,
            views: []
        };
        let schedulerData = new SchedulerData(this.eventDate, ViewTypes.Day, false, false, this.newDefault);
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
            <div>
                <button onClick={this.prevClick} className={'btn btn-info'}>
                    <i className="fa fa-chevron-left"></i> Previous Date
                </button>
                <button onClick={this.nextClick} className={'btn btn-info'}>
                    Next Date <i className="fa fa-chevron-right"></i>
                </button>
                <Scheduler schedulerData={viewModel}
                           prevClick={this.prevClick}
                           nextClick={this.nextClick}
                           onSelectDate={this.onSelectDate}
                           onViewChange={this.onViewChange}
                           eventItemClick={this.eventClicked}
                           viewEventClick={this.ops1}
                />
            </div>
        )
    }

    prevClick = (schedulerData) => {
        this.eventDate = moment(this.eventDate).subtract(1, 'd').format(DATE_FORMAT);
        schedulerData = new SchedulerData(this.eventDate, ViewTypes.Day, false, false, this.newDefault);
        schedulerData.setEvents(this.events);
        schedulerData.setResources(this.resources);
        this.setState({
            viewModel: schedulerData
        })
    };

    nextClick = (schedulerData) => {
        this.eventDate = moment(this.eventDate).add(1, 'd').format(DATE_FORMAT);
        schedulerData = new SchedulerData(this.eventDate, ViewTypes.Day, false, false, this.newDefault);
        schedulerData.setEvents(this.events);
        schedulerData.setResources(this.resources);
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
        alert('You just clicked an event: {id: ${event.id}, title: ${event.title}}');
    };

}

export default withDragDropContext(SchedulerViewer)