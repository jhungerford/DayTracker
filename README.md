DayTracker
==========

React, RocksDB, and DropWizard webapp for keeping track of what I do every day.

## Running out of IntelliJ
* Set up a maven project from pom.xml, enable auto-import
* Create a run configuration with:
```
Name: DayTracker
Main class: dev.daytracker.DayTrackerMain
Program arguments: server daytracker.yml
```

## React
Run the dev server with `npm run start:dev`, and open a browser to [http://localhost:3000](http://localhost:3000).

## Resources
* [Creating a react app from scratch](https://blog.usejournal.com/creating-a-react-app-from-scratch-f3c693b84658)
* [Dropreact](https://github.com/bernd/dropreact)