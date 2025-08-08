package com.example.dao;

import com.example.model.Recipe;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class RecipeDAO {
    private static final String JDBC_DRIVER = "oracle.jdbc.driver.OracleDriver";
    private static final String DB_URL = "jdbc:oracle:thin:@localhost:1521:xe";
    private static final String USER = "system"; 
    private static final String PASS = "1234"; 

    public RecipeDAO() {
        try {
            Class.forName(JDBC_DRIVER);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL, USER, PASS);
    }

    public void addRecipe(Recipe recipe) {
        String sql = "INSERT INTO RECIPES (RECIPE_NAME, DESCRIPTION, INSTRUCTIONS) VALUES (?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, recipe.getRecipeName());
            pstmt.setString(2, recipe.getDescription());
            pstmt.setString(3, recipe.getInstructions());
            
            pstmt.executeUpdate();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Recipe> getAllRecipes() {
        List<Recipe> recipes = new ArrayList<>();
        String sql = "SELECT RECIPE_ID, RECIPE_NAME, DESCRIPTION, INSTRUCTIONS FROM RECIPES ORDER BY RECIPE_ID DESC";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                Recipe recipe = new Recipe();
                recipe.setRecipeId(rs.getInt("RECIPE_ID"));
                recipe.setRecipeName(rs.getString("RECIPE_NAME"));
                recipe.setDescription(rs.getString("DESCRIPTION"));
                recipe.setInstructions(rs.getString("INSTRUCTIONS"));
                recipes.add(recipe);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return recipes;
    }

    public Recipe getRecipeById(int recipeId) {
        Recipe recipe = null;
        String sql = "SELECT RECIPE_ID, RECIPE_NAME, DESCRIPTION, INSTRUCTIONS FROM RECIPES WHERE RECIPE_ID = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, recipeId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    recipe = new Recipe();
                    recipe.setRecipeId(rs.getInt("RECIPE_ID"));
                    recipe.setRecipeName(rs.getString("RECIPE_NAME"));
                    recipe.setDescription(rs.getString("DESCRIPTION"));
                    recipe.setInstructions(rs.getString("INSTRUCTIONS"));
                }
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return recipe;
    }

    public void updateRecipe(Recipe recipe) {
        String sql = "UPDATE RECIPES SET RECIPE_NAME = ?, DESCRIPTION = ?, INSTRUCTIONS = ? WHERE RECIPE_ID = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, recipe.getRecipeName());
            pstmt.setString(2, recipe.getDescription());
            pstmt.setString(3, recipe.getInstructions());
            pstmt.setInt(4, recipe.getRecipeId());
            
            pstmt.executeUpdate();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteRecipe(int recipeId) {
        String sql = "DELETE FROM RECIPES WHERE RECIPE_ID = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, recipeId);
            
            pstmt.executeUpdate();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Recipe> searchRecipes(String query) {
        List<Recipe> recipes = new ArrayList<>();
        String sql = "SELECT RECIPE_ID, RECIPE_NAME, DESCRIPTION, INSTRUCTIONS FROM RECIPES WHERE UPPER(RECIPE_NAME) LIKE UPPER(?) OR UPPER(DESCRIPTION) LIKE UPPER(?) OR UPPER(INSTRUCTIONS) LIKE UPPER(?) ORDER BY RECIPE_ID DESC";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            String searchQuery = "%" + query + "%";
            pstmt.setString(1, searchQuery);
            pstmt.setString(2, searchQuery);
            pstmt.setString(3, searchQuery);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Recipe recipe = new Recipe();
                    recipe.setRecipeId(rs.getInt("RECIPE_ID"));
                    recipe.setRecipeName(rs.getString("RECIPE_NAME"));
                    recipe.setDescription(rs.getString("DESCRIPTION"));
                    recipe.setInstructions(rs.getString("INSTRUCTIONS"));
                    recipes.add(recipe);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return recipes;
    }
}
