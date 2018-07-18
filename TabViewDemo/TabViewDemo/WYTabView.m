//
//  WYTabView.m
//  ListLayout
//
//  Created by josscii on 2018/7/18.
//  Copyright © 2018年 josscii. All rights reserved.
//

#import "WYTabView.h"

@interface WYTabItemCell ()

@end

@implementation WYTabItemCell

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    [self.itemView setSelected:selected];
}

+ (NSString *)reuseIdentifier {
    return @"WYTabItemCell";
}

@end

@interface WYTabView () <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIView *indicatorSuperView;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, assign) BOOL isFirstInit;
@property (nonatomic, assign) CGFloat animationDuration;

@end

@implementation WYTabView

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
    _animationDuration = 0.25;
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.minimumLineSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    [collectionView registerClass:[WYTabItemCell class] forCellWithReuseIdentifier:[WYTabItemCell reuseIdentifier]];
    [self addSubview:collectionView];
    _collectionView = collectionView;
    
    UIView *indicatorSuperView = [UIView new];
    indicatorSuperView.backgroundColor = [UIColor clearColor];
    indicatorSuperView.layer.zPosition = -1;
    [_collectionView addSubview:indicatorSuperView];
    _indicatorSuperView = indicatorSuperView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.indicatorSuperView.frame = CGRectMake(0, 0, [self itemSize].width, [self itemSize].height);
    [self.delegate tabView:self configureIndicatorWithSuperView:self.indicatorSuperView];
}

- (CGSize)itemSize {
    NSAssert(self.delegate != nil, @"delegate must not be nil");
    
    if (self.itemWidth != 0) {
        return CGSizeMake(self.itemWidth, self.bounds.size.height);
    } else {
        return CGSizeMake(self.bounds.size.width / [self.delegate numberOfItemsInTabView:self], self.bounds.size.height);
    }
}

#pragma mark -
#pragma mark

- (void)updateTabViewWithCoordinatedScrollView:(UIScrollView *)coordinatedScrollView {
    CGFloat contentOffsetX = coordinatedScrollView.contentOffset.x;
    CGFloat scrollViewWidth = coordinatedScrollView.bounds.size.width;
    
    CGFloat mod = fmod(contentOffsetX, scrollViewWidth);
    CGFloat divider = contentOffsetX / scrollViewWidth;
    
    CGFloat x = divider * self.itemWidth + (mod / scrollViewWidth) * self.itemWidth;
    CGRect frame = self.indicatorSuperView.frame;
    frame.origin.x = x;
    self.indicatorSuperView.frame= frame;
    
    if (divider < 0) {
        return;
    }
    
    NSInteger index = 0;
    CGFloat decimal = fmod(divider, 1);
    if (decimal > 0.5) {
        index = ceil(divider);
    } else {
        index = floor(divider);
    }
    
    [self updateTabViewWithIndex:index];
}

- (void)reloadData {
    [self.collectionView reloadData];
}

#pragma mark -
#pragma mark

- (void)updateTabViewWithIndex:(NSInteger)index {
    [self scrollToCenterWithIndex:index complection:^{
        [self selectItemAtIndex:index];
    }];
}

- (void)selectItemAtIndex:(NSInteger)index {
    [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionTop];
}

- (void)scrollToCenterWithIndex:(NSInteger)index complection:(void (^)(void))completion {
    CGFloat x = [self itemSize].width * index - (self.collectionView.bounds.size.width-[self itemSize].width) / 2;
    x = MIN(MAX(x, 0), self.collectionView.contentSize.width - self.collectionView.bounds.size.width);
    
    [UIView animateWithDuration:self.animationDuration animations:^{
        CGPoint contentOffset = self.collectionView.contentOffset;
        contentOffset.x = x;
        self.collectionView.contentOffset = contentOffset;
    } completion:^(BOOL finished) {
        completion();
    }];
}

#pragma mark -
#pragma mark

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self itemSize];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSAssert(self.delegate != nil, @"delegate must not be nil");
    
    self.selectedIndex = indexPath.item;
    
    [self updateTabViewWithIndex:self.selectedIndex];
    
    WYTabItemCell *cell = (WYTabItemCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [self.delegate tabView:self didSelectItemView:cell.itemView atIndex:self.selectedIndex];
}

#pragma mark -
#pragma mark

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSAssert(self.delegate != nil, @"delegate must not be nil");
    
    return [self.delegate numberOfItemsInTabView:self];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSAssert(self.delegate != nil, @"delegate must not be nil");
    
    WYTabItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[WYTabItemCell reuseIdentifier] forIndexPath:indexPath];
    [self.delegate tabView:self configureItemAtIndex:indexPath.item withCell:cell];
    
    if (self.isFirstInit && indexPath.item == 0) {
        [self selectItemAtIndex:indexPath.item];
        cell.selected = YES;
        self.isFirstInit = NO;
    }
    
    return cell;
}

@end
