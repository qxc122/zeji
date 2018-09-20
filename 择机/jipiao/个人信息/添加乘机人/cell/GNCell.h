//
//  GNCell.h
//  jipiao
//
//  Created by Store on 2017/5/16.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TextField_TYPEGNCell_ENMU)
{
    name_TextField_TYPEGNCell_ENMU,//名字输入框
    card_TextField_TYPEGNCell_ENMU,//身份证输入框
    phone_TextField_TYPEGNCell_ENMU,//电话输入框
};

@interface GNCell : UITableViewCell
+ (instancetype)returnCellWith:(UITableView *)tableView;
/**
 *  填写了信息的时候用到
 */
@property (copy,nonatomic) void (^FillIn)(NSString *peopleOne,TextField_TYPEGNCell_ENMU type);


/**
 *  切换了类型
 */
@property (copy,nonatomic) void (^reload)();
/**
 *  是否是默认出行人
 */
@property (copy,nonatomic) void (^isDefual)(BOOL isDefual);




@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *idNumber;
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,assign) BOOL isDefualStr; //是否默认乘机人
@end
