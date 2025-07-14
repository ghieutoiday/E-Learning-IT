<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Nhập Câu Hỏi</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                padding: 20px;
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
            }
            .container {
                background-color: #fff;
                padding: 30px;
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                width: 400px;
                text-align: center;
            }
            h2 {
                color: #333;
                margin-bottom: 20px;
            }
            .form-group {
                margin-bottom: 15px;
                text-align: left;
            }
            label {
                font-weight: bold;
                color: #555;
            }
            input[type="file"] {
                width: calc(100% - 22px);
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 4px;
                background-color: #f9f9f9;
            }
            .button-group {
                display: flex;
                justify-content: space-between;
                margin-top: 20px;
            }
            .button-group button, .button-group a {
                padding: 10px 20px;
                border: none;
                border-radius: 5px;
                font-size: 16px;
                cursor: pointer;
                text-decoration: none;
            }
            button[type="submit"] {
                background-color: #007bff;
                color: white;
            }
            button[type="submit"]:hover {
                background-color: #0056b3;
            }
            .download-link {
                background-color: #28a745;
                color: white;
            }
            .download-link:hover {
                background-color: #218838;
            }
            .message {
                margin-top: 20px;
                padding: 10px;
                border-radius: 4px;
                font-weight: bold;
            }
            .success {
                background-color: #d4edda;
                color: #155724;
            }
            .error {
                background-color: #f8d7da;
                color: #721c24;
            }

            /* Chatbot styles */
            .chatbot-icon {
                position: fixed;
                bottom: 30px;
                right: 30px;
                width: 60px;
                height: 60px;
                background-color: #4CAF50;
                color: white;
                border-radius: 50%;
                display: flex;
                justify-content: center;
                align-items: center;
                font-size: 2em;
                cursor: pointer;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
                z-index: 1000;
            }
            .chat-container {
                position: fixed;
                bottom: 100px;
                right: 30px;
                width: 350px;
                height: 450px;
                background-color: #fff;
                border-radius: 10px;
                box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
                display: none;
                flex-direction: column;
                transform: scale(0);
                transform-origin: bottom right;
                z-index: 999;
            }
            .chat-container.open {
                display: flex;
                transform: scale(1);
            }
            .chat-header {
                background-color: #4CAF50;
                color: white;
                padding: 15px;
                text-align: center;
                cursor: grab;
            }
            .chat-messages {
                flex-grow: 1;
                padding: 15px;
                overflow-y: auto;
                background-color: #e5ddd5;
            }
            .chat-input {
                display: flex;
                padding: 10px;
                border-top: 1px solid #eee;
            }
            .chat-input input[type="text"] {
                flex-grow: 1;
                padding: 8px;
                border-radius: 20px;
                border: 1px solid #ccc;
            }
            .chat-input button {
                background-color: #4CAF50;
                color: white;
                border: none;
                padding: 8px 15px;
                border-radius: 20px;
                margin-left: 10px;
            }
            .message {
                margin-bottom: 10px;
                padding: 10px;
                border-radius: 10px;
                max-width: 80%;
            }
            .message.user {
                background-color: #dcf8c6;
                align-self: flex-end;
            }
            .message.bot {
                background-color: white;
                border: 1px solid #ccc;
                align-self: flex-start;
            }
            .prompt-suggestions {
                display: flex;
                overflow-x: auto;
                gap: 10px;
                padding: 10px;
                background: #f8f8f8;
                border-top: 1px solid #ddd;
            }
            .prompt-suggestion-button {
                padding: 8px 12px;
                border: 1px solid #007bff;
                border-radius: 20px;
                background-color: #eaf5ff;
                color: #007bff;
                cursor: pointer;
                white-space: nowrap;
            }
            .prompt-suggestion-button:hover {
                background-color: #007bff;
                color: white;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Nhập Câu Hỏi Từ File</h2>
            <form action="questioncontroller" method="post" enctype="multipart/form-data">
                <input type="hidden" name="courseIdParam" value="${param.courseId != null ? param.courseId : 1}" />
                <input type="hidden" name="lessonIdParam" value="${param.lessonId != null ? param.lessonId : 4}" />
                <div class="form-group">
                    <label for="file">Chọn file TXT hoặc CSV để import:</label>
                    <input type="file" id="file" name="file" accept=".txt,.csv" required />
                </div>
                <div class="button-group">
                    <button type="submit" name="action" value="import">Import Questions</button>
                    <a class="download-link" download href="${pageContext.request.contextPath}/templates/sample_template_no_course_lesson.txt">Tải mẫu TXT</a>
                </div>
            </form>
        </div>

        <!-- Chatbot icon & container -->
        <div class="chatbot-icon" id="chatbotIcon">💬</div>
        <div class="chat-container" id="chatContainer">
            <div class="chat-header" id="chatHeader">Chatbot Tư Vấn Khóa Học</div>
            <div class="chat-messages" id="chatMessages">
                <div class="message bot">Chào bạn! Tôi là Chatbot tư vấn khóa học. Bạn muốn tìm hiểu khóa học nào?</div>
            </div>
            <div class="prompt-suggestions" id="promptSuggestions"></div>
            <div class="chat-input">
                <input type="text" id="userInput" placeholder="Nhập tin nhắn của bạn...">
                <button onclick="sendMessage()">Gửi</button>
            </div>
        </div>

        <script>
            const chatbotIcon = document.getElementById('chatbotIcon');
            const chatContainer = document.getElementById('chatContainer');
            const chatMessages = document.getElementById('chatMessages');
            const promptSuggestionsContainer = document.getElementById('promptSuggestions');
            const userInput = document.getElementById('userInput');

            chatbotIcon.addEventListener('click', () => {
                chatContainer.classList.toggle('open');
                if (chatContainer.classList.contains('open')) {
                    scrollToBottom();
                    displayPromptSuggestions();
                } else {
                    promptSuggestionsContainer.innerHTML = '';
                }
            });

            function scrollToBottom() {
                chatMessages.scrollTop = chatMessages.scrollHeight;
            }

            function addMessage(text, sender) {
                const msg = document.createElement('div');
                msg.classList.add('message', sender);
                msg.innerText = text;
                chatMessages.appendChild(msg);
                scrollToBottom();
            }

            function displayPromptSuggestions() {
                const prompts = [
                    "2 câu hỏi multiple-choice",
                    "2 câu hỏi true/false",
                    "4 câu hỏi từ bài học",
                    "5 câu hỏi kiểm tra nhanh"
                ];

                promptSuggestionsContainer.innerHTML = '';
                prompts.forEach(p => {
                    const btn = document.createElement('button');
                    btn.className = 'prompt-suggestion-button';
                    btn.textContent = p;
                    btn.onclick = () => {
                        userInput.value = p;
                        sendMessage();
                    }
                    promptSuggestionsContainer.appendChild(btn);
                });
            }

            async function sendMessage() {
                const message = userInput.value.trim();
                if (!message)
                    return;

                addMessage(message, 'user');
                userInput.value = '';

                try {
                    const response = await fetch('<%= request.getContextPath()%>/chat-question-ai', {
                        method: 'POST',
                        headers: {'Content-Type': 'application/json'},
                        body: JSON.stringify({
                            message: message,
                            courseId: parseInt(document.querySelector('input[name="courseIdParam"]').value),
                            lessonId: parseInt(document.querySelector('input[name="lessonIdParam"]').value)
                        })
                    });
                    const data = await response.json();
                    addMessage(data.response, 'bot');
                    displayPromptSuggestions();
                } catch (e) {
                    addMessage('Có lỗi xảy ra, vui lòng thử lại sau.', 'bot');
                    console.error(e);
                }
            }

            userInput.addEventListener('keypress', e => {
                if (e.key === 'Enter')
                    sendMessage();
            });
        </script>
    </body>
</html>
