//
//  UIScrollView+FixUIControlTouch.m
//  UIScrollViewAndUIControlDemo
//
//  Created by josscii on 2018/2/9.
//  Copyright © 2018年 josscii. All rights reserved.
//

#import "UIScrollView+FixUIControlTouch.h"
#import "objc/runtime.h"

// https://www.raizlabs.com/dev/2017/01/fixing-controls-scroll-views-ios/
// http://charlesharley.com/2013/programming/uibutton-in-uitableviewcell-has-no-highlight-state

@implementation UIScrollView (FixUIControlTouch)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(touchesShouldCancelInContentView:);
        SEL swizzledSelector = @selector(uicontrol_touchesShouldCancelInContentView:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        // When swizzling a class method, use the following:
        // Class class = object_getClass((id)self);
        // ...
        // Method originalMethod = class_getClassMethod(class, originalSelector);
        // Method swizzledMethod = class_getClassMethod(class, swizzledSelector);
        
        BOOL didAddMethod =
        class_addMethod(class,
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (BOOL)uicontrol_touchesShouldCancelInContentView:(UIView *)view {
    
    BOOL isControl = [view isKindOfClass:[UIControl class]];
    BOOL isTextField = [view isKindOfClass:[UITextField class]];
    BOOL isSwitch = [view isKindOfClass:[UISwitch class]];
    BOOL isSlider = [view isKindOfClass:[UISlider class]];
    
    if (isControl && !isTextField && !isSwitch && !isSlider) {
        return YES;
    }
    
    return [self uicontrol_touchesShouldCancelInContentView:view];
}

@end
