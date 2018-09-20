//
//  leftdataamain.m
//  jipiao
//
//  Created by Store on 16/8/12.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "leftdataamain.h"
#ifdef DEBUG
#import <objc/runtime.h>
#endif

@implementation GlobalParams
+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"startPicture" : @"startPicture",
             @"twoMa" : @"sharedQRCode",
             @"iosAuditFlagQ" : @"iosAuditFlagQ",
             
             @"activityImg" : @"activityImg",
             @"activityUrl" : @"activityUrl",
             @"activityTitle" : @"activityTitle",
             @"clearCacheFlag" : @"clearCacheFlag",
             };
}
@end

@implementation dicmenuArray
+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"menuArray" : @"menuArray",
             @"customerServicePhone" : @"customerServicePhone",
             };
}
- (NSMutableArray *)menuArray{
    if (!_menuArray) {
        _menuArray = [[NSMutableArray alloc] init];
    }
    return _menuArray;
}
+(NSValueTransformer *)menuArrayJSONTransformer{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[leftdataamain  class]];
//    return [MTLJSONAdapter arrayTransformerWithModelClass:[leftdataamain  class]];
}
@end

@implementation leftdataamain

+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"must_login_flag" : @"mustLoginFlag", 
             @"menuId" : @"menuId",
             @"menuName" : @"menuName",
             @"menuLogo" : @"menuLogo",
             @"url" : @"url",
             };
}

#ifdef DEBUG
- (NSString *)description
{
    unsigned int count;
    // 获取类的所有属性
    // 如果没有属性，则count为0，properties为nil
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    NSString *str = NSStringFromClass([self class]);
    
    for (NSUInteger i = 0; i < count; i++) {
        // 获取属性名称
        const char *propertyName = property_getName(properties[i]);
        NSString *name = [NSString stringWithUTF8String:propertyName];
        
        id value = [self valueForKey:name];
        str = [str stringByAppendingFormat:@" %@:%@\n",name,value];
    }
    // 注意，这里properties是一个数组指针，是C的语法，
    // 我们需要使用free函数来释放内存，否则会造成内存泄露
    free(properties);
    return str;
}
#endif
@end
