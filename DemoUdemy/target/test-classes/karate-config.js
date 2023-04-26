function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    apiUrl: 'https://api.realworld.io/api/'
  }
  if (env == 'dev') {
    config.userEmail = 'test1@karate.com'
    config.userPassword = 'Ankit@786'
  } 
  if (env == 'qa') {
    config.userEmail = 'test2@karate.com'
    config.userPassword = 'Ankit@687'
  }
var accessToken = karate.callSingle('classpath:helpers/createToken.feature',config).authToken
karate.configure('headers',{Authorization:'Token '+ accessToken})

  return config;
}