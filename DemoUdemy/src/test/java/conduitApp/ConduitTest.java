package conduitApp;
import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import static org.junit.jupiter.api.Assertions.*;
import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import org.apache.commons.io.FileUtils;



import org.junit.jupiter.api.Test;


class ConduitTest {
    @Test
    void testParallel() {
        Results results = Runner.path("classpath:conduitApp")
        .outputCucumberJson(true)
        .parallel(5);
        generateReport(results.getReportDir());
        assertTrue(results.getFailCount() == 0, results.getErrorMessages());
        
    
// import com.intuit.karate.junit5.Karate;

// class ConduitTest {
//      @Karate.Test
//     Karate testSample() {
//         return Karate.run().relativeTo(getClass());
//     }

//     @Karate.Test
//     Karate testTags() {
//         return Karate.run().tags("@debug").relativeTo(getClass());
//     }
  
    }
    public static void generateReport(String karateOutputPath) {
        Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[] {"json"}, true);
        List<String> jsonPaths = new ArrayList<>(jsonFiles.size());
        jsonFiles.forEach(file -> jsonPaths.add(((java.io.File) file).getAbsolutePath()));
        Configuration config = new Configuration(new File("target"), "conduitApp");
        ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
        reportBuilder.generateReports();
    }
}
