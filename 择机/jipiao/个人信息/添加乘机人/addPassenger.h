//
//  addPassenger.h
//  jipiao
//
//  Created by Store on 2017/5/16.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "baseVc.h"

typedef NS_ENUM(NSInteger, addPassenger_TYPE)
{
    GJ_addPassenger_TYPE,//国际
    GN_addPassenger_TYPE,//国内
    Other_addPassenger_TYPE,//其他
};


@interface addPassenger : baseVc
@property (nonatomic,assign) addPassenger_TYPE type; //国际还是国内
/**
 *  切换了类型
 */
@property (copy,nonatomic) void (^reload)();
@end
