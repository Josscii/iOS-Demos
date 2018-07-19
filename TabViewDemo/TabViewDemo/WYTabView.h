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

NS_ASSUME_NONNULL_BEGIN;

@protocol WYTabViewDelegate <NSObject>

- (UIView *)tabView:(WYTabView *)tabView indicatorWithSuperView:(UIView *)superView;
- (void)tabView:(WYTabView *)tabView configureItemAtIndex:(NSInteger)index withCell:(WYTabItemCell *)cell;
- (void)tabView:(WYTabView *)tabView didSelectItemView:(nullable id<WYTabItemView>)itemView atIndex:(NSInteger)index;
- (void)tabView:(WYTabView *)tabView updateIndicatorView:(nullable UIView *)indicatorView withProgress:(CGFloat)progress;

- (NSInteger)numberOfItemsInTabView:(nonnull WYTabView *)tabView;

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
@property (nonatomic, assign) double animationDuration;

- (instancetype)initWithFrame:(CGRect)frame
        coordinatedScrollView:(UIScrollView *)coordinatedScrollView;
- (instancetype)initWithCoordinatedScrollView:(UIScrollView *)coordinatedScrollView;

- (void)reloadData;

@end

NS_ASSUME_NONNULL_END;
