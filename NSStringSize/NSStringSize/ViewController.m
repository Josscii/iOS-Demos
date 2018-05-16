//
//  ViewController.m
//  NSStringSize
//
//  Created by Josscii on 2018/4/29.
//  Copyright © 2018年 Josscii. All rights reserved.
//

#import "ViewController.h"
#import "NSString+Size.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGFloat height = [NSString certainLineHeightWithLine:3 fontSize:17 lineSpace:4];
    
    NSString *str = @"我的天啊你喜欢我吗？";
    CGFloat height1 = [str heightWithFontSize:17 lineSpace:0 width:0];
    NSLog(@"%f", height);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
