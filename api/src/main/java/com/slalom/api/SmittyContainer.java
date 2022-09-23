package com.slalom.api;

/**
 * Represents container for an API response which contains content and an id.
 */
public class SmittyContainer {
    private final long id;
    private final String content;
    private final String url;

    public SmittyContainer(long id, String content, String url) {
        this.id = id;
        this.content = content;
        this.url = url;
    }

    public long getId() {
        return id;
    }

    public String getContent() {
        return content;
    }

    public String getURL() {
        return url;
    }
}
