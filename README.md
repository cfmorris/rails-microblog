# microBlog

## Heroku

Hartl emphasizes the importance of hosting the app throughout the development process in order to catch bugs early.  This app hosted at:


https://frozen-beach-47064.herokuapp.com/
## Project Summary

This project is based on Michael Hartl's [The Ruby on Rails Tutorial, 6th ed.](ttps://www.railstutorial.org/) but there are some notable differences.  He uses Rails 6 which with Bootstrap + Webpacker + JQuery for the front end and a SQLite3 development database.  I'm using Rails 7 with bootstrap 5 on the front end and turbo-rails with a local PostSQL database.  Most of the principles are the same, but there are occasionally some differences in execution.

Version Info - [see more](./Gemfiles)
- Ruby 3.0.1
- Rails 7.0.3
- Bootstrap 5.1.3
- PostSQL 14.2
- pg 1.3.5
- Popper_js 2.9.3


User authentication has been built from scratch with minimal gems. BCrypt does the hashing and stores passwords in the digest.

Login is optionally persistent, but needs a little more work on implementation.  

## Current State (530 of 893)

  - Views for most pages are up.
  - User table exists in the database.
  - User signup is implemented. (needs front end validation feedback or .js to display it from the server.)
  - Session and Cookie based log in persistence is in.
  - Front end looks pretty good.
  - Lots of "happy path" test coverage, needs more "sad path" tests.

## Things to do after completion

- Remodel the front end in pure, clean bootstrap.

- Currently a user checks "Remember me" on login and it persists until they manually log out.  I'm going to add a toggle to allow them to opt in or out at in at any time from any page.

- Would be interesting to implement RSA keys and/or multifactor authentication as an exercise.

- Currently persistence reliase upon a random base64 string with a hashed user id.  This information is only passed via TLS connections, so the relative simplicity of the hashed numerical id isnt a huge issue, but it is tempting to use another identifier.

- Email addresses are currently used as the primary unique identifier.  I'd prefer to have unique usernames and rely less on the more sensitive emails.


