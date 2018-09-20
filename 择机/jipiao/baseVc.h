//
//  baseVc.h
//  jipiao
//
//  Created by admin on 16/7/25.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "MJRefresh.h"
#import "DefineUI.h"
#import "UIScrollView+EmptyDataSet.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "MBProgressHUD.h"

typedef NS_ENUM(NSInteger, empty_num)
{
    In_loading_empty_num , //加载中
    fail_empty_num = 5, //加载失败
    logout_empty_num,   //未登录
    succes_empty_num,   //加载成功
};


@interface baseVc : UIViewController
- (void)GoZeJiregister;
- (void)popSelf;
@property (nonatomic,assign) empty_num  empty_type;
@end
