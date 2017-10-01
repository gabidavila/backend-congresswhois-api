# Congress Index Backend

Rails backend that connects to [ProPublica](https://www.propublica.org) API to filter current congress members.

* `bundle install`
* `rails db:create`
* `rails db:migrate`
* `rails import:run_all`
* `rails s`

It can take a few minutes to import all the data.

## Env. Variables

The variables shown on `.env.example` are mandatory. Some are pre-filled. Currently the API for ProPublica Congress API is not being distributed. This may be changed by the time you want to contribute to the project, in any case you can try to get an API key filling the form in this [address](https://www.propublica.org/datastore/api/propublica-congress-api). Documentation for the API is available [here](https://projects.propublica.org/api-docs/congress-api/).

## ToDo

* Create filter by congress number, currently only the current congress is shown.
* Create endpoint to show bills, bills by member
* Create endpoint to show votes for bills, showing who voted for what

## License

This project would be MIT if it was of my choice, however ProPublica API is licensed under Creative Commons Attribution-NonCommercial-NoDerivs 3.0, which means I can't open source the code.