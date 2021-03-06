package edu.sjsu.conference.uploadfiles;

import java.io.File;
import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.List;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpPut;
import org.apache.http.entity.InputStreamEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import edu.sjsu.conference.controller.LoginPageController;
import edu.sjsu.conference.util.ClassConstant;


public class DropboxTest {

	public static String sharedURL = null;
	
	@Autowired
	public static void uploadDocuments(String code,File selectedFile)
	{
		
		HttpClient client = new DefaultHttpClient();

		try {
			
			HttpPost post = new HttpPost(
					"https://api.dropbox.com/1/oauth2/token");
			List<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>(1);
			nameValuePairs.add(new BasicNameValuePair("grant_type",
					"authorization_code"));
			nameValuePairs.add(new BasicNameValuePair("redirect_uri",
					"https://"+ClassConstant.REDIRECT_URI+"/organize-your-conference/dropbox"));
			nameValuePairs.add(new BasicNameValuePair("client_id",
					"vqtzquh9kh5cph6"));
			nameValuePairs.add(new BasicNameValuePair("client_secret",
					"5vpw8kpsjy5ky5t"));
			nameValuePairs.add(new BasicNameValuePair("code", code));

			post.setEntity(new UrlEncodedFormEntity(nameValuePairs));
			HttpResponse response = client.execute(post);

			if (response != null && response.getStatusLine().getStatusCode() == 200) {
				
				String json = EntityUtils.toString(response.getEntity());
				JSONObject jsobObj = new JSONObject(json);
				String accessToken = jsobObj.getString("access_token");
				System.out.println("jsobObj:: " + jsobObj);
				System.out.println("Access  Token :: " + accessToken);
				
				HttpGet info  = new HttpGet ("https://api.dropbox.com/1/account/info?access_token="+accessToken);
				response = client.execute(info);
				String accInfo = EntityUtils.toString(response.getEntity());
				JSONObject jsobObjInfo = new JSONObject(accInfo);
				System.out.println("jsobObj:: " + jsobObjInfo);
								
				File inputFile = new File(selectedFile.getAbsolutePath());
				FileInputStream inputStream = new FileInputStream(inputFile);
				System.out.println("inputFile length :: " + inputFile.length() + " " +inputFile.getName());
				
				HttpPut putFile = new HttpPut("https://api-content.dropbox.com/1/files_put?root="+"dropbox"+"&path="+ "Public/"+ LoginPageController.name+"/"+inputFile.getName()+"&oauth_consumer_key="+"vqtzquh9kh5cph6"+"&oauth_signature=" +"5vpw8kpsjy5ky5t" + "&access_token="+accessToken);
				putFile.setEntity(new InputStreamEntity(inputStream,inputFile.length()));
				HttpResponse responsePut = client.execute(putFile);
				String fileInfo = EntityUtils.toString(responsePut.getEntity());
				JSONObject jsobObjFile = new JSONObject(fileInfo);
				
				System.out.println("jsobObj:: " + jsobObjFile);
							
				HttpPost getLink = new HttpPost("https://api.dropbox.com/1/shares/?root="+"dropbox"+"&path="+"Public/"+ LoginPageController.name+"/"+"&oauth_consumer_key="+"vqtzquh9kh5cph6"+"&oauth_signature=" +"5vpw8kpsjy5ky5t" + "&access_token="+accessToken);
				HttpResponse responsePost = client.execute(getLink);
				String linkInfo = EntityUtils.toString(responsePost.getEntity());
				JSONObject jsobObjLink = new JSONObject(linkInfo);
				sharedURL = jsobObjLink.getString("url");
				System.out.println("jsobObj link:: " + jsobObjLink + "Link:: " +sharedURL );
				inputStream.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
}

