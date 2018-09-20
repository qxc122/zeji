//
//  twomycell.h
//  jipiao
//
//  Created by Store on 16/8/18.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "myinfoData.h"

//@protocol twomycellDelegate <NSObject>
//- (void)twomycellmybtnClick;
//@end

@interface twomycell : UITableViewCell
//@property (nonatomic,strong)NSDictionary *data;
@property (nonatomic,strong)flyCreditInfoData *data;
@property (nonatomic,assign)NSInteger *index;
+ (instancetype)returnCellWith:(UITableView *)tableView;
//@property (nonatomic,weak)id<twomycellDelegate>delegate;
@end
