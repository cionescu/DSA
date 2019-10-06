# DETAILS

The goals of this task are to build a Rest API using Ruby on Rails 6+ API that performs the following basic functionality:

- Create a User model with fields name, username
- Create an endpoint such that one User can follow another User
- Create an endpoint such that one User can unfollow another User
- Create an endpoint to display all followers of any User

# REQUIREMENTS

Please carefully follow the requirements of the API server using the details outlined below:

# Ruby on Rails

Please use Ruby on Rails in API mode for this project.

# Serializer

The API must respond with JSON using any serializer or method of choice. We highly recommend the Netflix Fast JSON API serializer.

# Model

- Build a User model with fields name, username
- The username field should have a validation around uniqueness of the name
- Create User instance methods that follow or unfollow a User. You may only follow a user once.

# API

- In the Rails routes create a namespace API
- In the Rails routes create the following endpoints:
- Create the endpoint HTTP POST /api/users that will create a User. The endpoint should respond with a User object and status 200 if successful
- Create the endpoint HTTP POST /api/users/:user_id/follow/:id that will find a User with user_id and and follow the User with ID id.
- Create the endpoint HTTP POST /api/users/:user_id/unfollow/:id that will find a User with ID user_id and unfollow the User with ID id
- Create the endpoint HTTP GET /api/users/:id/followers that will display all the followers (Users) for a User with ID id
- All requests that cannot be performed should render a status 422
