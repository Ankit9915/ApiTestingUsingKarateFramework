
Feature: Test for the home page
    Background: Define url 
        Given url apiUrl


Scenario: Get all tags
    Given path 'tags'
    When method Get
    Then status 200
    And match response.tags == "#array"
    And match  each response.tags == "#string"


Scenario: Get 10 articles from the page
    * def timeValidator =  read('classpath:helpers/TimeValidator.js')
    Given params { limit: 10, offset: 0}
    Given path 'articles'  
    When method Get
    Then status 200  
    And match response.articlesCount != 500
    And match response.articles[0].createdAt !contains '2022'
    And match response.articles[0].createdAt contains '2023'
    And match response.articles[*].favoritesCount contains 0
   # And match response.articles[*].author.bio contains null
   And match response..bio contains null
   And match each response..following == false
   And match each response..following == '#boolean'
   And match each  response..favoritesCount == '#number'
   And match each response..bio == '##string'
   And match each response.articles ==
   """
{
            "slug": "#string",
            "title": "#string",
            "description": "#string",
            "body": "#string",
            "tagList": "#array",
            "createdAt": "#? timeValidator(_)",
            "updatedAt": "#? timeValidator(_)",
            "favorited": "#boolean",
            "favoritesCount": "#number",
            "author": {
                "username": "#string",
                "bio": "##string",
                "image": '#string',
                "following": '#boolean'
            }
        }


   """
Scenario: Conditional Logic
    Given params { limit: 10, offset: 0}
    Given path 'articles'  
    When method Get
    Then status 200  
    * def favCount = response.articles[0].favoritesCount
    * def article = response.articles[0]

   # * if ( favCount == 0 ) karate.call('classpath:helpers/Addlikes.feature',article)

   # by using javascript
   * def result = favCount == 0 ? karate.call('classpath:helpers/Addlikes.feature',article).likesCount : favCount

    Given params { limit: 10, offset: 0}
    Given path 'articles'  
    When method Get
    Then status 200 
    And match response.articles[0].favoritesCount == result

Scenario: Retry Call
    * configure retry = { count: 10 , interval: 5000 }  
    Given params { limit: 10, offset: 0}
    Given path 'articles'  
    And retry until response.articles[0].favoritesCount == 1
    When method Get
    Then status 200 

Scenario: Sleep call
    * def sleep = function(pause){ java.lang.Thread.sleep(pause) }
    Given params { limit: 10, offset: 0}
    Given path 'articles'  
    When method Get
    * eval sleep(10000)
    Then status 200 

Scenario: Number to String Conversion
    * def foo = 10
    * def a = 10 + ''
    * def json = {"bar": #(foo+'')}  
    * match json ==  {"bar": '10'} 
    * match a == '10'

Scenario: String to Number Conversion
    * def foo = '10'
    * def json1 = {"bar": #(foo*1)}  
    * def json2 = {"bar": #(~~parseInt(foo))}   
    * match json1 ==  {"bar": 10} 
    * match json2 ==  {"bar": 10} 
    
    









