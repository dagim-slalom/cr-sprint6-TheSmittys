package com.slalom.api;

public class Calculator {
    private final long id;
    private final String content;

    public Calculator(long id, String content) {
        this.id = id;
        this.content = content;
    }

    public long getId() {
        return id;
    }

    public String getContent() {
        return content;
    }
}

