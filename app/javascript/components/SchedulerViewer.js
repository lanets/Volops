import React from "react"
import Scheduler, {SchedulerData, ViewTypes, DATE_FORMAT} from 'react-big-scheduler'
//include `react-big-scheduler/lib/css/style.css` for styles, link it in html or import it here
import 'react-big-scheduler/lib/css/style.css'
import moment from 'moment'
import withDragDropContext from './withDnDContext'

class SchedulerViewer extends React.Component {
    constructor(props){
        super(props);
        this.schedules = props.schedules
        let schedulerData = new SchedulerData('2017-12-18', ViewTypes.Day);
//set resources here or later
        let resources = [
            {
                id: 'r1',
                name: 'Resource1'
            },
            {
                id: 'r2',
                name: 'Resource2'
            },
            {
                id: 'r3',
                name: 'Resource3'
            }
        ];
        schedulerData.setResources(resources);
//set events here or later,
//the event array should be sorted in ascending order by event.start property, otherwise there will be some rendering errors
        let events = [
            {
                id: 1,
                start: '2017-12-18 09:30:00',
                end: '2017-12-19 23:30:00',
                resourceId: 'r1',
                title: 'I am finished',
                bgColor: '#D9D9D9'
            },
            {
                id: 2,
                start: '2017-12-18 12:30:00',
                end: '2017-12-26 23:30:00',
                resourceId: 'r2',
                title: 'I am not resizable'
            },
            {
                id: 3,
                start: '2017-12-19 12:30:00',
                end: '2017-12-20 23:30:00',
                resourceId: 'r3',
                title: 'I am not movable'
            },
            {
                id: 4,
                start: '2017-12-19 14:30:00',
                end: '2017-12-20 23:30:00',
                resourceId: 'r1',
                title: 'I am not start-resizable'
            },
            {
                id: 5,
                start: '2017-12-19 15:30:00',
                end: '2017-12-20 23:30:00',
                resourceId: 'r2',
                title: 'I am not end-resizable'
            }
        ];
        schedulerData.setEvents(events);
        this.state = {
            viewModel: schedulerData
        }
    }
    render(){
        console.log(this.schedules)
        const {viewModel} = this.state;
        return (
            <div>
                <div>
                    <Scheduler schedulerData={viewModel}
                               prevClick={this.prevClick}
                               nextClick={this.nextClick}
                               onSelectDate={this.onSelectDate}
                               onViewChange={this.onViewChange}
                               eventItemClick={this.eventClicked}
                    />
                </div>
            </div>
        )
    }

    prevClick = (schedulerData)=> {};

    nextClick = (schedulerData)=> {};

    onViewChange = (schedulerData, view) => {};

    onSelectDate = (schedulerData, date) => {};

    eventClicked = (schedulerData, event) => {};

}

export default withDragDropContext(SchedulerViewer)