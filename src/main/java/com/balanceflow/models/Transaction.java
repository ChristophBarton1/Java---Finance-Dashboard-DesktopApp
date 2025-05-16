package com.balanceflow.models;

import java.time.LocalDate;

public class Transaction {
    private String id;
    private String title;
    private String category;
    private double amount;
    private LocalDate date;
    private TransactionType type;
    
    public enum TransactionType {
        INCOME, EXPENSE
    }
    
    public Transaction(String id, String title, String category, double amount, LocalDate date, TransactionType type) {
        this.id = id;
        this.title = title;
        this.category = category;
        this.amount = amount;
        this.date = date;
        this.type = type;
    }

    public String getId() {
        return id;
    }

    public String getTitle() {
        return title;
    }

    public String getCategory() {
        return category;
    }

    public double getAmount() {
        return amount;
    }

    public LocalDate getDate() {
        return date;
    }

    public TransactionType getType() {
        return type;
    }
    
    public boolean isIncome() {
        return type == TransactionType.INCOME;
    }
    
    public boolean isExpense() {
        return type == TransactionType.EXPENSE;
    }
    
    public String getFormattedAmount() {
        return (isIncome() ? "+ €" : "- €") + String.format("%,.2f", Math.abs(amount)).replace(".", ",");
    }
}
