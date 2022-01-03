package stubs;
import java.io.IOException;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

public class LogFileMapper extends Mapper<LongWritable, Text, Text, IntWritable> {

  @Override
  public void map(LongWritable key, Text value, Context context)
      throws IOException, InterruptedException {
	  String str = value.toString();
	  String IP = str.substring(0, str.indexOf("")).trim();
	  if(IP.length() > 0)
		  context.write(new Text(IP), new IntWritable(1));
  }
}