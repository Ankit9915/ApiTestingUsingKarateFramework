Feature: Work With Db

    Background: Connect to DB
        * def dbHandler = Java.type('helpers.DbHandler')

    Scenario: Seed Database with new job
        * eval dbHandler.addNewJobWithName("rxcd")

    Scenario: Get Data from database
        * def value = dbHandler.getAgeAndId("rxcd")  
        * print value.id 
        * print value.age
