import React, { Component } from 'react'
import moment from 'moment'
import { Radar } from 'react-chartjs-2'

class radarChart extends Component {
  constructor(props) {
    super(props)
    let labels = this.props.teams.map(team => {
      return team.title
    })
    let priorityData = this.priorityData.bind(this)
    let dataPriorityOne = this.priorityData(this.props.teams, this.props.data, 1)
    let dataPriorityTwo = this.priorityData(this.props.teams, this.props.data, 2)
    let dataPriorityThree = this.priorityData(this.props.teams, this.props.data, 3)

    this.chartData = {
      title: 'Total Teams Applications Based On Priority',
      labels: labels,
      datasets: [
        {
          label: '# of application for priority 1',
          data: dataPriorityOne,
          pointBackgroundColor: 'rgb(250, 158, 149)',
          backgroundColor: 'rgb(235, 204, 209, 0.25)',
          borderColor: '#FF5F7E'
        },
        {
          label: '# of application for priority 2',
          data: dataPriorityTwo,
          pointBackgroundColor: '#5620E4',
          backgroundColor: 'rgb(151, 100, 251, 0.50)',
          borderColor: '#BA8AF9'
        },
        {
          label: '# of application for priority 3',
          data: dataPriorityThree,
          pointBackgroundColor: '#1FC3B4',
          backgroundColor: 'rgb(117, 238, 222)',
          borderColor: '#CAFFF4'
        }
      ]
    }
  }

  render() {
    return <Radar data={this.chartData} />
  }

  priorityData = (teams, data, priority) => {
    let table = []

    for (let team of teams) {
      let teamsApplications = data.filter(app => app.team_id === team.id && app.priority === priority)
      table.push(teamsApplications.length)
    }

    return table
  }
}

export default radarChart
