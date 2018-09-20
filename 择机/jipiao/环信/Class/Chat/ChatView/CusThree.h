//
//  CusThree.h
//  jipiao
//
//  Created by Store on 16/8/23.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CusThree : UITableViewCell
@property (nonatomic,strong) NSDictionary *dataDic;
+ (instancetype)returnCellWith:(UITableView *)tableView;
@end
