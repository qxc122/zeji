//
//  QCarouselData.m
//  jipiao
//
//  Created by Store on 16/8/11.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "QCarouselData.h"
#import <objc/runtime.h>

@implementation QCarouselDataArry
+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"appArray" : @"appArray",
             };
}
//- (NSMutableArray *)appArray{
//    if (!_appArray) {
//        _appArray = [[NSMutableArray alloc] init];
//    }
//    return _appArray;
//}
+(NSValueTransformer *)appArrayJSONTransformer{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[QCarouselData  class]];
//    return  [MTLJSONAdapter arrayTransformerWithModelClass:[QCarouselData  class]];
}
@end

@implementation QCarouselData
+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"addLogo" : @"addLogo",
             @"appName" : @"appName",
             @"openMode" : @"openMode",
             @"url" : @"url",
             @"param" : @"param",
             };
}
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
@end
