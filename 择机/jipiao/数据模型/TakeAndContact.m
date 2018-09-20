//
//  TakeAndContact.m
//  jipiao
//
//  Created by Store on 16/8/31.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "TakeAndContact.h"

@implementation contactsArry
+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"contacts":@"contacts",
             };
}
- (NSMutableArray *)contacts{
    if (!_contacts) {
        _contacts = [NSMutableArray array];
    }
    return _contacts;
}
+(NSValueTransformer *)contactsJSONTransformer{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[TakeAndContact  class]];
}
@end

@implementation TakeAndContact
+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
            @"contactId":@"contactId",
            @"contactType":@"contactType",
            @"userId":@"userId",
            @"othUserId":@"othUserId",
            @"mobile":@"mobile",
            @"name":@"name",
            @"sex":@"sex",
            @"certType":@"certType",
            @"certNo":@"certNo",
            @"birthday":@"birthday",
            @"friendFlag":@"friendFlag",
            @"easemobId":@"easemobId",
            @"avatar":@"avatar",
             };
}
+ (NSValueTransformer *)contactIdJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSNumber *dateNum) {
        return [NSString stringWithFormat:@"%@",dateNum];
    } reverseBlock:^(NSString *date) {
        return date;
    }];
}
- (NSString *)name{
    if (!_name) {
        _name = self.mobile;
    }
    return _name;
}
@end

@implementation EasemobInfo
+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"avatar":@"avatar",
             @"nikename":@"nikename",
             @"mobile":@"mobile",
             };
}
@end

@implementation universalpaymentInfo
+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"prepayId":@"prepayId",
             @"orderId":@"orderId",
             @"timestamp":@"timestamp",
             @"nonestr":@"nonestr",
             @"tranAmt":@"tranAmt",
             @"sign":@"sign",
             @"orderDesc":@"orderDesc",
             @"supportTcoin":@"supportTcoin",
             };
}
@end


