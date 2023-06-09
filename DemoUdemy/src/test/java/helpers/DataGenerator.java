package helpers;

import com.github.javafaker.Faker;

import net.minidev.json.JSONObject;

public class DataGenerator{

    
    public static String getRandomEmail(){
     
        Faker faker = new Faker();
    
     String email = faker.name().firstName().toLowerCase() + faker.random().nextInt(0, 100)
+ "@test.com";
return email;
    }
    public static String getRandomUsername(){
        Faker faker = new Faker();
        String userName = faker.name().username();
        return userName;
    }

//By using no static method 
public  String getRandomUsername2(){
    Faker faker = new Faker();
    String userName = faker.name().username();
    return userName;
}
public static JSONObject getRandomArticleValues(){
    Faker faker = new Faker();
    String title = faker.gameOfThrones().character();
    String description = faker.gameOfThrones().city();
    String body = faker.gameOfThrones().quote();
    JSONObject json = new JSONObject();
    json.put("title", title);
    json.put("description", description);
    json.put("body", body);
    return json;

}
public static JSONObject getRandomComment(){
    Faker faker = new Faker();
    String body = faker.gameOfThrones().quote();
    JSONObject json = new JSONObject();
    json.put("body", body);
    return json;
}

}