//
//  CSLinearLayoutManager.h
//  CSLinearLayoutManager
//
//  Created by josscii on 17/1/1.
//  Copyright © 2017年 josscii. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, CSLinearLayoutManagerDirection) {
    CSLinearLayoutManagerDirectionHorizontal,
    CSLinearLayoutManagerDirectionVertical
};

typedef NS_ENUM(NSInteger, CSLinearLayoutManagerAlignment) {
    CSLinearLayoutManagerAlignmentLeft,
    CSLinearLayoutManagerAlignmentRight,
    
    CSLinearLayoutManagerAlignmentTop,
    CSLinearLayoutManagerAlignmentBottom,
    
    CSLinearLayoutManagerAlignmentCenter
};

@interface CSLinearLayoutManager : UIView

@property (nonatomic, copy) NSArray<UIView *> *items;
@property (nonatomic, assign) UIEdgeInsets edgeInsets;
@property (nonatomic, copy) NSArray<NSNumber *> *spacesBetween; // must be a single value or the count of items minus 1
@property (nonatomic, assign) CSLinearLayoutManagerDirection layoutDirection; // default to be horizontal
@property (nonatomic, assign) CSLinearLayoutManagerAlignment layoutAlignment; // default to be center
@property (nonatomic, assign) BOOL debugEnable; // for dubug

- (instancetype)initWithItems:(NSArray *)items;
- (void)addItem:(UIView *)item;

@end
