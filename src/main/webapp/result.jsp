<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
  <title>Gemini Chat</title>
  <style>
   body {
  font-family: sans-serif;
  background: #f5f5f5;
  padding: 40px;
}

.chat-container {
  max-width: 800px;
  margin: auto;
  background: white;
  padding: 30px;
  border-radius: 8px;
  box-shadow: 0 0 10px #ccc;
}

/* 吹き出しと顔グラを並べる行 */
.message-row {
  display: flex;
  align-items: flex-start;
  margin-bottom: 20px;
}

/* 顔グラの列（固定幅） */
.avatar-column {
  width: 180px;
  flex-shrink: 0;
  margin-right: 30px;
}

/* 吹き出しの列（残り幅） */
.bubble-column {
  flex: 1;
}

/* 顔グラ画像 */
.avatar {
  width: 100%;
  height: auto;
  border-radius: 8px;
  object-fit: contain;

}

/* 吹き出し共通スタイル */
.message {
  padding: 10px 15px;
  border-radius: 10px;
  line-height: 1.5;
  max-width: 100%;
}

/* ユーザーの吹き出し */
.user {
  background-color: #dcf8c6;
  text-align: right;
}

/* ジャヒー様の吹き出し */
.gemini {
  background-color: #ffffe0;
  text-align: left;
}

/* 入力欄と送信ボタン */
textarea {
  font-size: 16px;
  padding: 10px;
  border-radius: 6px;
  border: 1px solid #ccc;
  box-sizing: border-box;
  overflow-y: auto;
  margin-bottom: 20px;
  width: 100%;
  resize: vertical;
  line-height: 1.5;
}

input[type="submit"] {
  padding: 10px 20px;
  font-size: 16px;
  background: #0078D7;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

input[type="submit"]:hover {
  background: #005fa3;
}
</style>
<% 
  Object sentimentObj = request.getAttribute("sentiment");
  Object scoreObj = request.getAttribute("score");
  String sentiment = sentimentObj != null ? sentimentObj.toString() : "Neutral";
  String score = scoreObj != null ? scoreObj.toString() : "0.00";

  
  String imagePath = "images/jahi_normal.png"; // デフォルト画像

  if ("Very Positive".equals(sentiment)) {
    imagePath = "images/jahi_laugh.png";
  } else if ("Positive".equals(sentiment)) {
    imagePath = "images/jahi_normal.png";
  } else if ("Neutral".equals(sentiment)) {
    imagePath = "images/jahi_normal.png";
  } else if ("Negative".equals(sentiment)) {
    imagePath = "images/jahi_angly.png";
  } else if("Very Negative".equals(sentiment)){
	  	imagePath = "images/jahi_angly2.png";
  }
%>
  
  
</head>
<body>
  <div class="chat-container">
    <h2>ジャヒー様に聞け！</h2>

				<% if (request.getAttribute("message") != null) { %>
      <p style="color: green;"><%= request.getAttribute("message") %></p>
    <% } %>
					
<div class="message-row">
  <div class="avatar-column"></div> 
  <div class="bubble-column">
    <div class="message user">
      <strong>あなた：</strong><br />
      <%= request.getParameter("question") %>
    </div>
  </div>
</div>

    <div class="message-row">
  <div class="avatar-column">
    <img src="<%= imagePath %>" class="avatar">
  </div>
  <div class="bubble-column">
    <div class="message gemini">
      <strong>ジャヒー様：</strong><br />
      <%= request.getAttribute("answer") %>
    </div>
  </div>
</div>
<p>感情: <%= sentiment %>（信頼度: <%= score %>）</p>

    <form action="ChatServlet" method="post">
      <textarea name="question" rows="3" placeholder="質問を入力してください..."></textarea>
      <input type="submit" value="送信" />
    </form>
    
    <form action="LikeServlet" method="post">
  				<input type="hidden" name="question" value="<%= request.getAttribute("question") %>">
  				<input type="hidden" name="answer" value="<%= request.getAttribute("answer") %>">
  				<input type="submit" value="いいね" />
				</form>
    
  </div>
</body>
</html>