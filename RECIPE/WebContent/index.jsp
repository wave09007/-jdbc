<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.model.Recipe" %>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <meta charset="UTF-8">
    <title>레시피북</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; background-color: #f4f4f4; }
        .container { max-width: 800px; margin: auto; background: white; padding: 20px; border-radius: 8px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        h1, h2 { color: #333; }
        form { margin-bottom: 20px; }
        input[type=text], textarea { width: 100%; padding: 10px; margin: 8px 0; display: inline-block; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; }
        input[type=submit] { width: 100%; background-color: #4CAF50; color: white; padding: 14px 20px; margin: 8px 0; border: none; border-radius: 4px; cursor: pointer; }
        input[type=submit]:hover { background-color: #45a049; }
        .view-recipes-button { display: inline-block; padding: 10px 15px; background-color: #008CBA; color: white; text-decoration: none; border-radius: 4px; }
        .view-recipes-button:hover { background-color: #007bb5; }

        /* 다크 모드 스타일 */
        body.dark-mode { background-color: #121212; color: #e0e0e0; }
        body.dark-mode .container { background: #1e1e1e; box-shadow: 0 0 10px rgba(255,255,255,0.1); }
        body.dark-mode h1, body.dark-mode h2 { color: #e0e0e0; }
        body.dark-mode input[type=text], body.dark-mode textarea { background-color: #2c2c2c; color: #e0e0e0; border: 1px solid #444; }
        body.dark-mode input[type=submit] { background-color: #4CAF50; color: white; }
        body.dark-mode .view-recipes-button { background-color: #333; color: #e0e0e0; }
        body.dark-mode .view-recipes-button:hover { background-color: #555; }
        
        /* 다크 모드 토글 버튼 스타일 */
        .dark-mode-toggle {
            position: fixed;
            bottom: 20px;
            right: 20px;
            padding: 15px;
            font-size: 24px;
            background-color: #333;
            color: white;
            border: none;
            border-radius: 50%;
            cursor: pointer;
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
            z-index: 1000;
            transition: background-color 0.3s;
        }

        .dark-mode-toggle:hover {
            background-color: #555;
        }

        body.dark-mode .dark-mode-toggle {
            background-color: #f0f0f0;
            color: #333;
            box-shadow: 0 4px 8px rgba(255,255,255,0.2);
        }
    </style>
</head>
<body>
    <div class="container">
        <h1><i class="fa-solid fa-utensils"></i>레시피북</h1>
        <h2>새로운 레시피 추가</h2>
        <form action="recipes" method="post">
            <label for="recipeName">레시피 이름:</label>
            <input type="text" id="recipeName" name="recipeName" required>
            <label for="description">간략한 설명:</label>
            <textarea id="description" name="description"></textarea>
            <label for="instructions">조리법:</label>
            <textarea id="instructions" name="instructions" rows="5"></textarea>
            <input type="submit" value="레시피 등록">
        </form>
        <hr>
        <a href="recipes" class="view-recipes-button">레시피 목록 보기</a>
    </div>

    <button id="darkModeToggle" class="dark-mode-toggle">🌙</button>

    <script>
        const darkModeToggle = document.getElementById('darkModeToggle');

        function toggleDarkMode() {
            const body = document.body;
            body.classList.toggle('dark-mode');
            
            if (body.classList.contains('dark-mode')) {
                localStorage.setItem('darkMode', 'enabled');
                darkModeToggle.textContent = '🌞';
            } else {
                localStorage.setItem('darkMode', 'disabled');
                darkModeToggle.textContent = '🌛';
            }
        }

        document.addEventListener('DOMContentLoaded', (event) => {
            if (localStorage.getItem('darkMode') === 'enabled') {
                document.body.classList.add('dark-mode');
                darkModeToggle.textContent = '🌞';
            } else {
                darkModeToggle.textContent = '🌛';
            }

            darkModeToggle.addEventListener('click', toggleDarkMode);
        });
    </script>
</body>
</html>