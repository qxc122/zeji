//
//  NSString+add.h
//  jipiao
//
//  Created by Store on 16/8/10.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (add)
+(NSString *)returntimestamp;

+ (BOOL)checkTelNumber:(NSString*) telNumber;
+ (BOOL)checkIdCardNumber:(NSString*) telNumber;
+ (NSString *)returntimestampChuo;
+ (NSString *)md5HexDigest:(NSString *)str;
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;
+ (NSString*)dictionaryToJsonForJs:(NSDictionary *)dic;//cookie
+ (NSString*)dictionaryToJsonNoCokieForJs:(NSDictionary *)dic;//None cookie
+ (CGFloat)returnSizeWidthWithString:(NSString *)str font:(NSInteger )font;
- (NSString *)returnNum:(NSString *)str;  //提取数字
+ (NSString *)returnPathWith:(NSString *)key;  //获取plist的路径
/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
//判断是不是大于0.01的数字  不超过两位小数
+ (BOOL)checkOKAmt:(NSString *)Amt;

#pragma mark - 计算内容文本的高度方法
+ (CGFloat)HeightForText:(NSString *)text withFont:(UIFont *)font withTextWidth:(CGFloat)textWidth;

-(NSMutableDictionary*)getURLParametersFromUrl;

@end
