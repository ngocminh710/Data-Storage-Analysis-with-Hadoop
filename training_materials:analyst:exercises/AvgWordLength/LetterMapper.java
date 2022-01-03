package stubs;
import java.io.IOException;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

public class LetterMapper extends Mapper<LongWritable, Text, Text, IntWritable> {

  @Override
  public void map(LongWritable key, Text value, Context context)
      throws IOException, InterruptedException {
	  for (String word:value.toString().split("\\W")){
		  if(word.length() > 0)
			  context.write(new Text(String.valueOf(word.charAt(0))), new IntWritable(word.length()));
	  }
  }
}
