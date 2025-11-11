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
      max-width: 600px;
      margin: auto;
      background: white;
      padding: 30px;
      border-radius: 8px;
      box-shadow: 0 0 10px #ccc;
    }
    .message {
      margin-bottom: 20px;
      padding: 10px 15px;
      border-radius: 10px;
      max-width: 80%;
      line-height: 1.5;
    }
    .user {
      background-color: #dcf8c6;
      text-align: right;
      margin-left: auto;
    }
    .gemini {
      background-color: #e6e6e6;
      text-align: left;
      margin-right: auto;
    }
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
</head>
<body>
  <div class="chat-container">
    <h2>Geminiとの会話</h2>

				<% if (request.getAttribute("message") != null) { %>
      <p style="color: green;"><%= request.getAttribute("message") %></p>
    <% } %>
					

    <div class="message user">
      <strong>あなた：</strong><br />
      <%= request.getParameter("question") %>
    </div>

    <div class="message gemini">
      <strong>Gemini：</strong><br />
      <%= request.getAttribute("answer") %>
    </div>

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