package conduitApp.performance.createTokens;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.atomic.AtomicInteger;

import com.intuit.karate.Runner;

public class CreateTokens{

    private static final ArrayList<String> tokens = new ArrayList<>();
    private static final AtomicInteger count = new AtomicInteger();

    private static String[] emails ={
    "1test@karate.com",
    "test1@karate.com" ,
    "2test@karate.com",
    "3test@karate.com"
    };
    public static String getNextToken(){
        return tokens.get(count.getAndIncrement() % tokens.size());
    }

    public static void createAccessToken(){

        for(String email:emails){
          Map<String,Object> account = new HashMap<>();
          account.put("userEmail",email);
          account.put("userPassword","Ankit@786");

         Map<String,Object> result = Runner.runFeature( "classpath:helpers/createToken.feature",account , true);
         tokens.add(result.get("authToken").toString());
        }
    }

}