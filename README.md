Knife Runlist Compare
===========
Knife Runlist Compare is is a Knife plugin which allows you, as the name suggests, to compare two Chef run_lists. It takes each run_list it is given, expands them into the list of recipes which would be executed on a node, and produces a diff of the differences between those recipe lists.

[![Gem Version](https://badge.fury.io/rb/knife-runlist-compare.png)](http://badge.fury.io/rb/knife-runlist-compare)

Installation
------------

### Gem Install
`knife-runlist-compare` is available on rubygems. Add the following to your `Gemfile`:

```ruby
gem 'knife-runlist-compare'
```

or install the gem manually:

```bash
gem install knife-runlist-compare
```

### Usage
```bash
knife runlist compare RUNLIST_1 RUNLIST_2 (options)
```

### Supported Options

#### Environment
The `environment` option allows you to specify the Chef environment to be used in the run_list expansion process (defaults to `production`)

```bash
-e ENV_NAME
--environment ENV_NAME
```

#### Data Source
The `datasource` option allows you to specify whether to use the Chef Server (`server`) or local disk (`disk`) to load roles and recipes for run_list expansion

```bash
-d DATA_SOURCE
--data-source DATA_SOURCE
```

#### Context Lines
The `context_lines` option allows you to specify the number of lines of context to be shown around each item in the diff output (defaults to 10000)

```bash
-U CONTEXT_LINES
--context-lines CONTEXT_LINES
```

### Usage Example

```text
$ knife runlist compare 'role[Base]' 'role[NewBase]' -U 3
run_list role[Base] expands to the following recipes:
["foo", "bar::baz"]

run_list role[NewBase] expands to the following recipes:
["foo"]

The following is the diff of these run_lists:
 foo
-bar::baz
```