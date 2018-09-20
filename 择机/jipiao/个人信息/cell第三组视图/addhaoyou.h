//
//  addhaoyou.h
//  jipiao
//
//  Created by Store on 16/8/19.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  addhaoyouDelegate<NSObject>
- (void)goToAddFriendsWithname:(NSString *)name tel:(NSString *)tel certType:(NSString *)certType certNo:(NSString *)certNo birthday:(NSString *)birthday;
- (void)Selectthetypeofdocument:(BOOL)IsIDcard;
- (void)CloseAddFriends;
@end

@interface addhaoyou : UITableViewCell
@property (nonatomic,weak)id<addhaoyouDelegate>delegate;
+ (instancetype)returnCellWith:(UITableView *)tableView;
@property (nonatomic,assign) BOOL IsIDcard;
@property (nonatomic,strong)NSString *phoneTel;  //存通讯录返回的电话
@property (nonatomic,strong)NSString *phoneName;  //存通讯录返回的电话
@end
