package helpers;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;

import net.minidev.json.JSONObject;

public class DbHandler{

    private static String connectionUrl = "jdbc:mysql://localhost:3306;database=Qadbt;user=root;password= root";

    public static void addNewJobWithName(String jobName){

        try(Connection connect = DriverManager.getConnection(connectionUrl)){
            connect.createStatement().execute("insert into qadbt.employeeinfo  values('"+jobName+"',4,'ukp',43)");

        }
        catch(SQLException e){
            e.printStackTrace();

        }
    }
        
        public static JSONObject getAgeAndId(String jobName){
          JSONObject json = new JSONObject();

          try(Connection connect = DriverManager.getConnection(connectionUrl)){
          ResultSet rs=  connect.createStatement().executeQuery("SELECT * FROM qadbt.employeeinfo where name ='"+jobName+"'");
          rs.next();
          json.put("id",rs.getString("id"));
          json.put("age",rs.getString("age"));

        }
        catch(SQLException e){
            e.printStackTrace();

        }
          return json;
        }
    }
