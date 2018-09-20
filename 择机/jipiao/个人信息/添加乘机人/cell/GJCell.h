//
//  GJCell.h
//  jipiao
//
//  Created by Store on 2017/5/16.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "OtherCell.h"

@interface GJCell : OtherCell
+ (instancetype)returnCellWith:(UITableView *)tableView;
@property (nonatomic,strong) NSString *xing;
@property (nonatomic,strong) NSString *ming;
@end
