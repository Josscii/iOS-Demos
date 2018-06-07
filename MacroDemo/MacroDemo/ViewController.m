//
//  ViewController.m
//  MacroDemo
//
//  Created by josscii on 2018/6/7.
//  Copyright © 2018年 josscii. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGFloat f = 1.2;
    CGFloat newF = scaleCeil(f);
    
    NSLog(@"%f", newF);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
