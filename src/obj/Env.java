package obj;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

public class Env{
	private String id;
	private String pwd;
	
	public Env() {
		try {
			String path = Env.class.getResource("").getPath();
		      BufferedReader in = new BufferedReader(new FileReader(path + "../env.txt"));
		      String s;

		      while ((s = in.readLine()) != null) {
		    	  String[] temp = s.split("\\s");
		    	  if(temp[0].equals("id")) {
		    		  this.id = temp[1];
		    	  }else if(temp[0].equals("pwd")) {
		    		  this.pwd = temp[1];
		    	  }
		      }
		      in.close();
		      ////////////////////////////////////////////////////////////////
		    } catch (IOException e) {
		        System.err.println(e); // 에러가 있다면 메시지 출력
		        System.exit(1);
		    }
	}
	
	public String getEnvId() {
		return this.id;
	}
	
	public String getEnvPwd() {
		return this.pwd;
	}
}