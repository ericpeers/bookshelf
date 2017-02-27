# Bookshelf App

This app was written for a coding challenge. The challenge: Build a book rating app, in rails, for a single user (with the understanding it may be extended at some later date). A user should be able to create a book, mark it read, and give it a rating. We discussed the D in CRUD is not necessary. Target time for an accomplished rails programmer is a couple of hours. Expected deployment is on heroku and use Postgres.

## Technical Debt / Design Decisions

I broke the model up into 2 pieces with the intent of adding a user model (login/auth) at a later date. This allows a single book to be created and then assign multiple ratings to it. Ultimately we should have 5 tables: a user table, a bookshelf (books of interest or not - possibly including the read state), ratings table (user, book, rating). For now I just put read into the ratings table because the "2h time limit".

I included some simple if/else logic in the view layer to optionally insert a link for a couple of reasons:
  * creating ratings because displaying a rating of 0 for a new book is just wrong
  * view logic shouldn't technically have control statements, but putting links/view logic into the model is also equally bad. So contain it, comment it, and use the features of ERB
  * it's a pretty simple, non-nested if/else, which could be moved to a helper function in the viewlogic at some point, but KISS for now.

Code that would require a refactor for users has been tagged with comments **USER_EXTEND**

Code that should probably be reviewed / that I'm looking for feedback in a PR has been marked with **FIXME**

There are not tests yet - I was trying to get this done as fast as possible, so it was manually tested using the following matrix
  * add a book
  * list books
  * add a rating
  * edit a book / create a book
    * bad isbn / bad isbn length / non unique
    * missing title/author
  * add multiple ratings - show the rating value adjust for average.
  * show a book including the ratings for that book (multiple ratings)
  * add a rating that shows read, but no value for the rating. Average should handle it.
  * delete a rating like #5,6,7 in a group of ratings