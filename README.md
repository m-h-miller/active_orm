# ActiveORM

A lightweight ORM built using TDD, and inspired by Rails' ActiveRecord gem.

### Usage

* The SQLObject model maps SQLite queries onto Ruby objects.
represents a table and enables you to insert, update, and save through SQLObject instances.
* The Searchable module allows you to use the SQL `WHERE` clause on 'SQLObjects'.
* The Associatable module adds familiar association methods like `has_many`, `belongs_to`, and `has_many_through`.
* The DBConnection class interfaces with the SQLite database files.
* Uses the gem `activesupport` for parsing and formatting table entries with `inflector`.

### How to Use

* Download this directory, include it in your project, and then use `require_relative './active_orm/active_orm.rb'`.
* Alter the Schema.sql file to set up your SQLite DB, then run DBConnection.reset. This will generate a new schema.db reflecting your database specs.
* Inherit from SQLObject to access tons of great methods!
