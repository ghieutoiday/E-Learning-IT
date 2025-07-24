<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Questions List</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #f8f9fa;
            }
            .container {
                background-color: #fff;
                padding: 2rem;
                border-radius: 0.5rem;
                box-shadow: 0 0.125rem 0.25rem rgba(0,0,0,0.075);
            }
            /* Modal content styles */
            .modal-content {
                border-radius: 8px;
            }
            .modal-body {
                padding: 30px;
                text-align: center;
            }
            .form-group {
                margin-bottom: 15px;
                text-align: left;
            }
            .form-group label {
                font-weight: bold;
                color: #555;
            }
            .form-group input[type="file"] {
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
            .button-group button[type="submit"] {
                background-color: #007bff;
                color: white;
            }
            .button-group button[type="submit"]:hover {
                background-color: #0056b3;
            }
            .button-group .download-link {
                background-color: #28a745;
                color: white;
            }
            .button-group .download-link:hover {
                background-color: #218838;
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
                position: absolute;
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
                z-index: 1000;
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
        <div class="container mt-4">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h3>Questions List</h3>
                <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#importModal">Import Questions</button>
            </div>

            <form action="questionList" method="get" class="p-3 border rounded bg-light mb-4">
                <div class="row g-3">
                    <div class="col-md-3">
                        <label class="form-label">Course</label>
                        <select name="courseId" class="form-select">
                            <option value="0">All Courses</option>
                            <c:forEach var="c" items="${allCourses}">
                                <option value="${c.courseID}" ${c.courseID == selectedCourseId ? 'selected' : ''}>${c.courseName}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Dimension</label>
                        <select name="dimensionId" class="form-select">
                            <option value="0">All Dimensions</option>
                            <c:forEach var="dim" items="${allDimensions}">
                                <option value="${dim.dimensionID}" ${dim.dimensionID == selectedDimensionId ? 'selected' : ''}>${dim.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <label class="form-label">Level</label>
                        <select name="level" class="form-select">
                            <option value="0">All Levels</option>
                            <c:forEach var="i" begin="1" end="5">
                                <option value="${i}" ${i == selectedLevel ? 'selected' : ''}>Level ${i}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <label class="form-label">Status</label>
                        <select name="status" class="form-select">
                            <option value="">All</option>
                            <option value="Active" ${'Active' eq selectedStatus ? 'selected' : ''}>Active</option>
                            <option value="Inactive" ${'Inactive' eq selectedStatus ? 'selected' : ''}>Inactive</option>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Search by Content</label>
                        <input type="text" name="search" class="form-control" value="${searchValue}" placeholder="Enter content to search...">
                    </div>
                    <div class="col-md-2 d-flex align-items-end">
                        <button type="submit" class="btn btn-primary w-100">Apply Filter</button>
                    </div>
                </div>
            </form>

            <table class="table table-hover table-bordered">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Content</th>
                        <th>Course</th>
                        <th>Dimension</th>
                        <th>Level</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="q" items="${questions}">
                        <tr>
                            <td>${q.questionID}</td>
                            <td><c:out value="${q.content}" /></td>
                            <td>
                                <c:forEach var="course" items="${allCourses}">
                                    <c:if test="${q.courseID == course.courseID}">
                                        ${course.courseName}
                                    </c:if>
                                </c:forEach>
                            </td>
                            <td>
                                <c:forEach var="dimension" items="${allDimensions}">
                                    <c:if test="${q.dimensionID == dimension.dimensionID}">
                                        ${dimension.name}
                                    </c:if>
                                </c:forEach>
                            </td>
                            <td>${q.level}</td>
                            <td>
                                <span class="badge ${q.status == 'Active' ? 'bg-success' : 'bg-secondary'}">${q.status}</span>
                            </td>
                            <td>
                                <a href="questioncontroller?action=edit&questionID=${q.questionID}" class="btn btn-sm btn-info">Detail</a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty questions}">
                        <tr><td colspan="7" class="text-center">No questions found.</td></tr>
                    </c:if>
                </tbody>
            </table>

            <nav>
                <ul class="pagination justify-content-center">
                    <li class="page-item ${currentPage <= 1 ? 'disabled' : ''}">
                        <a class="page-link" href="questionList?page=${currentPage - 1}&courseId=${selectedCourseId}&dimensionId=${selectedDimensionId}&level=${selectedLevel}&status=${selectedStatus}&search=${searchValue}">Previous</a>
                    </li>
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                            <a class="page-link" href="questionList?page=${i}&courseId=${selectedCourseId}&dimensionId=${selectedDimensionId}&level=${selectedLevel}&status=${selectedStatus}&search=${searchValue}">${i}</a>
                        </li>
                    </c:forEach>
                    <li class="page-item ${currentPage >= totalPages ? 'disabled' : ''}">
                        <a class="page-link" href="questionList?page=${currentPage + 1}&courseId=${selectedCourseId}&dimensionId=${selectedDimensionId}&level=${selectedLevel}&status=${selectedStatus}&search=${searchValue}">Next</a>
                    </li>
                </ul>
            </nav>
        </div>

        <!-- Import Questions Modal -->
        <div class="modal fade" id="importModal" tabindex="-1" aria-labelledby="importModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="importModalLabel">Nhập Câu Hỏi Từ File</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
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
                </div>
            </div>
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

        <!-- Bootstrap JS and Popper.js -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"></script>
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
                if (!message) return;

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
                if (e.key === 'Enter') sendMessage();
            });
        </script>
    </body>
</html>