//
//  rithtFlirhtdata.m
//  jipiao
//
//  Created by Store on 16/8/20.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "rithtFlirhtdata.h"
#import <objc/runtime.h>

@implementation rithtFlirhtdata
+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"historyInfo" : @"historyInfo",
            @"hasMore" : @"hasMore",
             };
}
- (NSMutableArray *)historyInfo{
    if (!_historyInfo) {
        _historyInfo = [[NSMutableArray alloc] init];
    }
    return _historyInfo;
}
+(NSValueTransformer *)historyInfoJSONTransformer{
//    return  [MTLJSONAdapter arrayTransformerWithModelClass:[rithtFlirhtdataone  class]];
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[rithtFlirhtdataone  class]];
}
@end

@implementation rithtFlirhtdataone
+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
                @"depDate" : @"depDate",
                @"journeyType" : @"journeyType",//航程类型
                @"depCityCode" : @"depCityCode",
                @"depCityName" : @"depCityName",
                @"arrCityCode" : @"arrCityCode",
                @"arrCityName" : @"arrCityName",
                @"queryDatetime" : @"queryDatetime",
                
                @"backArrCityCode" : @"backArrCityCode",
                @"backArrCityName" : @"backArrCityName",
                @"backDate" : @"backDate",
                @"backDepCityCode" : @"backDepCityCode",
                @"backDepCityName" : @"backDepCityName",
                
                @"arrCountryCode" : @"arrCountryCode",
                @"backArrCountryCode" : @"backArrCountryCode",
                @"backDepCountryCode" : @"backDepCountryCode",
                @"depCountryCode" : @"depCountryCode",
             };
}
@end
