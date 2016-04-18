# ActiveORM

A lightweight ORM built using TDD, and inspired by Rails' ActiveRecord gem.

### Usage

* The SQLObject model maps SQLite queries onto Ruby objects.
represents a table and enables you to insert, update, and save through SQLObject instances.
* The Searchable module allows you to use the SQL `WHERE` clause on 'SQLObjects'.
* The Associatable module adds familiar association methods like `has_many`, `belongs_to`, and `has_many_through`.
* The DBConnection class interfaces with the SQLite database files.
* Uses the gem `activesupport` for parsing and formatting table entries with `inflector`.
