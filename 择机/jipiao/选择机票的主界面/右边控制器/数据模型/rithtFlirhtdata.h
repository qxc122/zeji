//
//  rithtFlirhtdata.h
//  jipiao
//
//  Created by Store on 16/8/20.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface rithtFlirhtdata : MTLModel<MTLJSONSerializing>
@property (nonatomic,strong) NSMutableArray *historyInfo;
@property (nonatomic,strong) NSString *hasMore;

@end

@interface rithtFlirhtdataone : MTLModel<MTLJSONSerializing>
@property (nonatomic,strong) NSString *depDate;
@property (nonatomic,strong) NSString *journeyType;
@property (nonatomic,strong) NSString *depCityCode;
@property (nonatomic,strong) NSString *depCityName;
@property (nonatomic,strong) NSString *arrCityCode;
@property (nonatomic,strong) NSString *arrCityName;
@property (nonatomic,strong) NSString *queryDatetime;


@property (nonatomic,strong) NSString *backArrCityCode;
@property (nonatomic,strong) NSString *backArrCityName;
@property (nonatomic,strong) NSString *backDate;
@property (nonatomic,strong) NSString *backDepCityCode;
@property (nonatomic,strong) NSString *backDepCityName;

@property (nonatomic,strong) NSString *arrCountryCode;
@property (nonatomic,strong) NSString *backArrCountryCode;
@property (nonatomic,strong) NSString *backDepCountryCode;
@property (nonatomic,strong) NSString *depCountryCode;
@end
