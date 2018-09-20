//
//  NSString+add.m
//  jipiao
//
//  Created by Store on 16/8/10.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "NSString+add.h"
#import <CommonCrypto/CommonDigest.h>
#import "HeaderTotal.h"

@implementation NSString (add)
+(NSString *)returntimestamp{
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    return  [formatter stringFromDate:[NSDate date]];
}
#pragma 正则匹配手机号
+ (BOOL)checkTelNumber:(NSString*) telNumber
{
    NSString *pattern =@"^1+[3578]+\\d{9}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    BOOL isMatch = [pred evaluateWithObject:telNumber];
    return isMatch;
}
#pragma 正则匹配身份证
+ (BOOL)checkIdCardNumber:(NSString*) telNumber
{
    NSString *pattern = @"(^[0-9]{15}$)|([0-9]{17}([0-9]|X|x)$)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:telNumber];
    return isMatch;
    
//    NSString *pattern =@"\\d{14}[[0-9],0-9xX]";
//    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
//    BOOL isMatch = [pred evaluateWithObject:telNumber];
//    return isMatch;
}
//获取系统当前的时间戳
+ (NSString *)returntimestampChuo{
    NSTimeInterval timeStamp = time(NULL);
    NSString *timeStr = @(timeStamp).stringValue;
    return timeStr;
    
//    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
//    NSTimeInterval a = [date timeIntervalSince1970]*1000;
//    NSString *str = [NSString stringWithFormat:@"%f",a];
//    return [NSString stringWithFormat:@"%f",a];
}
//MD5加密
+ (NSString *)md5HexDigest:(NSString *)str
{
    const char *original_str = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}
+ (CGFloat)returnSizeWidthWithString:(NSString *)str font:(NSInteger )font{
    UIFont *fron = [UIFont systemFontOfSize:font];
    NSDictionary *dicttt = @{NSFontAttributeName:fron,};
    // 如果将来计算的文字的范围小于指定的范围, 返回的就是真实的范围
    CGSize size =  [str boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:dicttt context:nil].size;
    return size.width;
}

#pragma mark - 计算内容文本的高度方法
+ (CGFloat)HeightForText:(NSString *)text withFont:(UIFont *)font withTextWidth:(CGFloat)textWidth
{
    // 获取文字字典
    NSDictionary *dict = @{NSFontAttributeName: font};
    // 设定最大宽高
    CGSize size = CGSizeMake(textWidth, CGFLOAT_MAX);
    // 计算文字Frame
    CGRect frame = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    return frame.size.height;
}

+ (NSString*)dictionaryToJsonNoCokieForJs:(NSDictionary *)dic{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:0 error:&parseError];
    NSString *tmp = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return tmp;
}

