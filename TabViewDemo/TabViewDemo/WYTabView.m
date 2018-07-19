//
//  WYTabView.m
//  WYTabView
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

@interface WYTabView () <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource> {
    NSInteger _selectedIndex;
    BOOL _isFirstInit;
}

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIView *indicatorSuperView;
@property (nonatomic, strong) UIView *indicatorView;
@property (nonatomic, strong) UIScrollView *coordinatedScrollView;

@end

@implementation WYTabView

- (instancetype)initWithFrame:(CGRect)frame
        coordinatedScrollView:(UIScrollView *)coordinatedScrollView {
    self = [super initWithFrame:frame];
    if (self) {
        _coordinatedScrollView = coordinatedScrollView;
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoordinatedScrollView:(UIScrollView *)coordinatedScrollView {
    return [self initWithFrame:CGRectZero coordinatedScrollView:coordinatedScrollView];
}

- (void)commonInit {
    _animationDuration = 0.25;
    _isFirstInit = YES;
    [_coordinatedScrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
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
    self.indicatorView = [self.delegate tabView:self indicatorWithSuperView:self.indicatorSuperView];
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

- (void)reloadData {
    [self.collectionView reloadData];
    [self updateTabView];
}

#pragma mark -
#pragma mark

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        [self updateTabView];
    }
}

#pragma mark -
#pragma mark

- (void)updateTabView {
    CGFloat contentOffsetX = self.coordinatedScrollView.contentOffset.x;
    CGFloat scrollViewWidth = self.coordinatedScrollView.bounds.size.width;
    CGFloat contentWidth = self.coordinatedScrollView.contentSize.width;
    
    CGFloat mod = fmod(contentOffsetX, scrollViewWidth);
    CGFloat quotient = contentOffsetX / scrollViewWidth;
    
    CGFloat x = (int)quotient * self.itemWidth + (mod / scrollViewWidth) * self.itemWidth;
    CGRect frame = self.indicatorSuperView.frame;
    frame.origin.x = x;
    self.indicatorSuperView.frame = frame;
    
    CGFloat max = (contentWidth / scrollViewWidth) - 1;
    if (quotient < 0 || quotient > max) {
        return;
    }
    
    NSInteger index = 0;
    CGFloat decimal = fmod(quotient, 1);
    if (decimal > 0.5) {
        index = ceil(quotient);
    } else {
        index = floor(quotient);
    }
    [self updateTabViewWithIndex:index];
    
    CGFloat progress = (0.5 - fabs(0.5 - decimal)) * 2;
    [self updateIndicatorWithProgress:progress];
}

- (void)updateIndicatorWithProgress:(CGFloat)progress {
    if (self.indicatorView == nil) {
        return;
    }
    
    [self.delegate tabView:self updateIndicatorView:self.indicatorView withProgress:progress];
}

- (void)updateTabViewWithIndex:(NSInteger)index {
    [self scrollToCenterWithIndex:index complection:^{
        [self selectItemAtIndex:index];
    }];
}

- (void)selectItemAtIndex:(NSInteger)index {
    [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionTop];
}

- (void)scrollToCenterWithIndex:(NSInteger)index complection:(void (^)(void))completion {
    CGFloat maxOffsetX = self.collectionView.contentSize.width - self.collectionView.bounds.size.width;
    
    if (maxOffsetX < 0) {
        completion();
        return;
    }
    
    CGFloat x = [self itemSize].width * index - (self.collectionView.bounds.size.width-[self itemSize].width) / 2;
    x = MIN(MAX(x, 0), maxOffsetX);
    
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
    
    _selectedIndex = indexPath.item;
    
    [self updateTabViewWithIndex:_selectedIndex];
    
    WYTabItemCell *cell = (WYTabItemCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    [UIView animateWithDuration:self.animationDuration animations:^{
        CGPoint contentOffset = self.coordinatedScrollView.contentOffset;
        contentOffset.x = self->_selectedIndex * self.coordinatedScrollView.bounds.size.width;
        self.coordinatedScrollView.contentOffset = contentOffset;
    }];
    
    [self.delegate tabView:self didSelectItemView:cell.itemView atIndex:_selectedIndex];
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
    
    if (_isFirstInit && indexPath.item == 0) {
        [self selectItemAtIndex:indexPath.item];
        cell.selected = YES;
        _isFirstInit = NO;
    }
    
    return cell;
}

@end
