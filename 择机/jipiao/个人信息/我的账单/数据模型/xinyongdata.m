//
//  xinyongdata.m
//  jipiao
//
//  Created by Store on 16/9/5.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "xinyongdata.h"

@implementation xinyongdata
+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"flylevel" : @"flylevel",
             @"totalFlight" : @"totalFlight",
             @"totalMileage" : @"totalMileage",
             @"creditLimit" : @"creditLimit",
             @"usedLimit" : @"usedLimit",
             @"avalibleLimit" : @"avalibleLimit",
             @"needRepay" : @"needRepay",
             @"loanList" : @"loanList",
             @"totalLoanAmt" : @"totalLoanAmt",
             @"totalRemainPrinc" : @"totalRemainPrinc",
             @"totalRemainInt" : @"totalRemainInt",
             @"loanAgreement" : @"loanAgreement",
             @"loanRateDesc" : @"loanRateDesc",
             };
}
- (NSMutableArray *)loanList{
    if (!_loanList) {
        _loanList = [[NSMutableArray alloc] init];
    }
    return _loanList;
}

+(NSValueTransformer *)loanListJSONTransformer{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[xinyongdataOne  class]];
}

+ (NSValueTransformer *)totalLoanAmtJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSNumber *dateNum) {
        return [NSString stringWithFormat:@"%@",dateNum];
    } reverseBlock:^(NSString *date) {
        return date;
    }];
}
+ (NSValueTransformer *)totalRemainPrincJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSNumber *dateNum) {
        return [NSString stringWithFormat:@"%@",dateNum];
    } reverseBlock:^(NSString *date) {
        return date;
    }];
}
+ (NSValueTransformer *)totalRemainIntJSONTransformer {
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
+ (NSValueTransformer *)totalMileageJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSNumber *dateNum) {
        return [NSString stringWithFormat:@"%@",dateNum];
    } reverseBlock:^(NSString *date) {
        return date;
    }];
}
+ (NSValueTransformer *)creditLimitJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSNumber *dateNum) {
        return [NSString stringWithFormat:@"%@",dateNum];
    } reverseBlock:^(NSString *date) {
        return date;
    }];
}
+ (NSValueTransformer *)usedLimitJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSNumber *dateNum) {
        return [NSString stringWithFormat:@"%@",dateNum];
    } reverseBlock:^(NSString *date) {
        return date;
    }];
}
+ (NSValueTransformer *)avalibleLimitJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSNumber *dateNum) {
        return [NSString stringWithFormat:@"%@",dateNum];
    } reverseBlock:^(NSString *date) {
        return date;
    }];
}
+ (NSValueTransformer *)needRepayJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSNumber *dateNum) {
        return [NSString stringWithFormat:@"%@",dateNum];
    } reverseBlock:^(NSString *date) {
        return date;
    }];
}

@end

@implementation xinyongdataOne
+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"loanDate" : @"loanDate",
             @"loanAmt" : @"loanAmt",
             @"remainPrinc" : @"remainPrinc",
             @"remainInt" : @"remainInt",
             };
}
//+ (NSValueTransformer *)loanDateJSONTransformer {
//    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSNumber *dateNum) {
//        return [NSString stringWithFormat:@"%@",dateNum];
//    } reverseBlock:^(NSString *date) {
//        return date;
//    }];
//}
//+ (NSValueTransformer *)loanAmtJSONTransformer {
//    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSNumber *dateNum) {
//        return [NSString stringWithFormat:@"%@",dateNum];
//    } reverseBlock:^(NSString *date) {
//        return date;
//    }];
//}
//+ (NSValueTransformer *)remainPrincJSONTransformer {
//    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSNumber *dateNum) {
//        return [NSString stringWithFormat:@"%@",dateNum];
//    } reverseBlock:^(NSString *date) {
//        return date;
//    }];
//}
//+ (NSValueTransformer *)remainIntJSONTransformer {
//    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSNumber *dateNum) {
//        return [NSString stringWithFormat:@"%@",dateNum];
////        double tmp = [dateNum doubleValue];
////        return [NSString stringWithFormat:@"%.2f",tmp];
//    } reverseBlock:^(NSString *date) {
//        return date;
//    }];
//}
@end


@implementation billListdata
+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"billList" : @"billList",
             };
}
- (NSMutableArray *)billList{
    if (!_billList) {
        _billList = [[NSMutableArray alloc] init];
    }
    return _billList;
}

+(NSValueTransformer *)billListJSONTransformer{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[billListdataOne  class]];
}
@end

@implementation billListdataOne
+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"tranType" : @"tranType",
              @"tranTypeDesc" : @"tranTypeDesc",
              @"tranDatetime" : @"tranDatetime",
             
//              @"loanDate" : @"loanDate",
//              @"depDate" : @"depDate",
             
             @"tranChannel" : @"tranChannel",
             @"tranChannelDesc" : @"tranChannelDesc",
             @"tranAmt" : @"tranAmt",
             
//             @"billLogo" : @"billLogo",
//             @"depCityCode" : @"depCityCode",
//             @"depCityName" : @"depCityName",
//             @"arrCityCode" : @"arrCityCode",
//             @"arrCityName" : @"arrCityName",
//             @"airCode" : @"airCode",
//             @"airName" : @"airName",
             };
}
+ (NSValueTransformer *)tranAmtJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSNumber *dateNum) {
        return [NSString stringWithFormat:@"%@",dateNum];
    } reverseBlock:^(NSString *date) {
        return date;
    }];
}
@end

