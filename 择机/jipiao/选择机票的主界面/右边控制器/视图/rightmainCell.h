//
//  rightmainCell.h
//  jipiao
//
//  Created by Store on 16/8/10.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderTotal.h"
#import "rithtFlirhtdata.h"

@interface rightmainCell : UITableViewCell
@property (nonatomic,strong) rithtFlirhtdataone *data;
+ (instancetype)returnCellWith:(UITableView *)tableView;
@end
