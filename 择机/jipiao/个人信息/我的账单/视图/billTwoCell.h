//
//  billTwoCell.h
//  jipiao
//
//  Created by Store on 16/9/2.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "xinyongdata.h"
#define  heigthvieetmpcont  10
#define  spaingvieetmptoptolinesbottomcont  10

@protocol  billTwoCellLJHKDelegate<NSObject>
- (void)btnClickLJHK;
@end

@interface billTwoCell : UIView
//@interface billTwoCell : UITableViewCell
@property (assign, nonatomic)  BOOL openOrClose;
@property (nonatomic,weak) id<billTwoCellLJHKDelegate>delegate;
@property (nonatomic,strong)xinyongdata *data;
//+ (instancetype)returnCellWith:(UITableView *)tableView;
@end
