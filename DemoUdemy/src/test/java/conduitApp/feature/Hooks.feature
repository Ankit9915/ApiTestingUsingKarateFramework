Feature: Hooks

    Background: hoooks
        # * def result = callonce read('classpath:helpers/Dummy.feature') 
        # * def username = result.username

        #After hooks
        * configure afterScenario = function() { karate.call('classpath:helpers/Dummy.feature') }
        * configure afterFeature = 
        """
        function(){
            karate.log("Hello Karate framework");
        }

        """

    Scenario: First Scenario 
       # * print username
        * print 'This is first Scenario'

    Scenario: Second Scenario 
      #  * print username
        * print 'This is second Scenario'    