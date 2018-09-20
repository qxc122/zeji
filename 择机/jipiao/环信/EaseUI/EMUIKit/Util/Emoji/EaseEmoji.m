/************************************************************
 *  * Hyphenate CONFIDENTIAL
 * __________________
 * Copyright (C) 2016 Hyphenate Inc. All rights reserved.
 *
 * NOTICE: All information contained herein is, and remains
 * the property of Hyphenate Inc.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from Hyphenate Inc.
 */

#import "EaseEmoji.h"
#import "EaseEmojiEmoticons.h"
#import "GlobalObject.h"


@implementation EaseEmoji

+ (NSString *)emojiWithCode:(int)code
{
    int sym = EMOJI_CODE_TO_SYMBOL(code);
    return [[NSString alloc] initWithBytes:&sym length:sizeof(sym) encoding:NSUTF8StringEncoding];
}

+ (NSArray *)allEmoji
{
    NSMutableArray *array = [NSMutableArray new];
    [array addObjectsFromArray:[EaseEmojiEmoticons allEmoticons]];
    return array;
}

+ (NSArray *)allEmojiTWO
{
    NSArray *names2 = @[@"[(-Q)]",@"[(-W)]",@"[(-E)]",@"[(-R)]",@"[(-T)]",@"[(-Y)]",@"[(-U)]",@"[(-I)]",@"[(-O)]",@"[(-P)]",@"[(-A)]",@"[(-S)]",@"[(-D)]",@"[(-F)]",@"[(-G)]",@"[(-H)]",@"[(-J)]",@"[(-K)]",@"[(-L)]",@"[(-Z)]",@"[(-X)]",@"[(-C)]",@"[(-V)]"];
    return names2;
}

+ (BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    if (!returnValue) {
//        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
//        
//        NSArray *arrEmoji = [GlobalObject getEmojiArray];
        //正则匹配要替换的文字的范围
        //正则表达式
        //    NSString * pattern = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
        NSString * pattern = @"\\[\\(\\-[A-Z]+\\)+\\]";
        NSError *error = nil;
        NSRegularExpression * re = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
        
        if (!re) {
            //        NSLog(@"%@", [error localizedDescription]);
        }
        
        //通过正则表达式来匹配字符串
        NSArray *resultArray = [re matchesInString:string options:0 range:NSMakeRange(0, string.length)];
        if (resultArray.count) {
            returnValue = YES;
        }
    }
    
    return returnValue;
}

@end
