//
//  WYCycleScrollView.m
//  CycleScrollView
//
//  Created by josscii on 2018/7/20.
//  Copyright © 2018年 josscii. All rights reserved.
//

#import "WYCycleScrollView.h"

@interface WYCycleScrollView () {
    NSInteger _currentIndex;
}

@property (nonatomic, copy) NSArray *internalViews;
@property (nonatomic, copy) NSArray *dataViews;

@end

@implementation WYCycleScrollView

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat originX = self.bounds.origin.x;
    CGFloat width = self.bounds.size.width;
    
    BOOL shouldChange = NO;
    
    if (originX <= 0) {
        shouldChange = YES;
        
        _currentIndex = (5 - labs(_currentIndex - 1)) % 5;
    }
    
    if (originX >= width) {
        shouldChange = YES;
        
        _currentIndex = (_currentIndex + 1) % 5;
    }
    
    if (shouldChange) {
        CGRect bounds = self.bounds;
        bounds.origin.x = width;
        self.bounds = bounds;
        
        NSInteger leftIndex = (5 - labs(_currentIndex - 1)) % 5;
        NSInteger rightIndex = (_currentIndex + 1) % 5;
        
        for (UIView *view in self.internalViews) {
            [view.subviews.firstObject removeFromSuperview];
        }
        
        [self.internalViews[0] addSubview:self.dataViews[leftIndex]];
        [self.internalViews[1] addSubview:self.dataViews[_currentIndex]];
        [self.internalViews[2] addSubview:self.dataViews[rightIndex]];
    }
}


@end
