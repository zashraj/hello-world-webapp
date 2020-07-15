package com.ashishco.samplewebapp;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class SamplewebappController {
    @RequestMapping("/")
	public String greeting(){
        return "<h2>Hello World!</h2> \n <h3>This is sample SpringBoot Application(v1) to deploy on AWS</h3>\n<I>-by Ashish</I>";
    }
}