+ (NSString*)dictionaryToJsonForJs:(NSDictionary *)dic{
//    NSError *parseError = nil;
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:0 error:&parseError];
//    NSString *tmp = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    return tmp;
    if (![dic allKeys].count) {
        return @"{}";
    }
    NSString *strTT1 = [NSString stringWithFormat:@"%@",[dic description]];
    NSLog(@"strTT1=%@",strTT1);
    
    NSString *strTT21 = [strTT1 stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    NSLog(@"strTT21=%@",strTT21);
    
    NSString *strTT2 = [strTT21 stringByReplacingOccurrencesOfString:@"\n" withString:@"\""];
    NSLog(@"strTT2=%@",strTT2);
    
    NSString *strTT3 = [strTT2 stringByReplacingOccurrencesOfString:@" = " withString:@"\":\""];
    NSLog(@"strTT3=%@",strTT3);
    
    NSString *strTT4 = [strTT3 stringByReplacingOccurrencesOfString:@";" withString:@"\","];
    NSLog(@"strTT4=%@",strTT4);
    
    NSString *strTT5 = [strTT4 stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"strTT5=%@",strTT5);

    NSString *strTT6 = [strTT5 stringByReplacingOccurrencesOfString:@"\\U" withString:@"%u"];
    NSLog(@"strTT6=%@",strTT6);
    
    NSString *strTT7 = [strTT6 stringByReplacingOccurrencesOfString:@",\"}" withString:@"}"];
    NSLog(@"strTT7=%@",strTT7);
    
    NSString *strTT8 = [strTT7 stringByReplacingOccurrencesOfString:@"\"(\"" withString:@"["];
    NSLog(@"strTT8=%@",strTT8);
    
    NSString *strTT9 = [strTT8 stringByReplacingOccurrencesOfString:@"\")\"" withString:@"]"];
    NSLog(@"strTT9=%@",strTT9);
    
    NSString *strTT10 = [strTT9 stringByReplacingOccurrencesOfString:@"\"{" withString:@"{"];
    NSLog(@"strTT10=%@",strTT10);
    
    NSString *strTT11 = [strTT10 stringByReplacingOccurrencesOfString:@"}\"" withString:@"}"];
    NSLog(@"strTT11=%@",strTT11);
    
    NSString *strTT12 = [strTT11 stringByReplacingOccurrencesOfString:@"<null>" withString:@""];
    NSLog(@"strTT12=%@",strTT12);
    
//    NSString *strTT10 = [strTT9 stringByReplacingOccurrencesOfString:@"/" withString:@"/"];
//    NSLog(@"strTT10=%@",strTT10);
    
//    NSString *strTT7 = strTT6;
//    NSString *tmpRang = @",\"}";
//        strTT7 = [strTT7 substringToIndex:(strTT7.length -tmpRang.length)];
//        strTT7 = [strTT7 stringByAppendingString:@"}"];
//    }
    
    return strTT12;
}
+ (NSString*)dictionaryToJson:(NSDictionary *)dic{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
- (NSString *)returnNum:(NSString *)str{
    NSString *tmp = nil;
    tmp = [str substringFromIndex:4];
    return tmp;
//    NSScanner *scanner = [NSScanner scannerWithString:str];
//    [scanner scanUpToCharactersFromSet:[NSCharacterSet decimalDigitCharacterSet] intoString:nil];
//    int number;
//    [scanner scanInt:&number];
//    return [NSString stringWithFormat:@"%d",number];
}
+ (NSString *)returnPathWith:(NSString *)key{
    return  [MYHOMEPATH stringByAppendingPathComponent:[key stringByAppendingString:@".plist"]];
}
/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
//判断是不是大于0.01的数字  不超过两位小数
+ (BOOL)checkOKAmt:(NSString *)Amt{

    NSString *pattern =@"^[0-9]+(.[0-9]{0,2})?$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    BOOL isMatch = [pred evaluateWithObject:Amt];
    return isMatch;
    
//    NSString *regex =	@"^[0-9]+(.[0-9]{2})?$";
//    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
//    NSString *regex2 =	@"^[0-9]+(.[0-9]{1})?$";
//    NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex2];
//    NSString *regex3 =	@"^[0-9]+(.[0-9]{0})?$";
//    NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex3];
//    if(([pred evaluateWithObject:Amt] || [pred2 evaluateWithObject:Amt] || [pred3 evaluateWithObject:Amt])){
//        return YES;
//    }
//    return NO;
}
-(NSMutableDictionary*)getURLParametersFromUrl{
    NSRange  range = [self  rangeOfString:@"?"];
    if(range.location==NSNotFound) {
        return  nil;
    }
    NSMutableDictionary  *params = [NSMutableDictionary   dictionary];
    NSString  *parametersString = [self    substringFromIndex:range.location+1];
    if([parametersString   containsString:@"&"]) {
        NSArray  *urlComponents = [parametersString   componentsSeparatedByString:@"&"];
        for(NSString *keyValuePair in urlComponents) {
            //生成key/value
            NSArray *pairComponents = [keyValuePair  componentsSeparatedByString:@"="];
            NSString *key = [pairComponents.firstObject  stringByRemovingPercentEncoding];
            NSString*value = [pairComponents.lastObject  stringByRemovingPercentEncoding];
            //key不能为nil
            if(key==nil|| value ==nil) {
                continue;
            }
            id existValue = [params valueForKey:key];
            if(existValue !=nil) {
                
                //已存在的值，生成数组。
                
                if([existValue  isKindOfClass:[NSArray  class]]) {
                    
                    //已存在的值生成数组
                    
                    NSMutableArray*items = [NSMutableArray arrayWithArray:existValue];
                    
                    [items addObject:value];
                    
                    [params setValue:items forKey:key];
                    
                }else{
                    //非数组
                    [params setValue:@[existValue,value]forKey:key];
                }
            }else{
                //设置值
                [params setValue:value forKey:key];
            }
        }
    }else{
        //单个参数生成key/value
        NSArray *pairComponents = [parametersString  componentsSeparatedByString:@"="];
        if(pairComponents.count==1) {
            return nil;
        }
        //分隔值
        NSString *key = [pairComponents.firstObject  stringByRemovingPercentEncoding];
        NSString *value = [pairComponents.lastObject  stringByRemovingPercentEncoding];
        //key不能为nil
        if(key ==nil|| value ==nil) {
            return nil;
        }
        //设置值
        [params setValue:value forKey:key];
    }
    return params;
}
@end

