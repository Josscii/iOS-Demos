//
//  WYTabView.h
//  ListLayout
//
//  Created by josscii on 2018/7/18.
//  Copyright © 2018年 josscii. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WYTabView;
@class WYTabItemCell;
@protocol WYTabItemView;

@protocol WYTabViewDelegate <NSObject>

- (void)tabView:(WYTabView *)tabView configureIndicatorWithSuperView:(UIView *)superView;
- (void)tabView:(WYTabView *)tabView configureItemAtIndex:(NSInteger)index withCell:(WYTabItemCell *)cell;
- (void)tabView:(WYTabView *)tabView didSelectItemView:(id<WYTabItemView>)itemView atIndex:(NSInteger)index;
- (NSInteger)numberOfItemsInTabView:(WYTabView *)tabView;

@end

@protocol WYTabItemView <NSObject>

- (void)setSelected:(BOOL)selected;

@end

@interface WYTabItemCell: UICollectionViewCell

@property (nonatomic, strong) id<WYTabItemView> itemView;

+ (NSString *)reuseIdentifier;

@end

@interface WYTabView : UIView

@property (nonatomic, weak) id<WYTabViewDelegate> delegate;
@property (nonatomic, assign) NSInteger itemWidth;

@end
