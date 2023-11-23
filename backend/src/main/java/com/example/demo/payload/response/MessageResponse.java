package com.example.demo.payload.response;

public class MessageResponse {
    private String message;

    private String code;

    public MessageResponse(String message, Responses code) {
        this.message = message;
        this.code = code.getCode();
    }
    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getCode() { return code; }

    public void setCode(String code) { this.code = code; }
}

