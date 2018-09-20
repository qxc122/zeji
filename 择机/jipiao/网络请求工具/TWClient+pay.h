//
//  TWClient+pay.h
//  jipiao
//
//  Created by Store on 16/8/15.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "TWClient.h"

@interface TWClient (pay)
//通用支付
- (void)sendVerifyCodeWithreferenceId:(NSString *)referenceId
                            tranAmt:(NSNumber *)tranAmt
                            tranChannel:(NSString *)tranChannel
                              tranType:(NSString *)tranType
                         success:(RequestSuccess)successBlock
                         failure:(RequestFailure)failureBlock;

//查询支付状态
- (void)payStatusQueryWithorderId:(NSString *)orderId
                          success:(RequestSuccess)successBlock
                          failure:(RequestFailure)failureBlock;
//订单明细查询
- (void)orderInfoWithorderId:(NSString *)orderId
                              success:(RequestSuccess)successBlock
                              failure:(RequestFailure)failureBlock;
//我的账单
- (void)myBillsuccess:(RequestSuccess)successBlock
                     failure:(RequestFailure)failureBlock;
//查询个人信用信息
- (void)queryMyCreditsuccess:(RequestSuccess)successBlock
                     failure:(RequestFailure)failureBlock;
@end
