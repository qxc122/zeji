//
//  addmishu.h
//  jipiao
//
//  Created by Store on 16/8/19.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  addmishuDelegate<NSObject>
- (void)returnClickyyyaddmishu:(NSString *)phone;
@end

@interface addmishu : UITableViewCell
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,weak)id<addmishuDelegate>delegate;
+ (instancetype)returnCellWith:(UITableView *)tableView;
@end
