//
//  NSString+Size.h
//  NSStringSize
//
//  Created by Josscii on 2018/4/29.
//  Copyright © 2018年 Josscii. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (Size)

/**
 指定行数的高度

 @param line 行数
 @param fontSize 字体大小
 @param lineSpace 行间距
 @return 高度
 */
+ (CGFloat)certainLineHeightWithLine:(NSInteger)line
                            fontSize:(CGFloat)fontSize
                           lineSpace:(CGFloat)lineSpace;

/**
 指定宽度的高度

 @param fontSize 字体大小
 @param lineSpace 行间距
 @param width 宽度
 @return 高度
 */
- (CGFloat)heightWithFontSize:(CGFloat)fontSize
                    lineSpace:(CGFloat)lineSpace
                        width:(CGFloat)width;

@end
