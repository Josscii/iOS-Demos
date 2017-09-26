//
//  UIImage+ObjcTest.m
//  UIImageDemo
//
//  Created by josscii on 2017/9/4.
//  Copyright © 2017年 Josscii. All rights reserved.
//

#import "UIImage+ObjcTest.h"

@implementation UIImage (ObjcTest)

- (UIImage *)obj_clipUseLayerWithBoundingSize:(CGSize)size radius:(CGFloat)radius {
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, kCGInterpolationLow);
    CALayer *imageLayer = [CALayer layer];
    imageLayer.cornerRadius = radius;
    imageLayer.masksToBounds = YES;
    imageLayer.contentsGravity = @"resizeAspectFill";
    imageLayer.frame = CGRectMake(0, 0, size.width-20, size.height-20);
    imageLayer.contents = (__bridge id)(self.CGImage);
    CGContextTranslateCTM(context, 10, 10);
    [imageLayer renderInContext:context];
    UIImage *output = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return output;
}

@end
