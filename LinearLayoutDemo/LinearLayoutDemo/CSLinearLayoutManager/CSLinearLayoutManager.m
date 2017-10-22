//
//  CSLinearLayoutManager.m
//  CSLinearLayoutManager
//
//  Created by josscii on 17/1/1.
//  Copyright © 2017年 josscii. All rights reserved.
//

#import "CSLinearLayoutManager.h"
#import "UIView+CSLinearLayoutManager.h"

@interface CSLinearLayoutManager ()

@property (nonatomic, assign) BOOL hasLayout;

@end

@implementation CSLinearLayoutManager

- (instancetype)initWithItems:(NSArray *)items {
    self = [self init];
    if (self) {
        _items  = items;
        _hasLayout = NO;
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _items = [NSMutableArray array];
        _edgeInsets = UIEdgeInsetsZero;
        _spacesBetween = @[@0];
        _layoutDirection = CSLinearLayoutManagerDirectionHorizontal;
        _layoutAlignment = CSLinearLayoutManagerAlignmentCenter;
        self.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return self;
}

- (void)addItem:(UIView *)item {
    _items = [_items arrayByAddingObject:item];
}

- (void)updateConstraints {
    [super updateConstraints];
    
    if (!_hasLayout) {
        [self configureLayout];
        _hasLayout = YES;
    }
}

- (void)configureLayout {
    
    for (int i = 0; i < _items.count; i++) {
        _items[i].translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_items[i]];
        
        CGSize size = [_items[i] systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        
        if (!_items[i].hasWidthConstraint) {
            [NSLayoutConstraint constraintWithItem:_items[i]
                                         attribute:NSLayoutAttributeWidth
                                         relatedBy:NSLayoutRelationEqual
                                            toItem:nil
                                         attribute:NSLayoutAttributeNotAnAttribute
                                        multiplier:1.0f
                                          constant:size.width].active = YES;
        }
        
        if (!_items[i].hasHeightConstraint) {
            [NSLayoutConstraint constraintWithItem:_items[i]
                                         attribute:NSLayoutAttributeHeight
                                         relatedBy:NSLayoutRelationEqual
                                            toItem:nil
                                         attribute:NSLayoutAttributeNotAnAttribute
                                        multiplier:1.0f
                                          constant:size.height].active = YES;
        }
    }
    
    

    
    if (_layoutDirection == CSLinearLayoutManagerDirectionVertical) {
        // find the widest subview's index
        int widestSubviewIndex = 0;
        for (int i = 0; i < _items.count; i++) {
            if (_items[i].widthConstraintConstant > _items[widestSubviewIndex].widthConstraintConstant) {
                widestSubviewIndex = i;
            }
        }
        
        // pin the widest view with left and right insets
        [NSLayoutConstraint constraintWithItem:_items[widestSubviewIndex]
                                     attribute:NSLayoutAttributeLeft
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                     attribute:NSLayoutAttributeLeft
                                    multiplier:1.0f
                                      constant:_edgeInsets.left].active = YES;
        
        [NSLayoutConstraint constraintWithItem:_items[widestSubviewIndex]
                                     attribute:NSLayoutAttributeRight
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                     attribute:NSLayoutAttributeRight
                                    multiplier:1.0f
                                      constant:-_edgeInsets.right].active = YES;
        
        // constraint all subviews based on aligment
        NSLayoutAttribute attribute = NSLayoutAttributeNotAnAttribute;
        switch (_layoutAlignment) {
            case CSLinearLayoutManagerAlignmentCenter:
            case CSLinearLayoutManagerAlignmentTop:
            case CSLinearLayoutManagerAlignmentBottom:
                attribute = NSLayoutAttributeCenterX;
                break;
            case CSLinearLayoutManagerAlignmentLeft:
                attribute = NSLayoutAttributeLeft;
                break;
            case CSLinearLayoutManagerAlignmentRight:
                attribute = NSLayoutAttributeRight;
                break;
            default:
                break;
        }
        
        for (int i = 0; i < _items.count; i++) {
            UIView *lastItem;
            NSLayoutAttribute attr;
            CGFloat constant = 0.0;
            if (i == 0) {
                lastItem = self;
                attr = NSLayoutAttributeTop;
                constant = _edgeInsets.top;
            } else {
                lastItem = _items[i-1];
                attr = NSLayoutAttributeBottom;
                if (_spacesBetween.count == 1) {
                    constant = _spacesBetween[0].floatValue;
                } else if (_spacesBetween.count == _items.count-1) {
                    constant = _spacesBetween[i-1].floatValue;
                }
            }
            
            // top to bottom
            [NSLayoutConstraint constraintWithItem:_items[i]
                                         attribute:NSLayoutAttributeTop
                                         relatedBy:NSLayoutRelationEqual
                                            toItem:lastItem
                                         attribute:attr
                                        multiplier:1.0f
                                          constant:constant].active = YES;
            
            if (i == _items.count - 1) {
                [NSLayoutConstraint constraintWithItem:_items[i]
                                             attribute:NSLayoutAttributeBottom
                                             relatedBy:NSLayoutRelationEqual
                                                toItem:self
                                             attribute:NSLayoutAttributeBottom
                                            multiplier:1.0f
                                              constant:-_edgeInsets.bottom].active = YES;
            }
            
            // alignment
            if (i != widestSubviewIndex) {
                [NSLayoutConstraint constraintWithItem:_items[i]
                                             attribute:attribute
                                             relatedBy:NSLayoutRelationEqual
                                                toItem:_items[widestSubviewIndex]
                                             attribute:attribute
                                            multiplier:1.0f
                                              constant:0].active = YES;
            }
        }
    } else {
        // find the widest subview's index
        int highestSubviewIndex = 0;
        for (int i = 0; i < _items.count; i++) {
            if (_items[i].heightConstraintConstant > _items[highestSubviewIndex].heightConstraintConstant) {
                highestSubviewIndex = i;
            }
        }
        
        // pin the widest view with left and right insets
        [NSLayoutConstraint constraintWithItem:_items[highestSubviewIndex]
                                     attribute:NSLayoutAttributeTop
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                     attribute:NSLayoutAttributeTop
                                    multiplier:1.0f
                                      constant:_edgeInsets.top].active = YES;
        
        [NSLayoutConstraint constraintWithItem:_items[highestSubviewIndex]
                                     attribute:NSLayoutAttributeBottom
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                     attribute:NSLayoutAttributeBottom
                                    multiplier:1.0f
                                      constant:-_edgeInsets.bottom].active = YES;
        
        // constraint all subviews based on aligment
        NSLayoutAttribute attribute = NSLayoutAttributeNotAnAttribute;
        switch (_layoutAlignment) {
            case CSLinearLayoutManagerAlignmentCenter:
            case CSLinearLayoutManagerAlignmentLeft:
            case CSLinearLayoutManagerAlignmentRight:
                attribute = NSLayoutAttributeCenterY;
                break;
            case CSLinearLayoutManagerAlignmentTop:
                attribute = NSLayoutAttributeTop;
                break;
            case CSLinearLayoutManagerAlignmentBottom:
                attribute = NSLayoutAttributeBottom;
                break;
            default:
                break;
        }
        
        for (int i = 0; i < _items.count; i++) {
            UIView *lastItem;
            NSLayoutAttribute attr;
            CGFloat constant = 0.0;
            if (i == 0) {
                lastItem = self;
                attr = NSLayoutAttributeLeft;
                constant = _edgeInsets.left;
            } else {
                lastItem = _items[i-1];
                attr = NSLayoutAttributeRight;
                if (_spacesBetween.count == 1) {
                    constant = _spacesBetween[0].floatValue;
                } else if (_spacesBetween.count == _items.count-1) {
                    constant = _spacesBetween[i-1].floatValue;
                }
            }
            
            // left to right
            [NSLayoutConstraint constraintWithItem:_items[i]
                                         attribute:NSLayoutAttributeLeft
                                         relatedBy:NSLayoutRelationEqual
                                            toItem:lastItem
                                         attribute:attr
                                        multiplier:1.0f
                                          constant:constant].active = YES;
            
            if (i == _items.count - 1) {
                [NSLayoutConstraint constraintWithItem:_items[i]
                                             attribute:NSLayoutAttributeRight
                                             relatedBy:NSLayoutRelationEqual
                                                toItem:self
                                             attribute:NSLayoutAttributeRight
                                            multiplier:1.0f
                                              constant:-_edgeInsets.right].active = YES;
            }
            
            // alignment
            if (i != highestSubviewIndex) {
                [NSLayoutConstraint constraintWithItem:_items[i]
                                             attribute:attribute
                                             relatedBy:NSLayoutRelationEqual
                                                toItem:_items[highestSubviewIndex]
                                             attribute:attribute
                                            multiplier:1.0f
                                              constant:0].active = YES;
            }
        }
    }
}

- (void)setDebugEnable:(BOOL)debugEnable {
    
}

@end
