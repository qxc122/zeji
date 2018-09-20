//
//  leftmainCell.h
//  jipiao
//
//  Created by Store on 16/8/10.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderTotal.h"
#import "leftdataamain.h"



@interface leftmainCell : UITableViewCell
//@property (nonatomic,assign) BOOL IsmyNews;
+ (instancetype)returnCellWith:(UITableView *)tableView;
@property (nonatomic,strong) NSString *icon;
@property (nonatomic,strong) NSString *des;
@property (nonatomic,strong) NSString *numWeidu;
@end
