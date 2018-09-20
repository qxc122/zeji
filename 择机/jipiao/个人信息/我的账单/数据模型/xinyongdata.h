//
//  xinyongdata.h
//  jipiao
//
//  Created by Store on 16/9/5.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <Mantle/Mantle.h>



@interface xinyongdata : MTLModel<MTLJSONSerializing>
@property (nonatomic,strong) NSString* flylevel;//	信用等级
@property (nonatomic,strong) NSString* totalFlight;//累计行段
@property (nonatomic,strong) NSString* totalMileage;//累计里程
@property (nonatomic,strong) NSString* creditLimit;//信用额度
@property (nonatomic,strong) NSString* usedLimit;//使用额度
@property (nonatomic,strong) NSString* avalibleLimit;//可用额度
@property (nonatomic,strong) NSString* needRepay;//应还本息
@property (nonatomic,strong) NSMutableArray* loanList;//贷款信息	Array
@property (nonatomic,strong) NSString *totalLoanAmt;//总贷款金额
@property (nonatomic,strong) NSString *totalRemainPrinc;//总剩余本金
@property (nonatomic,strong) NSString *totalRemainInt;//总剩余利息
@property (nonatomic,strong) NSString* loanAgreement;//协议查看
@property (nonatomic,strong) NSString* loanRateDesc;//利息描叙
@end

@interface xinyongdataOne : MTLModel<MTLJSONSerializing>
@property (nonatomic,strong) NSString* loanDate;//贷款日期
@property (nonatomic,strong) NSNumber* loanAmt;//贷款金额
@property (nonatomic,strong) NSNumber* remainPrinc;//剩余本金
@property (nonatomic,strong) NSNumber* remainInt;//剩余利息
@end

@interface billListdata : MTLModel<MTLJSONSerializing>
@property (nonatomic,strong) NSMutableArray* billList;//账单信息
@end
@interface billListdataOne : MTLModel<MTLJSONSerializing>
@property (nonatomic,strong) NSString* tranType;//交易类型
@property (nonatomic,strong) NSString* tranTypeDesc;//交易类型描述
@property (nonatomic,strong) NSString* tranDatetime;//交易时间

//@property (nonatomic,strong) NSString* loanDate;//贷款日期
//@property (nonatomic,strong) NSString* depDate;//出发日期

@property (nonatomic,strong) NSString* tranChannel;//	交易渠道
@property (nonatomic,strong) NSString* tranChannelDesc;//	交易渠道描述
@property (nonatomic,strong) NSString* tranAmt;//	交易金额

//@property (nonatomic,strong) NSString* billLogo;//	账单logo
//@property (nonatomic,strong) NSString* depCityCode;//	出发城市三字码
//@property (nonatomic,strong) NSString* depCityName;//	出发城市
//@property (nonatomic,strong) NSString* arrCityCode;//	抵达城市三字码
//@property (nonatomic,strong) NSString* arrCityName;//	抵达城市
//@property (nonatomic,strong) NSString* airCode;//	航司二字码
//@property (nonatomic,strong) NSString* airName;//	航司名称
@end
