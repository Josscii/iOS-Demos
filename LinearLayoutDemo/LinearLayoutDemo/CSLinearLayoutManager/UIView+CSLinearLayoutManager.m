//
//  UIView+CSLinearLayoutManager.m
//  CSLinearLayoutManager
//
//  Created by josscii on 17/1/1.
//  Copyright © 2017年 josscii. All rights reserved.
//

#import "UIView+CSLinearLayoutManager.h"

@implementation UIView (CSLinearLayoutManager)

- (BOOL)hasWidthConstraint {
    for (NSLayoutConstraint *constraint in self.constraints) {
        if ([constraint.firstItem isEqual:self] &&
            constraint.firstAttribute == NSLayoutAttributeWidth &&
            constraint.secondAttribute == NSLayoutAttributeNotAnAttribute) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)hasHeightConstraint {
    for (NSLayoutConstraint *constraint in self.constraints) {
        if ([constraint.firstItem isEqual:self] &&
            constraint.firstAttribute == NSLayoutAttributeHeight &&
            constraint.secondAttribute == NSLayoutAttributeNotAnAttribute) {
            return YES;
        }
    }
    return NO;
}

- (CGFloat)widthConstraintConstant {
    CGFloat constant = 0;
    for (NSLayoutConstraint *constraint in self.constraints) {
        if ([constraint.firstItem isEqual:self] &&
            constraint.firstAttribute == NSLayoutAttributeWidth &&
            constraint.secondAttribute == NSLayoutAttributeNotAnAttribute) {
            constant = constraint.constant;
        }
    }
    return constant;
}

- (CGFloat)heightConstraintConstant {
    CGFloat constant = 0;
    for (NSLayoutConstraint *constraint in self.constraints) {
        if ([constraint.firstItem isEqual:self] &&
            constraint.firstAttribute == NSLayoutAttributeHeight &&
            constraint.secondAttribute == NSLayoutAttributeNotAnAttribute) {
            constant = constraint.constant;
        }
    }
    return constant;
}

@end
