//
//  youhuimaCell.h
//  jipiao
//
//  Created by Store on 16/9/27.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol youhuimaCellDelegate <NSObject>
@optional
- (void)addyouhuiquanWithCode:(NSString *)code;
- (void)sigoutSelfh;
@end

@interface youhuimaCell : UITableViewCell
@property (nonatomic,weak) id<youhuimaCellDelegate> delegate;
+ (instancetype)returnCellWith:(UITableView *)tableView;
@end
