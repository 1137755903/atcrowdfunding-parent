package com.atguigu.atcrowdfunding;

public class LoginException extends RuntimeException{
    public LoginException() {

    }

    public LoginException(String message){
        super(message);
    }
}
