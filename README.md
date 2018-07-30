# Volops (Volunteer Operations System)

System to manage volunteers for an event. This system is a rails application within a docker container. It also uses react through the react-rails webpacker gem. 

### Prerequisites

You must have docker and docker-compose installed

### Installing

```make build``` to build the project. ```make run-dev``` to start the project in developement mode

### Running rails or yarn command

to run rails command, you must add ```docker-compose run web``` in front of the command
Example:
```
docker-compose run web rails db:migrate
```
## Seed

The seed provides real data from volunteers during Lan ETS 2018. ```docker-compose run web rails db:seed ```
Afterwards, an admin with the credentials `bachnguyen0408@gmail.com:allo123` will be created

## Deployment

Section under construction

## Built With

* [Ruby on Rails V.5.2](https://rubyonrails.org/) - The ruby web framework used
* [Mariadb](https://mariadb.org/) - Open source MySql database
* [React V.16.4.1](https://reactjs.org/) - Javascript library for building user interfaces
* [Yarn V.1.6](https://yarnpkg.com/lang/en/) - Javascript package manager
* [Docker (docker-compose V.3.4](https://www.docker.com/) - Container for easier deployment and installation


## Authors

* **Bach Nguyen-Ngoc** - *Initial work* - [bnguyenngoc](https://github.com/bnguyenngoc)

## License

This project is licensed under the MIT License

## Acknowledgments

* [Simon Carpentier](https://github.com/scarpentier) for the original excel sheet that we used for countless years
