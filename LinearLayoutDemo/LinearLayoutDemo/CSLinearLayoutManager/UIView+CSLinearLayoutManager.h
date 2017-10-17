//
//  UIView+CSLinearLayoutManager.h
//  CSLinearLayoutManager
//
//  Created by josscii on 17/1/1.
//  Copyright © 2017年 josscii. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CSLinearLayoutManager)

- (BOOL)hasWidthConstraint;
- (BOOL)hasHeightConstraint;

- (CGFloat)widthConstraintConstant;
- (CGFloat)heightConstraintConstant;

@end
