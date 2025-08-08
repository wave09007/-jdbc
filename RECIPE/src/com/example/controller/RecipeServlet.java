package com.example.controller;

import com.example.dao.RecipeDAO;
import com.example.model.Recipe;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/recipes")
public class RecipeServlet extends HttpServlet {
    private RecipeDAO recipeDAO;

    public void init() {
        recipeDAO = new RecipeDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        String searchQuery = request.getParameter("searchQuery");

        if ("edit".equals(action)) {
            String recipeIdStr = request.getParameter("recipeId");
            if (recipeIdStr != null && !recipeIdStr.isEmpty()) {
                int recipeId = Integer.parseInt(recipeIdStr);
                Recipe recipe = recipeDAO.getRecipeById(recipeId);
                request.setAttribute("recipe", recipe);
                request.getRequestDispatcher("edit-recipe.jsp").forward(request, response);
            } else {
                response.sendRedirect("recipes"); 
            }
        } else if ("search".equals(action) && searchQuery != null && !searchQuery.trim().isEmpty()) {
            List<Recipe> recipes = recipeDAO.searchRecipes(searchQuery);
            request.setAttribute("recipes", recipes);
            request.getRequestDispatcher("recipes.jsp").forward(request, response);
        } else {
            List<Recipe> recipes = recipeDAO.getAllRecipes();
            request.setAttribute("recipes", recipes);
            request.getRequestDispatcher("recipes.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        if (action == null || "add".equals(action)) {
            String recipeName = request.getParameter("recipeName");
            String description = request.getParameter("description");
            String instructions = request.getParameter("instructions");

            Recipe newRecipe = new Recipe(recipeName, description, instructions);
            recipeDAO.addRecipe(newRecipe);

            response.sendRedirect("recipes");
        } else if ("update".equals(action)) {
            String recipeIdStr = request.getParameter("recipeId");
            if (recipeIdStr != null && !recipeIdStr.isEmpty()) {
                int recipeId = Integer.parseInt(recipeIdStr);
                String recipeName = request.getParameter("recipeName");
                String description = request.getParameter("description");
                String instructions = request.getParameter("instructions");
                
                Recipe updatedRecipe = new Recipe(recipeId, recipeName, description, instructions);
                recipeDAO.updateRecipe(updatedRecipe);
            }
            response.sendRedirect("recipes");
        } else if ("delete".equals(action)) {
            String recipeIdStr = request.getParameter("recipeId");
            if (recipeIdStr != null && !recipeIdStr.isEmpty()) {
                int recipeId = Integer.parseInt(recipeIdStr);
                recipeDAO.deleteRecipe(recipeId);
            }
            response.sendRedirect("recipes");
        }
    }
}