package com.test.rest.application.api.http;

import com.test.rest.application.api.dto.TestResponse;
import com.test.rest.application.api.service.TestService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping(value = "/api/v1")
public class ApplicationRestController {

    private final TestService testService;

    @GetMapping(value = "/getResponse")
    public TestResponse getResponse() {
        return testService.getResponse();
    }
}
