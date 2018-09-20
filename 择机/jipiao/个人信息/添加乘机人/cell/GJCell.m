//
//  GJCell.m
//  jipiao
//
//  Created by Store on 2017/5/16.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "GJCell.h"
#import "DefineUI.h"
#import "Masonry.h"
#import "HeaderTotal.h"
#import "UIImage+cir.h"



@interface GJCell ()<UITextFieldDelegate>
@property (nonatomic,weak) UITextField *xingInput;
@property (nonatomic,weak) UITextField *mingInput;
@end

@implementation GJCell
+ (instancetype)returnCellWith:(UITableView *)tableView
{
    GJCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[GJCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        
        UILabel *xing = [[UILabel alloc]init];
        [self.contentView addSubview:xing];
        UITextField *xingInput = [[UITextField alloc]init];
        [self.contentView addSubview:xingInput];
        
        UIView *lineTwo = [[UIView alloc]init];
        lineTwo.backgroundColor = ColorWithHex(0x979797, 0.4);
        [self.contentView addSubview:lineTwo];
        
        UILabel *ming = [[UILabel alloc]init];
        [self.contentView addSubview:ming];
        UITextField *mingInput = [[UITextField alloc]init];
        [self.contentView addSubview:mingInput];
        
        UIView *lineThree = [[UIView alloc]init];
        lineThree.backgroundColor = ColorWithHex(0x979797, 0.4);
        [self.contentView addSubview:lineThree];
        
        [xing mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(30);
            make.top.equalTo(self.lineOne.mas_bottom).offset(24);
        }];
        
        [xingInput mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(102);
            make.right.equalTo(self.contentView).offset(-30);
            make.centerY.equalTo(xing);
            make.height.equalTo(@(44));
        }];
        
        [lineTwo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.back).offset(0);
            make.right.equalTo(self.back).offset(0);
            make.top.equalTo(xing.mas_bottom).offset(24);
            make.height.equalTo(@(0.5));
        }];
        [ming mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(30);
            make.top.equalTo(lineTwo.mas_bottom).offset(24);
        }];
        
        [mingInput mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(102);
            make.right.equalTo(self.contentView).offset(-30);
            make.centerY.equalTo(ming);
            make.height.equalTo(@(44));
        }];
        
        [lineThree mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.back).offset(0);
            make.right.equalTo(self.back).offset(0);
            make.top.equalTo(ming.mas_bottom).offset(24);
            make.height.equalTo(@(0.5));
        }];
        [self.huzhao mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(30);
            make.top.equalTo(lineThree.mas_bottom).offset(24);
        }];

        [xingInput addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [mingInput addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

        xing.font = PingFangSC_Regular(15);
        xing.textColor = ColorWithHex(0x2B3B54, 1.0);
        xingInput.font = PingFangSC_Regular(14);
        xingInput.textColor = ColorWithHex(0x2B3B54, 1.0);
        ming.font = PingFangSC_Regular(15);
        ming.textColor = ColorWithHex(0x2B3B54, 1.0);
        mingInput.font = PingFangSC_Regular(14);
        mingInput.textColor = ColorWithHex(0x2B3B54, 1.0);


        xing.text = @"英文姓";
        ming.text = @"英文名";
        self.huzhao.text = @"护照";
        xingInput.placeholder = @"如张三填“ZHANG”";
        mingInput.placeholder = @"如张三填“SHAN”";

        self.xingInput = xingInput;
        self.mingInput = mingInput;

        self.xingInput.delegate = self;
        self.mingInput.delegate = self;
        self.xingInput.tag = xing_TextField_TYPE_ENMU;
        self.mingInput.tag = ming_TextField_TYPE_ENMU;
        
        [self.xingInput setValue:placeholderLabeltextColor forKeyPath:@"_placeholderLabel.textColor"];
        [self.mingInput setValue:placeholderLabeltextColor forKeyPath:@"_placeholderLabel.textColor"];
        self.xingInput.keyboardType = UIKeyboardTypeASCIICapable;
        self.mingInput.keyboardType = UIKeyboardTypeASCIICapable;
    }
    return self;
}


-(void)textFieldDidChange :(UITextField *)textField{
    textField.text = [textField.text uppercaseString];
    [super textFieldDidChange:textField];
}



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string

{
    [super textField:textField shouldChangeCharactersInRange:range replacementString:string];
    return YES;
}


//#pragma --<选择 出生日期>
//- (void)csrqiBtnBtnClick:(UIButton *)btn{
//    NSLog(@"%s",__func__);
//    [super csrqiBtnBtnClick:btn];
//    [self guanbitefiINTwo];
//
//}
//#pragma --<选择 有效期>
//- (void)yxqBtnClick:(UIButton *)btn{
//    NSLog(@"%s",__func__);
//    [super yxqBtnClick:btn];
//    [self guanbitefiINTwo];
//}
//
//- (void)guanbitefiINTwo{
//    if ([self.xingInput isFirstResponder]) {
//        [self.xingInput resignFirstResponder];
//    } else if ([self.mingInput isFirstResponder]) {
//        [self.mingInput resignFirstResponder];
//    }
//}
- (void)setXing:(NSString *)xing{
    _xing = xing;
    self.xingInput.text = xing;
}
- (void)setMing:(NSString *)ming{
    _ming = ming;
    self.mingInput.text = ming;
}
@end
