Feature: Articles

Background: Define url 
  * url apiUrl
  * def articleRequestBody = read('classpath:conduitApp/json/newArticles.json')
  * def dataGenerator = Java.type('helpers.DataGenerator')
  * set articleRequestBody.article.title = __gatling.Title
  * set articleRequestBody.article.description = __gatling.Description
  * set articleRequestBody.article.body = dataGenerator.getRandomArticleValues().body
  * def sleep = function(ms) {java.lang.Thread.sleep(ms)}
  * def pause = karate.get('__gatling.pause',sleep)
@debug  
Scenario: Create and delete article
    * configure hwaders = {"Authorization": #('Token '+ __gatling.token)}
    Given path 'articles'
    And request articleRequestBody
    And header karate-name = 'Title request: '+ __gatling.Title
    When method Post
    Then status 200
    * def articleId = response.article.slug
    * pause(5000)
    Given path 'articles',articleId
    When method delete
    Then status 204 

    
