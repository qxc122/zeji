//
//  fourmycell.h
//  jipiao
//
//  Created by Store on 16/8/18.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "myinfoData.h"

@protocol fourbtnnnmycellDelegate <NSObject>
- (void)fourmycellbtnnnClick:(NSIndexPath *)index;

@end


@interface fourmycell : UITableViewCell
@property (nonatomic,strong)NSString *msg;

@property (nonatomic,strong)contactinformation *data;
@property (nonatomic,strong)contactinformationTwo *datatwo;
@property (nonatomic,strong)NSIndexPath *index;
@property (nonatomic,weak)id<fourbtnnnmycellDelegate>delegate;
+ (instancetype)returnCellWith:(UITableView *)tableView;
@end
