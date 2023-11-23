package com.example.demo.payload.response;

public enum Responses {
    SUCCESS("SUCCESS"),
    USERNAMEEXISTS("USERNAMEEXISTS"),
    EMAILEXISTS("EMAILEXISTS");

    private final String code;

    Responses(String code) {
        this.code = code;
    }

    public String getCode() {
        return code;
    }
}
