# Volops (Volunteer Operations System)

System to manage volunteers for an event. This system is a rails application within a docker container. It also uses react through the rails webpacker gem. 

### Prerequisites

You must have docker and docker-compose installed

### Installing

```make build``` to build the project. ```make run-dev``` to start the project.

### Running rails command

to run rails command, you must add ```docker-compose run web``` in front of the command
Example:
```
docker-compose run web bundle install
```

## Deployment

Section under construction

## Built With

* [Ruby on Rails V.5.2](https://rubyonrails.org/) - The web framework used
* [Mariadb](https://mariadb.org/) - Open source MySql database
* [React](https://reactjs.org/) - Javascript library for building user interfaces



## Authors

* **Bach Nguyen-Ngoc** - *Initial work* - [bnguyenngoc](https://github.com/bnguyenngoc)

## License

This project is licensed under the MIT License

## Acknowledgments

* [Simon Carpentier](https://github.com/scarpentier) for the original excel sheet that we used for countless years
