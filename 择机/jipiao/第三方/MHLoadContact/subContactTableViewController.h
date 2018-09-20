//
//  subContactTableViewController.h
//  读取通讯录
//
//  Created by Store on 16/10/24.
//  Copyright © 2016年 hcl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHContactModel.h"

@interface subContactTableViewController : UITableViewController
@property (nonatomic,strong) MHContactModel *model;
@property (nonatomic,strong) NSString *NotificationName;
@end
