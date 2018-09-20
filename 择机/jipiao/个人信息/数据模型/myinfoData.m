//
//  myinfoData.m
//  jipiao
//
//  Created by Store on 16/8/17.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "myinfoData.h"


@implementation myinfoData
+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"userId" : @"userId",
             @"userName" : @"userName",
             @"mobile" : @"mobile",
             @"certType" : @"certType",
             @"certNo" : @"certNo",
             @"avatar" : @"avatar",
//             @"flyCreditInfotmp" : @"flyCreditInfo",
             
             @"passengerInfos" : @"passengerInfos",
             @"secretaryInfos" : @"secretaryInfos",
             @"realnameStatus" : @"realnameStatus",
             @"registerType" : @"registerType",
             };
}
//+ (NSValueTransformer *)flyCreditInfoJSONTransformer {
//    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[flyCreditInfoData class]]; 
//}
- (NSMutableArray *)passengerInfos{
    if (!_passengerInfos) {
        _passengerInfos = [[NSMutableArray alloc] init];
    }
    return _passengerInfos;
}
- (NSMutableArray *)secretaryInfos{
    if (!_secretaryInfos) {
        _secretaryInfos = [[NSMutableArray alloc] init];
    }
    return _secretaryInfos;
}
+(NSValueTransformer *)passengerInfosJSONTransformer{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[contactinformation  class]];
}
+(NSValueTransformer *)secretaryInfosJSONTransformer{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[contactinformationTwo  class]];
}
@end

@implementation flyCreditInfoData
+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
            @"flylevel" : @"flylevel",
             @"totalFlight" : @"totalFlight",
             @"totalMileage" : @"totalMileage",
             @"creditLimit" : @"creditLimit",
             };
}
+ (NSValueTransformer *)totalMileageJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSNumber *dateNum) {
        return [NSString stringWithFormat:@"%@",dateNum];
    } reverseBlock:^(NSString *date) {
        return date;
    }];
}
+ (NSValueTransformer *)totalFlightJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSNumber *dateNum) {
        return [NSString stringWithFormat:@"%@",dateNum];
    } reverseBlock:^(NSString *date) {
        return date;
    }];
}
+ (NSValueTransformer *)creditLimitJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:
            ^id(NSNumber *number)
            {
                return [NSString stringWithFormat:@"%@",number];
            } reverseBlock:^id(NSString *d) {
                return @[d];
            }];
}
@end

@implementation contactinformation
+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
              @"userName" : @"userName",
              @"certType" : @"certType",
              @"certNo" : @"certNo",
             @"mobile" : @"mobile",
             @"contactId" : @"contactId",
             @"avatar" : @"avatar",
             };
}
+ (NSValueTransformer *)contactIdJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:
            ^id(NSNumber *number)
            {
                return [NSString stringWithFormat:@"%@",number];
            } reverseBlock:^id(NSString *d) {
                return @[d];
            }];
}
@end
@implementation contactinformationTwo
+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"userName" : @"userName",
             @"mobile" : @"mobile",
             @"contactId" : @"contactId",
             };
}
+ (NSValueTransformer *)contactIdJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:
            ^id(NSNumber *number)
            {
                return [NSString stringWithFormat:@"%@",number];
            } reverseBlock:^id(NSString *d) {
                return @[d];
            }];
}
@end
