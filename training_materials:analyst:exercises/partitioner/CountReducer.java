package stubs;

import java.io.IOException;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Reducer;

public class CountReducer extends Reducer<Text, Text, Text, IntWritable> {
  @SuppressWarnings("unused")
  @Override
  public void reduce(Text key, Iterable<Text> values, Context context)
      throws IOException, InterruptedException {
	  int cnt = 0;
	  for(Text val : values){
		  cnt += 1;
	  }
	  context.write(key, new IntWritable(cnt));
  }
}
