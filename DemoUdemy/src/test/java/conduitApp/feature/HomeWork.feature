Feature: HomeWork feature

    Background: Define url
        * url apiUrl
        * def articleRequestBodyComment = read('classpath:conduitApp/json/newArticles.json')
        * def dataGenerator = Java.type('helpers.DataGenerator')
        * set articleRequestBodyComment.comment.body = dataGenerator.getRandomComment().body 

    Scenario: Favorites Article
        * def timeValidator =  read('classpath:helpers/TimeValidator.js')
        Given params { limit: 10, offset: 0}
        Given path 'articles'  
        When method Get
        Then status 200 
        * def slugId = response.articles[0].slug
        * def favCount = response.articles[0].favoritesCount        
        And match response.articles == '#array'
        

        Given path 'articles', slugId ,'favorite'
        When method Post
        Then status 200
        And match response.article.favoritesCount != favCount
        And match response.article ==
        """
        {"id":'#number',
        "slug":"#string",
        "title":"#string",
        "description":"#string",
        "body":"#string",
        "createdAt":"#? timeValidator(_)",
        "updatedAt":"#? timeValidator(_)",
        "authorId":"#number",
        "tagList":"#array",
        "author": {
        "username":"#string",
        "bio":"##string",
        "image":"#string",
        "following":"#boolean"},
        "favoritedBy":"#array",
        "favorited":"#boolean",
        "favoritesCount":"#number"}


        """
        Given params { favorited:"#(userEmail)", limit: 10, offset: 0}
        Given path 'articles'
        When method Get
        Then status 200
        
        
    Scenario: Comment Article
        * def timeValidator =  read('classpath:helpers/TimeValidator.js')
        Given params { limit: 10, offset: 0}
        Given path 'articles'  
        When method Get
        Then status 200 
        * def slugId = response.articles[0].slug
        Given  path 'articles',slugId,'comments'
        And request articleRequestBodyComment
        When method Post
        Then status 200
        And match response.comment.body == "#string"
        Given  path 'articles',slugId,'comments'
        When method Get
        Then status 200
        And match response.comment[0] == 
        """ 
            {"id":"#number",
            "createdAt":"#? timeValidator(_)",
            "updatedAt":"#? timeValidator(_)",
            "body":"#string",
            "author":
            {"username":"#string",
            "bio":"##string",
            "image":"#string",
            "following":"#boolean"
            }
            }
        """
        * def commentLength = response.comments.length
        Given  path 'articles',slugId,'comments'
        And request articleRequestBodyComment
        When method Post
        Then status 200
        Given  path 'articles',slugId,'comments'
        When method Get
        Then status 200
        * def commentLength1 =  response.comments.length  
        And match commentLength != commentLength1 
        * def deleteCommentId = response.comments[0].id
        Given path 'articles',slugId,'comments',deleteCommentId
        When method delete
        Then status 200
        Given  path 'articles',slugId,'comments'
        When method Get
        Then status 200
        * def commentLength2 =  response.comments.length
        And match commentLength2 == commentLength1 -1

    

    



     

        
