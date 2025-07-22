<%-- 
    Document   : quiz-handle
    Created on : Jul 18, 2025, 11:55:08 AM
    Author     : ASUS
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quiz Handle Demo</title>
    <!-- Include Font Awesome CDN -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f4f4f4;
            height: 100vh;
            overflow: hidden;
        }
        .quiz-container {
            border: 2px solid #0000ff;
            padding: 20px;
            max-width: unset;
            margin: 0 auto;
            background-color: #fff;
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .timer {
            background-color: #d3d3d3;
            padding: 5px 10px;
            border-radius: 5px;
        }
        .question-number {
            font-weight: bold;
            color: #fff;
            background-color: #444;
            padding: 5px 10px;
            display: inline-block;
        }
        .question-id {
            font-size: 0.9em;
            color: #666;
        }
        .question-text {
            margin: 10px 0;
        }
        .options {
            list-style: none;
            padding: 0;
        }
        .option {
            display: flex;
            align-items: center;
            margin: 10px 0;
        }
        .option input[type="radio"] {
            margin-right: 10px;
        }
        .buttons {
            margin-top: 7%;
            display: flex;
            justify-content: flex-end;
            gap: 10px;
        }
        .button {
            padding: 10px 20px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            display: flex;
            align-items: center;
            gap: 5px;
        }
        .button-peek {
            background-color: #f0f0f0;
        }
        .button-mark {
            background-color: #d4edda;
        }
        .footer-buttons {
            margin-top: 20px;
            display: flex;
            justify-content: space-between;
        }
        .button-review {
            background-color: #c3e6cb;
            padding: 10px 20px;
        }
        .nav-buttons {
            display: flex;
            gap: 10px;
        }
        .button-prev, .button-next {
            background-color: #c3e6cb;
            padding: 10px 20px;
        }
        .popup {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: #fff;
            padding: 20px;
            border: 2px solid #28a745;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.3);
            max-width: 600px;
            width: 90%;
            max-height: 80vh;
            overflow-y: auto;
            z-index: 1001;
            text-align: center;
        }
        .popup.show {
            display: block;
        }
        .popup-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }
        .close-btn {
            background: none;
            border: none;
            font-size: 1.2em;
            cursor: pointer;
        }
        .tabs {
            display: flex;
            gap: 5px;
            margin-bottom: 10px;
            justify-content: center;
        }
        .tab {
            padding: 5px 10px;
            border: 1px solid #ccc;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 5px;
            background-color: #e9ecef;
        }
        .tab.active {
            background-color: #28a745;
            color: #fff;
        }
        .question-grid {
            display: grid;
            grid-template-columns: repeat(10, 1fr);
            gap: 5px;
            margin-top: 10px;
        }
        .question-btn {
            padding: 5px;
            border: 1px solid #ccc;
            background-color: #f8f9fa;
            cursor: pointer;
            text-align: center;
        }
        .question-btn.answered {
            background-color: #d3d3d3;
        }
        .question-btn.unanswered {
            background-color: #fff;
        }
        .question-btn.marked {
            background-color: #ffa500;
        }
        .score-exam {
            margin-top: 10px;
            padding: 10px 20px;
            background-color: #28a745;
            color: #fff;
            border: none;
            cursor: pointer;
        }
        .confirmation-popup {
            border: 2px solid #dc3545;
            text-align: center;
        }
        .confirmation-buttons {
            margin-top: 20px;
            display: flex;
            justify-content: center;
            gap: 10px;
        }
        .backdrop {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            backdrop-filter: blur(5px);
            z-index: 1000;
        }
        .backdrop.show {
            display: block;
        }
    </style>
