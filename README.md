## Ship Shop API

To run locally:

```
bundle install
rails db:migrate
rails server
```
The best way to get familiarized with the design is to follow the API docs:

Locally: http://localhost:3000/api-docs/index.html
Heroku:  https://ship-shop-klearly-cc.herokuapp.com/api-docs/index.html

Notes:

- Unit tests on critical sections (eg: quantity modification)
- Majority of "happy path" functionality achieved with validations taking care of exceptions
- The only destructive action is through "Location Reset" endpoint.
- `DELETE` and `PUT` actions have been omitted due time constraints
- Some inconsistency between the documentation `schema` responses and actual responses requires further polishing

Please let me know if you have any issues or questions!
