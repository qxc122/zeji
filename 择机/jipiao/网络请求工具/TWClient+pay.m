//
//  TWClient+pay.m
//  jipiao
//
//  Created by Store on 16/8/15.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "TWClient+pay.h"
#import "DefineURL.h"

@implementation TWClient (pay)

//通用支付
- (void)sendVerifyCodeWithreferenceId:(NSString *)referenceId
                              tranAmt:(NSNumber *)tranAmt
                          tranChannel:(NSString *)tranChannel
                             tranType:(NSString *)tranType
                              success:(RequestSuccess)successBlock
                              failure:(RequestFailure)failureBlock{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    if (referenceId) {
        [parameters setValue:referenceId forKey:@"referenceId"];
    }
    if (tranAmt) {
        [parameters setValue:tranAmt forKey:@"tranAmt"];
    }
    if (tranChannel) {
        [parameters setValue:tranChannel forKey:@"tranChannel"];
    }
    if (tranType) {
        [parameters setValue:tranType forKey:@"tranType"];
    }
//#define wechatTYZF  @"wechat" //"wechat:微信
//#define alipayTYZF  @"alipay"//alipay:支付宝
//#define tpurseTYZF  @"tpurse"//tpurse：t钱包
//#define flyCreditTYZF  @"flyCredit"//flyCredit:飞行信用"
//#define JPZFTYZF  @"JPZF"//"JPZF:机票购买支付
//#define XCZFTYZF  @"XCZF"//XCZF:行程单配送支付
//#define BXZFTYZF  @"BXZF"//BXZF:保险支付
//#define DZZFTYZF  @"DZZF"//DZZF:订制支付
//#define HKZFTYZF  @"HKZF"//HKZF:信用还款支付"
    [[TWClient sharedInstance]postWithPath:REQUESTURLcashpay parameters:parameters success:successBlock failure:failureBlock];
}
//查询支付状态
- (void)payStatusQueryWithorderId:(NSString *)orderId
                              success:(RequestSuccess)successBlock
                              failure:(RequestFailure)failureBlock{
    NSDictionary *parameters = @{
                                 @"orderId":orderId,
                                 };
    [[TWClient sharedInstance]postWithPath:REQUESTURLpayStatusQuery parameters:parameters success:successBlock failure:failureBlock];
}

//订单明细查询
- (void)orderInfoWithorderId:(NSString *)orderId
                          success:(RequestSuccess)successBlock
                     failure:(RequestFailure)failureBlock{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    if (orderId) {
        [parameters setValue:orderId forKey:@"orderId"];
    }
    [[TWClient sharedInstance]postWithPath:REQUESTURLorderInfo parameters:parameters success:successBlock failure:failureBlock];
}
//我的账单
- (void)myBillsuccess:(RequestSuccess)successBlock
              failure:(RequestFailure)failureBlock{
    [[TWClient sharedInstance]postWithPath:REQUESTURLmyBill parameters:nil success:successBlock failure:failureBlock];
}
//查询个人信用信息
- (void)queryMyCreditsuccess:(RequestSuccess)successBlock
              failure:(RequestFailure)failureBlock{
    [[TWClient sharedInstance]postWithPath:REQUESTURLqueryMyCredit parameters:nil success:successBlock failure:failureBlock];
}
@end
