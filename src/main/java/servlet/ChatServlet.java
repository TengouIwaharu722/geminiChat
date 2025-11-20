package servlet;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.json.JSONObject;


/**
 * PythonのFlaskサーバにアクセスする
 */
@WebServlet("/ChatServlet")
public class ChatServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	/**
	 * index.jspから入力テキストを受け取り、それをPythonのFlaskに送る
	 * ※Json-20210307.jarをダウンロード必要（libに配置）
	 * 	 
	 * */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//index.jspの入力テキストを受け取る
		String question = request.getParameter("question");

		//JSONデータを作成
		JSONObject json = new JSONObject();
    json.put("question", question);

    // HttpClientでFlask APIにPOST
    HttpClient client = HttpClient.newHttpClient();
    HttpRequest httpRequest = HttpRequest.newBuilder()
        .uri(URI.create("http://127.0.0.1:5000/chat"))		//app.pyの@chatに送る
        .header("Content-Type", "application/json")
        .POST(HttpRequest.BodyPublishers.ofString(json.toString()))
        .build();

    try {
    	//Flaskサーバからのレスポンス
    	HttpResponse<String> httpResponse = client.send(httpRequest, HttpResponse.BodyHandlers.ofString());

    	// JSONからanswerを抽出
    	JSONObject responseJson = new JSONObject(httpResponse.body());
    	// 回答
    	String answer = responseJson.getString("answer");
    	//ラベル
    	String sentiment = responseJson.optString("sentiment", "不明");
    	// 評価値
    	double score = responseJson.optDouble("score", 0.0);

    	// JSPに渡す
    	request.setAttribute("answer", answer);
    	request.setAttribute("question", question);
    	request.setAttribute("sentiment", sentiment);
    	request.setAttribute("score", score);
    	RequestDispatcher dispatcher = request.getRequestDispatcher("result.jsp");
    	dispatcher.forward(request, response);

    } catch (InterruptedException e) {
      throw new ServletException("API呼び出し中に中断されました", e);
    }
  }

}
