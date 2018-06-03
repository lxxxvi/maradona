[![Build Status](https://travis-ci.org/lxxxvi/maradona.svg?branch=master)](https://travis-ci.org/lxxxvi/maradona)
[![Maintainability](https://api.codeclimate.com/v1/badges/2222b60236248ba92dcf/maintainability)](https://codeclimate.com/github/lxxxvi/maradona/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/2222b60236248ba92dcf/test_coverage)](https://codeclimate.com/github/lxxxvi/maradona/test_coverage)

# Maradona

An online betting game.

Work in Progress: [https://tippkick.club](https://tippkick.club)

## Setup

Project requires **Postgres** and **Redis** to be running. Then do:

```
bin/setup
```

## Test

We use MiniTest

```
bin/rails test
```

## Data

### World Cup 2018

You can load the Worl Cup 2018 game data with following rake task.

```shell
rake import:world_cup_2018
```

It contains data for

* Venues (Stadiums)
* Teams (Countries)
* Matches (Group Stage only, including Kickoff time)


### Names

During registration every user will be given a random name that contains of a `first_name`, `last_name` and a random number between 10000 and 99999, for example `lionel-zidane-22358`. This will be used as `player_id`.

You can load a set of first and last names by running this rake task:

```shell
rake import:names
```

Also during creation, the user gets a `nickname` which will be initialized with the same value as the `player_id`.

A `nickname` can be changed by the users, whereas the `player_id` cannot be edited. `player_id` is also used in the URL to identify a user, like so `http://localhost:3000/users/lionel-zidane-22358`.


## License

"Maradona" is released under the [MIT License](https://opensource.org/licenses/MIT)

