//
//  ViewController.h
//  jipiao
//
//  Created by admin on 16/7/25.
//  Copyright © 2016年 admin. All rights reserved.
//


#import "baseWebView.h"


//#import <UIKit/UIKit.h>
#import "HeaderTotal.h"



@interface zejiMain : baseWebView
@property (nonatomic,assign) AIRLINETICKETTYPE ticketype; //机票类型
@property (nonatomic,assign) BOOL isClose; //是否是个人信息我的优惠码进来的

@end

