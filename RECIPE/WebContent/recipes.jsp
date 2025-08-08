<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.model.Recipe" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <meta charset="UTF-8">
    <title>레시피 목록</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; background-color: #f4f4f4; }
        .container { max-width: 800px; margin: auto; background: white; padding: 20px; border-radius: 8px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        h1 { color: #333; }
        .recipe-list { margin-top: 20px; }
        .recipe-item { background: #f9f9f9; padding: 15px; border-radius: 5px; margin-bottom: 10px; border-left: 5px solid #4CAF50; }
        .recipe-item h3 { margin: 0 0 10px 0; color: #555; }
        .recipe-item p { margin: 5px 0; color: #777; }
        .actions button, .actions a { display: inline-block; padding: 8px 12px; text-decoration: none; color: white; border-radius: 4px; border: none; cursor: pointer; }
        .edit-button { background-color: #f0ad4e; }
        .delete-button { background-color: #d9534f; }
        .back-button { display: inline-block; margin-top: 20px; padding: 10px 15px; background-color: #555; color: white; text-decoration: none; border-radius: 4px; }
        .back-button:hover { background-color: #333; }
        
        /* 다크 모드 스타일 */
        body.dark-mode { background-color: #121212; color: #e0e0e0; }
        body.dark-mode .container { background: #1e1e1e; box-shadow: 0 0 10px rgba(255,255,255,0.1); }
        body.dark-mode h1 { color: #e0e0e0; }
        body.dark-mode .recipe-item { background: #2c2c2c; border-left: 5px solid #66bb6a; }
        body.dark-mode .recipe-item h3 { color: #bbbbbb; }
        body.dark-mode .recipe-item p { color: #999; }
        body.dark-mode .edit-button { background-color: #f0ad4e; }
        body.dark-mode .delete-button { background-color: #d9534f; }
        body.dark-mode .back-button { background-color: #333; color: #e0e0e0; }
        body.dark-mode .back-button:hover { background-color: #555; }
        
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

        /* 검색 폼 스타일 */
        .search-form {
            display: flex;
            margin-bottom: 20px;
        }
        .search-form input[type="text"] {
            flex-grow: 1;
            margin-right: 10px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .search-form button {
            padding: 10px 15px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .search-form button:hover {
            background-color: #0056b3;
        }
        body.dark-mode .search-form input[type="text"] {
            background-color: #2c2c2c;
            color: #e0e0e0;
            border: 1px solid #444;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1><i class="fa-solid fa-utensils"></i>등록된 레시피 목록</h1>
        
        <form action="recipes" method="get" class="search-form">
            <input type="hidden" name="action" value="search">
            <input type="text" name="searchQuery" placeholder="레시피를 검색하세요..." value="${param.searchQuery}">
            <button type="submit">검색</button>
        </form>

        <div class="recipe-list">
            <c:choose>
                <c:when test="${not empty recipes}">
                    <c:forEach var="recipe" items="${recipes}">
                        <div class="recipe-item">
                            <h3>${recipe.recipeName}</h3>
                            <p><strong>설명:</strong> ${recipe.description}</p>
                            <p><strong>조리법:</strong> ${recipe.instructions}</p>
                            <p><strong>레시피 ID:</strong> ${recipe.recipeId}</p>
                            <div class="actions">
                                <a href="recipes?action=edit&recipeId=${recipe.recipeId}" class="edit-button">수정</a>
                                <button class="delete-button" onclick="confirmDelete(${recipe.recipeId})">삭제</button>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <p>검색 결과가 없습니다.</p>
                </c:otherwise>
            </c:choose>
        </div>
        <a href="index.jsp" class="back-button">메인 페이지로 돌아가기</a>
    </div>

    <button id="darkModeToggle" class="dark-mode-toggle">🌛</button>
    
    <script>
        // 삭제 기능 함수
        function confirmDelete(recipeId) {
            if (confirm('정말로 이 레시피를 삭제하시겠습니까?')) {
                const form = document.createElement('form');
                form.method = 'post';
                form.action = 'recipes';
                
                const actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'delete';
                form.appendChild(actionInput);
                
                const recipeIdInput = document.createElement('input');
                recipeIdInput.type = 'hidden';
                recipeIdInput.name = 'recipeId';
                recipeIdInput.value = recipeId;
                form.appendChild(recipeIdInput);

                document.body.appendChild(form);
                form.submit();
            }
        }

        // 다크 모드 토글 함수
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