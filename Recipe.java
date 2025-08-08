package com.example.model;

public class Recipe {
    private int recipeId;
    private String recipeName;
    private String description;
    private String instructions;

    public Recipe() {}

    public Recipe(int recipeId, String recipeName, String description, String instructions) {
        this.recipeId = recipeId;
        this.recipeName = recipeName;
        this.description = description;
        this.instructions = instructions;
    }

    public Recipe(String recipeName, String description, String instructions) {
        this.recipeName = recipeName;
        this.description = description;
        this.instructions = instructions;
    }

    // Getter와 Setter
    public int getRecipeId() {
        return recipeId;
    }
    
    public void setRecipeId(int recipeId) {
        this.recipeId = recipeId;
    }

    public String getRecipeName() {
        return recipeName;
    }

    public void setRecipeName(String recipeName) {
        this.recipeName = recipeName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getInstructions() {
        return instructions;
    }

    public void setInstructions(String instructions) {
        this.instructions = instructions;
    }
}
