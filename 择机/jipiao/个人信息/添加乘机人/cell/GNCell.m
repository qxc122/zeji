//
//  GNCell.m
//  jipiao
//
//  Created by Store on 2017/5/16.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "GNCell.h"
#import "DefineUI.h"
#import "Masonry.h"
#import "HeaderTotal.h"



@interface GNCell ()<UITextFieldDelegate>
@property (nonatomic,weak) UITextField *nameInput;
@property (nonatomic,weak) UITextField *cardTypeInput;
@property (nonatomic,weak) UITextField *PhoneInput;
@property (nonatomic,weak) UIImageView *desIcon;
@end

@implementation GNCell
+ (instancetype)returnCellWith:(UITableView *)tableView
{
    GNCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[GNCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UIView *back = [[UIView alloc]init];
        back.backgroundColor = ColorWithHex(0xFFFFFF, 1.0);
        LRViewRadius(back, cornerRadius_width);
        [self.contentView addSubview:back];

        UILabel *name = [[UILabel alloc]init];
        [self.contentView addSubview:name];
        UITextField *nameInput = [[UITextField alloc]init];
        [self.contentView addSubview:nameInput];
        
        UIView *lineOne = [[UIView alloc]init];
        lineOne.backgroundColor = ColorWithHex(0x979797, 0.4);
        [self.contentView addSubview:lineOne];
        
        
        UILabel *cardType = [[UILabel alloc]init];
        [self.contentView addSubview:cardType];
        UIImageView *cardTypeIcon = [[UIImageView alloc]init];
        [self.contentView addSubview:cardTypeIcon];
        UIButton *cardTypeBtn = [[UIButton alloc]init];
        [self.contentView addSubview:cardTypeBtn];
        UITextField *cardTypeInput = [[UITextField alloc]init];
        [self.contentView addSubview:cardTypeInput];
        
        
        UIView *lineTwo = [[UIView alloc]init];
        lineTwo.backgroundColor = ColorWithHex(0x979797, 0.4);
        [self.contentView addSubview:lineTwo];
        

        UILabel *Phone = [[UILabel alloc]init];
        [self.contentView addSubview:Phone];
        UITextField *PhoneInput = [[UITextField alloc]init];
        [self.contentView addSubview:PhoneInput];
        
        
        UILabel *des = [[UILabel alloc]init];
        [self.contentView addSubview:des];
        UIImageView *desIcon = [[UIImageView alloc]init];
        [self.contentView addSubview:desIcon];
        UIButton *desIconBtn = [[UIButton alloc]init];
        [self.contentView addSubview:desIconBtn];
        
        [name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(30);
            make.top.equalTo(self.contentView).offset(24);
        }];
        
        [nameInput mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(108);
            make.right.equalTo(self.contentView).offset(-30);
            make.centerY.equalTo(name);
            make.height.equalTo(@(44));
        }];
        
        [lineOne mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(back).offset(0);
            make.right.equalTo(back).offset(0);
            make.top.equalTo(name.mas_bottom).offset(24);
            make.height.equalTo(@(0.5));
        }];

        [cardType mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(name);
            make.top.equalTo(lineOne.mas_bottom).offset(24);
        }];
        [cardTypeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cardType.mas_right);
            make.centerY.equalTo(cardType);
            make.width.equalTo(@8);
            make.height.equalTo(@4);
        }];
        [cardTypeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cardType);
            make.right.equalTo(cardTypeIcon);
            make.top.equalTo(cardType);
            make.bottom.equalTo(cardType);
        }];
        
        [cardTypeInput mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(nameInput);
            make.right.equalTo(nameInput);
            make.centerY.equalTo(cardType);
            make.height.equalTo(@(44));
        }];
        
        [lineTwo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lineOne);
            make.right.equalTo(lineOne);
            make.top.equalTo(cardType.mas_bottom).offset(24);
            make.height.equalTo(lineOne);
        }];
        
        [Phone mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(name);
            make.top.equalTo(lineTwo.mas_bottom).offset(24);
        }];
        
        [PhoneInput mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(nameInput);
            make.right.equalTo(nameInput);
            make.centerY.equalTo(Phone);
            make.height.equalTo(@(44));
        }];
        
        [back mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15);
            make.right.equalTo(self.contentView).offset(-15);
            make.top.equalTo(self.contentView);
            make.bottom.equalTo(Phone.mas_bottom).offset(24);
        }];
        [des mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(back);
            make.top.equalTo(back.mas_bottom).offset(20);
            make.bottom.equalTo(self.contentView).offset(-20);
        }];
        
        [desIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(des.mas_left).offset(-15);
            make.centerY.equalTo(des);
            make.width.equalTo(@14);
            make.height.equalTo(@14);
        }];
        
        [desIconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(desIcon);
            make.right.equalTo(des);
            make.centerY.equalTo(des);
            make.height.equalTo(@44);
        }];
        
        cardTypeIcon.image = ImageNamed(@"Group 4");
        desIcon.image = ImageNamed(@"勾");
        desIcon.highlightedImage = ImageNamed(@"矩形25");
        
        [nameInput addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [cardTypeInput addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [PhoneInput addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        

        [cardTypeBtn addTarget:self action:@selector(xuanZheClick:) forControlEvents:UIControlEventTouchUpInside];
        [desIconBtn addTarget:self action:@selector(xuanZheClick:) forControlEvents:UIControlEventTouchUpInside];
        desIconBtn.tag = 1;
        
        name.font = PingFangSC_Regular(15);
        name.textColor = ColorWithHex(0x2B3B54, 1.0);
        nameInput.font = PingFangSC_Regular(14);
        nameInput.textColor = ColorWithHex(0x2B3B54, 1.0);
        cardType.font = PingFangSC_Regular(15);
        cardType.textColor = ColorWithHex(0x2B3B54, 1.0);
        cardTypeInput.font = PingFangSC_Regular(14);
        cardTypeInput.textColor = ColorWithHex(0x2B3B54, 1.0);
        Phone.font = PingFangSC_Regular(15);
        Phone.textColor = ColorWithHex(0x2B3B54, 1.0);
        PhoneInput.font = PingFangSC_Regular(14);
        PhoneInput.textColor = ColorWithHex(0x2B3B54, 1.0);
        
        des.font = PingFangSC_Regular(14);
        des.textColor = ColorWithHex(0xFFFFFF, 1.0);
        des.text = @"设为默认乘机人";
        name.text = @"姓名";
        cardType.text = @"身份证";
        Phone.text = @"手机号";
        
        nameInput.placeholder = @"乘机人真实姓名";
        cardTypeInput.placeholder = @"所持证件号码";
        PhoneInput.placeholder = @"用户接收航司短信";
        self.nameInput = nameInput;
        self.cardTypeInput = cardTypeInput;
        self.PhoneInput = PhoneInput;
        self.desIcon = desIcon;
        self.nameInput.tag = name_TextField_TYPEGNCell_ENMU;
        self.cardTypeInput.tag = card_TextField_TYPEGNCell_ENMU;
        self.PhoneInput.tag = phone_TextField_TYPEGNCell_ENMU;
        self.nameInput.delegate = self;
        self.cardTypeInput.delegate = self;
        self.PhoneInput.delegate = self;
        [self.nameInput setValue:placeholderLabeltextColor forKeyPath:@"_placeholderLabel.textColor"];
        [self.cardTypeInput setValue:placeholderLabeltextColor forKeyPath:@"_placeholderLabel.textColor"];
        [self.PhoneInput setValue:placeholderLabeltextColor forKeyPath:@"_placeholderLabel.textColor"];
        self.PhoneInput.keyboardType = UIKeyboardTypePhonePad;
        self.cardTypeInput.keyboardType = UIKeyboardTypeASCIICapable;
    }
    return self;
}
-(void)textFieldDidChange :(UITextField *)textField{
    if (self.FillIn) {
        self.FillIn(textField.text,textField.tag);
    }
}

- (void)xuanZheClick:(UIButton *)sender{
    NSLog(@"%s",__FUNCTION__);
    if (sender.tag == 0) {
        if (self.reload) {
            self.reload();
        }
    } else if (sender.tag == 1) {
        self.desIcon.highlighted = !self.desIcon.highlighted;
        if (self.isDefual) {
            self.isDefual(self.desIcon.highlighted);
        }
    }
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string

{
    NSUInteger length = textField.text.length + string.length;
    
    if (textField.tag == name_TextField_TYPEGNCell_ENMU) {
        //        if (length > 15) {
        //            [textField resignFirstResponder];
        //            [MBProgressHUD showPrompt:@"不超过15个字"];
        //            return NO;
        //        }
    } else if (textField.tag == card_TextField_TYPEGNCell_ENMU) {
        if (length > 18) {
            [textField resignFirstResponder];
            [MBProgressHUD showMessage:@"最多输入18位身份证号"];
            return NO;
        }
    } else if (textField.tag == phone_TextField_TYPEGNCell_ENMU) {
        if (length > 11) {
            [textField resignFirstResponder];
            [MBProgressHUD showMessage:@"最多输入11位手机号"];
            return NO;
        }
    }
    return YES;
}

- (void)setName:(NSString *)name{
    _name = name;
    self.nameInput.text = name;
}
- (void)setIdNumber:(NSString *)idNumber{
    _idNumber = idNumber;
    self.cardTypeInput.text = idNumber;
}
- (void)setPhone:(NSString *)phone{
    _phone = phone;
    self.PhoneInput.text = phone;
}
- (void)setIsDefualStr:(BOOL)isDefualStr{
    _isDefualStr = isDefualStr;
    self.desIcon.highlighted = isDefualStr;
}
@end
