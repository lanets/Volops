import React, {Component} from 'react';
import moment from 'moment';
import {Radar} from 'react-chartjs-2';

class radarChart extends Component {
    constructor(props) {
        super(props);
        this.labels = this.props.teams.map(data => {
            return data.title
        });
        this.data = this.props.radarData;
        this.data = {
            labels: this.labels ,
            datasets: [{
                label: '# of application',
                data: this.data,
                pointBackgroundColor: 'rgb(250, 158, 149)',
                backgroundColor:'#EBCCD1',
                borderColor: '#FF5F7E'
            }]
        }
    }

    render() {
        console.log(this.labels);
        console.log(this.data);
        return (
            <Radar
                data = {this.data}

            />
        )
    };

}



export default radarChart