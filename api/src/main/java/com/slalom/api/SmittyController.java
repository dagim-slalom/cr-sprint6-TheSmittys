package com.slalom.api;

import java.util.concurrent.atomic.AtomicLong;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class SmittyController {

    private static final String template = "Who is #1? %s!";
    private final AtomicLong counter = new AtomicLong();

    @GetMapping("/smitty")
    //test this via http://localhost:8080/smitty and http://localhost:8080/smitty?name=Kesha
    public SmittyContainer smitty(@RequestParam(value = "name", defaultValue = "Liam") String name) {
        if (name.equalsIgnoreCase("smitty"))
            return new SmittyContainer(counter.incrementAndGet(), String.format(template, name), "https://i.kym-cdn.com/photos/images/original/000/933/502/92b.gif");
        else
            return new SmittyContainer(counter.incrementAndGet(), String.format(template, name), "https://c.tenor.com/wWzDIC3rpCgAAAAC/that-is-incorrect-brooke-bishop.gif");
    }
}