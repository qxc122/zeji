//
//  ChooseNationality.h
//  jipiao
//
//  Created by Store on 2017/5/16.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "baseVc.h"


@interface ChooseNationality : baseVc
/**
 *  填写了信息的时候用到
 */
@property (copy,nonatomic) void (^ChoseOK)(NSDictionary *dic);
@end
