package com.test.rest.application.api.service;

import com.test.rest.application.api.dto.TestResponse;
import org.springframework.stereotype.Service;

//@Slf4j
@Service
public class TestServiceImpl implements TestService {
    @Override
    public TestResponse getResponse() {
        System.out.println("Reponse generated.");
        return new TestResponse("777");
    }
}
