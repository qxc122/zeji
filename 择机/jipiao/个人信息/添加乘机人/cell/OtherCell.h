//
//  OtherCell.h
//  jipiao
//
//  Created by Store on 2017/5/17.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, TextField_TYPE_ENMU)
{
    name_TextField_TYPE_ENMU,//姓名输入框
    sex_TextField_TYPE_ENMU,//性别
    
    
    xing_TextField_TYPE_ENMU,//姓 输入框
    ming_TextField_TYPE_ENMU,//名 输入框
    huzhao_TextField_TYPE_ENMU,//护照 输入框
    
    
    guoji_TextField_TYPE_ENMU,//选择国籍
    csrq_TextField_TYPE_ENMU,//出生日期
    yxq_TextField_TYPE_ENMU,//有效期
    
    phone_TextField_TYPE_ENMU,//手机号 输入框
};

@interface OtherCell : UITableViewCell
@property (nonatomic,weak) UILabel *huzhao;
@property (nonatomic,weak) UIView *lineOne;
@property (nonatomic,weak) UIView *back;

+ (instancetype)returnCellWith:(UITableView *)tableView;
/**
 *  填写了信息的时候用到
 */
@property (copy,nonatomic) void (^FillIn)(NSString *peopleOne,TextField_TYPE_ENMU type);

/**
 *  是否是默认出行人
 */
@property (copy,nonatomic) void (^isDefual)(BOOL isDefual);
/**
 *  切换了类型
 */
@property (copy,nonatomic) void (^reload)();

/**
 *  选择国籍
 */
@property (copy,nonatomic) void (^xuanzguoji)();
/**
 *  选择出生日期
 */
@property (copy,nonatomic) void (^xuanzcsrq)();
/**
 *  选择有效期
 */
@property (copy,nonatomic) void (^xuanzheYxq)();


#pragma --<选择 出生日期>
- (void)csrqiBtnBtnClick:(UIButton *)btn;
- (void)yxqBtnClick:(UIButton *)btn;



@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *sex;

@property (nonatomic,strong) NSString *idNumber;
@property (nonatomic,strong) NSDictionary *guoji;
@property (nonatomic,strong) NSString *chusriqi;
@property (nonatomic,strong) NSString *youxiaoqi;
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,assign) BOOL isDefualStr; //是否默认乘机人

-(void)textFieldDidChange :(UITextField *)textField;
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
@end
