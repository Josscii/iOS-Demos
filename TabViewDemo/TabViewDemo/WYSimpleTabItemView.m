//
//  WYSimpleTabItemView.m
//  ListLayout
//
//  Created by josscii on 2018/7/18.
//  Copyright © 2018年 josscii. All rights reserved.
//

#import "WYSimpleTabItemView.h"

@implementation WYSimpleTabItemView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)init {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    UILabel *label = [UILabel new];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:label];
    [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0].active = YES;
    self.titleLabel = label;
}

- (void)setSelected:(BOOL)selected {
    if (selected) {
        self.titleLabel.textColor = [UIColor redColor];
    } else {
        self.titleLabel.textColor = [UIColor blackColor];
    }
}

@end
