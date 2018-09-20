//
//  billOneCell.h
//  jipiao
//
//  Created by Store on 16/9/2.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "xinyongdata.h"

@interface billOneCell : UITableViewCell
@property (nonatomic,strong)billListdataOne *data;
+ (instancetype)returnCellWith:(UITableView *)tableView;
@end
