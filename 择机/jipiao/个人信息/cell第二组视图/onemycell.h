//
//  onemycell.h
//  jipiao
//
//  Created by Store on 16/8/18.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol onemycellDelegate <NSObject>
- (void)showMSg:(NSString *)msg;
- (void)mybtnClick:(NSInteger)index :(NSString *)msg;
@end


@interface onemycell : UITableViewCell
@property (nonatomic,strong)NSString *realnameStatus;//实名状态0：未实名
//1：已实名
@property (nonatomic,strong)NSString *registerType; //注册类型00：手机注册
//01：微信注册

@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *des;
@property (nonatomic,assign)NSInteger index;
@property (nonatomic,assign)BOOL isHiddenArrow; //是否隐藏箭头号

+ (instancetype)returnCellWith:(UITableView *)tableView;
@property (nonatomic,weak)id<onemycellDelegate>delegate;
@end