</head>
<body>
    <div class="quiz-container">
        <div class="header">
            <span class="question-number">5)</span>
            <div>
                <span>5 / 20</span>
                <span class="timer">00:10:34</span>
            </div>
        </div>
        <div class="question-id">Question ID: 647</div>
        <div class="question-text">
            What is the main benefit of conducting value analysis during a project?
        </div>
        <ul class="options">
            <li class="option"><input type="radio" name="answer" value="A"> A. Increase project timeline</li>
            <li class="option"><input type="radio" name="answer" value="B"> B. Enhance team morale</li>
            <li class="option"><input type="radio" name="answer" value="C"> C. Reduce costs while maintaining quality</li>
            <li class="option"><input type="radio" name="answer" value="D"> D. Complicate project processes</li>
        </ul>
        <div class="buttons">
            <button class="button button-peek" onclick="showPopup('answerPopup')">Peek at Answer</button>
            <button class="button button-mark"><i class="fas fa-bookmark"></i> Mark for Review</button>
        </div>
        <div class="footer-buttons">
            <button class="button button-review" onclick="showPopup('reviewPopup')">Review Progress</button>
            <div class="nav-buttons">
                <button class="button button-prev">Previous</button>
                <button class="button button-next" onclick="showConfirmation()">Next</button>
            </div>
        </div>
    </div>

    <!-- Backdrop -->
    <div class="backdrop" id="backdrop"></div>

    <!-- Answer Popup -->
    <div class="popup" id="answerPopup">
        <p><strong>Correct Answer:</strong> C</p>
        <p><strong>Explanation:</strong> Value analysis focuses on reducing costs while maintaining or improving quality.</p>
        <div class="confirmation-buttons">
            <button class="button" onclick="hidePopup('answerPopup')">Close</button>
        </div>
    </div>

    <!-- Review Progress Popup -->
    <div class="popup" id="reviewPopup">
        <div class="popup-header">
            <h3>Review Progress</h3>
            <button class="close-btn" onclick="hidePopup('reviewPopup')">×</button>
        </div>
        <p>Review before scoring exam.</p>
        <div class="tabs">
            <div class="tab active" data-tab="all"><i class="fas fa-list"></i> ALL QUESTIONS</div>
            <div class="tab" data-tab="unanswered"><i class="fas fa-square" style="color: #fff;"></i> UNANSWERED</div>
            <div class="tab" data-tab="marked"><i class="fas fa-bookmark" style="color: #ffa500;"></i> MARKED</div>
            <div class="tab" data-tab="answered"><i class="fas fa-square" style="color: #d3d3d3;"></i> ANSWERED</div>
        </div>
        <div class="question-grid" id="questionGrid">
            <!-- Dynamically populated with 20 questions -->
            <script>
                const grid = document.getElementById('questionGrid');
                for (let i = 1; i <= 20; i++) {
                    const btn = document.createElement('div');
                    btn.className = 'question-btn';
                    btn.textContent = i;
                    // Simulate status: answered (every 7th), marked (every 5th), unanswered (others)
                    if (i % 7 === 0) btn.classList.add('answered');
                    else if (i % 5 === 0) btn.classList.add('marked');
                    else btn.classList.add('unanswered');
                    grid.appendChild(btn);
                }
            </script>
        </div>
        <div class="confirmation-buttons">
            <button class="score-exam" onclick="showConfirmation()">SCORE EXAM NOW</button>
        </div>
    </div>

    <!-- Confirmation Popup -->
    <div class="popup confirmation-popup" id="confirmationPopup">
        <h3>Confirm Submission</h3>
        <p id="confirmationMessage">Are you sure you want to submit the exam?</p>
        <div class="confirmation-buttons">
            <button class="button" onclick="hidePopup('confirmationPopup')">Back</button>
            <button class="button" style="background-color: #dc3545; color: #fff;" onclick="submitExam()">Score Exam</button>
        </div>
    </div>

    <script>
        let currentPopup = null;
        let answeredCount = 5; // Simulated count of answered questions (e.g., 5 out of 20)

        function showPopup(type) {
            hidePopup();
            currentPopup = document.getElementById(type);
            const backdrop = document.getElementById('backdrop');
            if (currentPopup) {
                currentPopup.classList.add('show');
                backdrop.classList.add('show');
            } else {
                console.error('Popup with ID ' + type + ' not found');
            }
        }

        function hidePopup(type) {
            if (currentPopup) {
                currentPopup.classList.remove('show');
                const backdrop = document.getElementById('backdrop');
                backdrop.classList.remove('show');
                currentPopup = null;
            }
        }

        function switchTab(tab) {
            console.log('Switching to tab: ' + tab); // Debug log
            const tabs = document.querySelectorAll('.tab');
            tabs.forEach(t => t.classList.remove('active'));
            const activeTab = document.querySelector(`.tab[data-tab="${tab}"]`);
            if (activeTab) {
                activeTab.classList.add('active');
            } else {
                console.error('Tab with data-tab="' + tab + '" not found');
            }

            const gridItems = document.querySelectorAll('.question-btn');
            gridItems.forEach(item => {
                item.style.display = 'block'; // Show all by default
                if (tab === 'unanswered') {
                    item.style.display = item.classList.contains('unanswered') ? 'block' : 'none';
                } else if (tab === 'marked') {
                    item.style.display = item.classList.contains('marked') ? 'block' : 'none';
                } else if (tab === 'answered') {
                    item.style.display = item.classList.contains('answered') ? 'block' : 'none';
                }
            });
        }

        function showConfirmation() {
            hidePopup();
            currentPopup = document.getElementById('confirmationPopup');
            const backdrop = document.getElementById('backdrop');
            currentPopup.classList.add('show');
            backdrop.classList.add('show');

            const message = document.getElementById('confirmationMessage');
            if (answeredCount === 0) {
                message.textContent = "You have not answered any questions.";
            } else if (answeredCount < 20) {
                message.textContent = `${answeredCount} of 20 Questions Answered.`;
            } else {
                message.textContent = "All 20 questions have been answered. Are you sure you want to submit the exam?";
            }
        }

        function submitExam() {
            hidePopup();
            alert("Exam submitted! Redirecting to Quiz Result screen."); // Simulate submission
        }

        // Add event listeners to tabs after DOM is loaded
        document.addEventListener('DOMContentLoaded', () => {
            const tabs = document.querySelectorAll('.tab');
            tabs.forEach(tab => {
                tab.addEventListener('click', () => {
                    const tabType = tab.getAttribute('data-tab');
                    switchTab(tabType);
                });
            });
        });
    </script>
</body>
</html>