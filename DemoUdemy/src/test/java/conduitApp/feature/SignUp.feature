@parllel=false
Feature: Sign Up new User

    Background: PreConditions
        * def dataGenerator = Java.type('helpers.DataGenerator')
        * def randomEmail = dataGenerator.getRandomEmail()
        * def randomUsername = dataGenerator.getRandomUsername()
        Given url apiUrl
    
    Scenario: New User Sign Up
#by using non static method
        * def jsFunction =
        """
         function () {
            var DataGenerator = Java.type('helpers.DataGenerator')
            var generator = new DataGenerator()
          return  generator.getRandomUsername2()
         } 

        """
        * def randomUsername2 = call jsFunction    

        Given path 'users'  
        And request
        """
            {
                "user": {
                    "email": #(randomEmail),
                    "password": "qwerty",
                    "username": #(randomUsername)
                }
            }
        """
        When method Post
        Then status 200    
        And match response ==
        """
{
    "user": {
        "email": #(randomEmail),
        "username": #(randomUsername),
        "bio": null,
        "image": "#string",
        "token": "#string"
    }
}
        """ 
    
    Scenario Outline: Validate Sign up error message
        
        Given path 'users'  
        And request
        """
            {
                "user": {
                    "email": "<email>",
                    "password": "<password>",
                    "username": "<username>"
                }
            }
        """
        When method Post
        Then status 422 
        And match response == <errorResponse>

        Examples:
            | email          | password | username | errorResponse |
            | #(randomEmail) | Ankit@786 | mohankhgf | {"errors":{"username":["has already been taken"]}} | 
            | test1er475@karate.com | Ankit@786 | #(randomUsername) | {"errors":{"email":["has already been taken"]}} |    
            | |  Ankit@786 | #(randomUsername) | {"errors":{"email":["can't be blank"]}} |
            | #(randomEmail)  |  |   #(randomUsername) | {"errors":{"password":["can't be blank"]}} |
            |  #(randomEmail) | qwerty |  | {"errors":{"username":["can't be blank"]}} |         