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
 * いいね、を押された時の処理
 */
@WebServlet("/LikeServlet")
public class LikeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * いいね送信
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String question = request.getParameter("question");
    String answer = request.getParameter("answer");

    // JSONデータを作成
    JSONObject json = new JSONObject();
    json.put("question", question);
    json.put("answer", answer);

    // HttpClientでFlaskの /add_history にPOST
    HttpClient client = HttpClient.newHttpClient();
    HttpRequest httpRequest = HttpRequest.newBuilder()
            .uri(URI.create("http://127.0.0.1:5000/add_history"))
            .header("Content-Type", "application/json")
            .POST(HttpRequest.BodyPublishers.ofString(json.toString()))
            .build();

    try {
      client.send(httpRequest, HttpResponse.BodyHandlers.ofString());

      // 成功レスポンスを確認（必要に応じて処理）
      request.setAttribute("question", question); 
      request.setAttribute("answer", answer);
      
      request.setAttribute("message", "履歴に追加しました！");
      RequestDispatcher dispatcher = request.getRequestDispatcher("result.jsp");
      dispatcher.forward(request, response);

    } catch (InterruptedException e) {
      throw new ServletException("履歴送信中に中断されました", e);
    }
    
	}

}
