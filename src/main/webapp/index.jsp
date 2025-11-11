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
    <h2>Geminiに質問してみよう</h2>
    <form action="ChatServlet" method="post">
      <textarea name="question" rows="5" placeholder="質問を入力してください..."></textarea>
      <input type="submit" value="送信" />
    </form>
  </div>
</body>
</html>