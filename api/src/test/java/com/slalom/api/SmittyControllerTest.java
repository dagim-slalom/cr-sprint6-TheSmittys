package com.slalom.api;

import org.junit.jupiter.api.Test;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.http.ResponseEntity;

import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
public class SmittyControllerTest {

    @Autowired
    private TestRestTemplate template;

    @Test
    public void getSmitty() throws Exception {
        ResponseEntity<String> response = template.getForEntity("/smitty?name=Kesha", String.class);
        assertThat(response.getBody()).isEqualTo("{\"id\":1,\"content\":\"Who is #1? Kesha!\",\"url\":\"https://c.tenor.com/wWzDIC3rpCgAAAAC/that-is-incorrect-brooke-bishop.gif\"}");
    }

    @Test
    public void getSmittyRight() throws Exception {
        ResponseEntity<String> response = template.getForEntity("/smitty?name=Smitty", String.class);
        assertThat(response.getBody()).isEqualTo("{\"id\":2,\"content\":\"Who is #1? Smitty!\",\"url\":\"https://i.kym-cdn.com/photos/images/original/000/933/502/92b.gif\"}");
    }

}