package stubs;

import java.io.IOException;
import java.util.List;
import java.util.Arrays;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

public class LogMonthMapper extends Mapper<LongWritable, Text, Text, Text> {
	public static List<String> months = Arrays.asList("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec");
  /**
   * Example input line:
   * 96.7.4.14 - - [24/Apr/2011:04:20:11 -0400] "GET /cat.jpg HTTP/1.1" 200 12433
   *
   */
  @Override
  public void map(LongWritable key, Text value, Context context)
      throws IOException, InterruptedException {
    
	  String[] input = value.toString().split(" ");
	  if (input.length > 3){
		  String IP = input[0];
		  String[] date = input[3].split("/");
		  
		  if (date.length > 1){
			  String month = date[1];
			  if(months.contains(month))
				  context.write(new Text(IP), new Text (month));
		  }
	  }
  }
}
