//
//  Macros.h
//  ObjCDemo
//
//  Created by josscii on 2018/1/19.
//  Copyright © 2018年 josscii. All rights reserved.
//

#ifndef Macros_h
#define Macros_h

#pragma mark -
#pragma mark project convience

#define APPDELEGATE ((AppDelegate *)[[UIApplication sharedApplication] delegate])

#pragma mark -
#pragma mark safe surance

#define NSNull2Nil(x) ([x isEqualTo:[NSNull null]] ? nil : x)
#define ISDictionary(x) [x isKindOfClass:[NSDictionary class]]
#define ISArray(x) [x isKindOfClass:[NSArray class]]
#define ISString(x) [x isKindOfClass:[NSString class]]

static inline BOOL isEmpty(id x) {
    if (x == nil) return YES;
    if ([x isEqual:[NSNull null]]) return YES;
    if ([x respondsToSelector:@selector(count)]) return [x performSelector:@selector(count)] == 0;
    if ([x respondsToSelector:@selector(length)]) return [x performSelector:@selector(length)] == 0;
    return NO;
}

static inline BOOL isPresent(id x) {
    return !isEmpty(x);
}

#pragma mark -
#pragma mark iOS Version

#define IOS_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define IOS_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define IOS_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define IOS_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define IOS_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#pragma mark -
#pragma mark UIColor

// example usage: UIColorFromHex(0x9daa76)
#define UIColorFromHexWithAlpha(hexValue,a) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:a]
#define UIColorFromHex(hexValue)            UIColorFromHexWithAlpha(hexValue,1.0)
#define UIColorFromRGBA(r,g,b,a)            [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define UIColorFromRGB(r,g,b)               UIColorFromRGBA(r,g,b,1.0)


#endif /* Macros_h */
