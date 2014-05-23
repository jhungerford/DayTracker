DayTracker
==========

Ember.js, Elasticsearch, and Dropwizard webapp for keeping track of what I do every day.

## Running out of IntelliJ
* Set up a maven project from pom.xml, enable auto-import
* Create a run configuration with:
```
Name: DayTracker
Main class: dev.daytracker.DayTrackerMain
Program arguments: server daytracker.yml
```
* Run DayTracker
* In Maven Projects, run Plugins -> brew -> brew:compile

Brew watches for changes to coffeescript files and compiles them automatically - no server restart required.
Changes to the java application require a restart, but DropWizard restarts crazy-fast.
