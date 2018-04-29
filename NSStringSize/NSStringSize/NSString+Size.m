//
//  NSString+Size.m
//  NSStringSize
//
//  Created by Josscii on 2018/4/29.
//  Copyright © 2018年 Josscii. All rights reserved.
//

#import "NSString+Size.h"

@implementation NSString (Size)

+ (CGFloat)certainLineHeightWithLine:(NSInteger)line
                            fontSize:(CGFloat)fontSize
                           lineSpace:(CGFloat)lineSpace {
    NSString *lineString = [self certainLineStringWithLine:line];
    NSDictionary *attributes = [lineString attributesWithFontSize:fontSize
                                                        lineSpace:lineSpace];
    CGFloat height = [lineString boundingRectWithSize:CGSizeZero
                                              options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                           attributes:attributes
                                              context:nil].size.height;
    return ceil(height);
}

+ (NSString *)certainLineStringWithLine:(NSInteger)line {
    NSString *str = @"";
    for (NSInteger i = 0; i < line-1; i++) {
        str = [str stringByAppendingString:@"\n"];
    }
    return str;
}

- (CGFloat)heightWithFontSize:(CGFloat)fontSize
                    lineSpace:(CGFloat)lineSpace
                        width:(CGFloat)width {
    NSDictionary *attributes = [self attributesWithFontSize:fontSize lineSpace:lineSpace];
    CGFloat height = [self boundingRectWithSize:CGSizeMake(width, 0)
                                        options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                     attributes:attributes
                                        context:nil].size.height;
    return ceil(height);
}

- (NSDictionary *)attributesWithFontSize:(CGFloat)fontSize
                               lineSpace:(CGFloat)lineSpace {
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    attributes[NSFontAttributeName] = font;
    if (lineSpace > 0.0) {
        NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
        style.lineSpacing = lineSpace - (font.lineHeight - fontSize);
        attributes[NSParagraphStyleAttributeName] = style;
    }
    return [attributes copy];
}

@end
