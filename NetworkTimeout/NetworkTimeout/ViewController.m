//
//  ViewController.m
//  NetworkTimeout
//
//  Created by josscii on 2018/5/16.
//  Copyright © 2018年 josscii. All rights reserved.
//

#import "ViewController.h"

#define Test_Url @"https://apic.51wnl.com/CttApi/GetWeatherDetail?tkn=6480F2A608958030D190E9E62590174A&mac=&av=3.0&cid=Youloft_IOS&idfa=8603F59B-92C1-455B-974F-AF4514F69DC1&did=e830fe91a7ec1cfe23ee46eb4fa3f89e20462b88&chn=%5BCHANNEL%5D&cc=US&lang=zh-Hant-US&bd=com.ijinshan.ksweather&oudid=e830fe91a7ec1cfe23ee46eb4fa3f89e20462b88&ptkn=%5BPTOKEN%5D&bsid=%5BBSIFID%5D&uid=%5BWNLUSERID%5D&model=x86_64&ov=11.0&nt=wifi&carrier=0&time=1526436580&authSign=5211429f6d05dd07d9409fe088df8a9e&Strategy=1003&cityCode=101050101"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSURL *url = [NSURL URLWithString:Test_Url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.timeoutInterval = 1;
    
//    NSOperationQueue
//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
//        NSLog(@"%@", connectionError);
//    }];
    
    NSError *error;
//    [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@", error);
    }];
    
    [dataTask resume];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
