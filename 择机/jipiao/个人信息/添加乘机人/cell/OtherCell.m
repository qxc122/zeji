//
//  OtherCell.m
//  jipiao
//
//  Created by Store on 2017/5/17.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "OtherCell.h"
#import "DefineUI.h"
#import "Masonry.h"
#import "HeaderTotal.h"
#import "UIImage+cir.h"
#import "datePiker.h"
#import "NSDate+DateTools.h"



@interface OtherCell ()<UITextFieldDelegate>
@property (nonatomic,weak) UITextField *nameInput;
@property (nonatomic,weak) UITextField *huzhaoInput;
@property (nonatomic,weak) UITextField *guojiInput;
@property (nonatomic,weak) UITextField *csrqInput;
@property (nonatomic,weak) UITextField *yxqInput;
@property (nonatomic,weak) UITextField *PhoneInput;



@property (nonatomic,weak) UIButton *man;
@property (nonatomic,weak) UIButton *women;

@property (nonatomic,weak) UIImageView *desIcon;
@end

@implementation OtherCell
+ (instancetype)returnCellWith:(UITableView *)tableView
{
    OtherCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[OtherCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
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
        self.back = back;
        back.backgroundColor = ColorWithHex(0xFFFFFF, 1.0);
        LRViewRadius(back, cornerRadius_width);
        [self.contentView addSubview:back];
        
        UILabel *name = [[UILabel alloc]init];
        [self.contentView addSubview:name];
        
        UIButton *man = [[UIButton alloc]init];
        [self.contentView addSubview:man];
        
        UIButton *women = [[UIButton alloc]init];
        [self.contentView addSubview:women];
        
        UITextField *nameInput = [[UITextField alloc]init];
        [self.contentView addSubview:nameInput];
        
        UIView *lineOne = [[UIView alloc]init];
        self.lineOne = lineOne;
        lineOne.backgroundColor = ColorWithHex(0x979797, 0.4);
        [self.contentView addSubview:lineOne];
        
        UILabel *huzhao = [[UILabel alloc]init];
        self.huzhao  =huzhao;
        [self.contentView addSubview:huzhao];
        UIImageView *huzhaoIcon = [[UIImageView alloc]init];
        [self.contentView addSubview:huzhaoIcon];
        UIButton *huzhaoBtn = [[UIButton alloc]init];
        [self.contentView addSubview:huzhaoBtn];
        
        UITextField *huzhaoInput = [[UITextField alloc]init];
        [self.contentView addSubview:huzhaoInput];
        
        UIView *lineFour = [[UIView alloc]init];
        lineFour.backgroundColor = ColorWithHex(0x979797, 0.4);
        [self.contentView addSubview:lineFour];
        
        UILabel *guoji = [[UILabel alloc]init];
        [self.contentView addSubview:guoji];
        UIImageView *guojiIcon = [[UIImageView alloc]init];
        [self.contentView addSubview:guojiIcon];
        UIButton *guojiBtn = [[UIButton alloc]init];
        [self.contentView addSubview:guojiBtn];
        
        UITextField *guojiInput = [[UITextField alloc]init];
        [self.contentView addSubview:guojiInput];
        
        UIView *lineFive = [[UIView alloc]init];
        lineFive.backgroundColor = ColorWithHex(0x979797, 0.4);
        [self.contentView addSubview:lineFive];
        
        
        UILabel *csrq = [[UILabel alloc]init];
        [self.contentView addSubview:csrq];
        UIImageView *csrqIcon = [[UIImageView alloc]init];
        [self.contentView addSubview:csrqIcon];
        UIButton *csrqiBtn = [[UIButton alloc]init];
        [self.contentView addSubview:csrqiBtn];
        UITextField *csrqInput = [[UITextField alloc]init];
        [self.contentView addSubview:csrqInput];
        UIView *linesix = [[UIView alloc]init];
        linesix.backgroundColor = ColorWithHex(0x979797, 0.4);
        [self.contentView addSubview:linesix];
        
        UILabel *yxq = [[UILabel alloc]init];
        [self.contentView addSubview:yxq];
        UIImageView *yxqIcon = [[UIImageView alloc]init];
        [self.contentView addSubview:yxqIcon];
        UIButton *yxqBtn = [[UIButton alloc]init];
        [self.contentView addSubview:yxqBtn];
        UITextField *yxqInput = [[UITextField alloc]init];
        [self.contentView addSubview:yxqInput];
        UIView *lineseven = [[UIView alloc]init];
        lineseven.backgroundColor = ColorWithHex(0x979797, 0.4);
        [self.contentView addSubview:lineseven];
        
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
        
        [women mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(back).offset(-14);
            make.centerY.equalTo(name);
            make.width.equalTo(@30);
            make.height.equalTo(@20);
        }];
        
        [man mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(women.mas_left).offset(-10);
            make.centerY.equalTo(name);
            make.width.equalTo(@30);
            make.height.equalTo(@20);
            
        }];
        
        [nameInput mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(102);
            make.right.equalTo(man.mas_left).offset(-5);
            make.centerY.equalTo(name);
            make.height.equalTo(@(44));
        }];
        
        [lineOne mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(back).offset(0);
            make.right.equalTo(back).offset(0);
            make.top.equalTo(name.mas_bottom).offset(24);
            make.height.equalTo(@(0.5));
        }];

        [huzhao mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(30);
            make.top.equalTo(lineOne.mas_bottom).offset(24);
        }];
        [huzhaoIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(huzhao.mas_right).offset(18);
            make.centerY.equalTo(huzhao);
            make.width.equalTo(@(8));
            make.height.equalTo(@(4));
        }];
        [huzhaoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(huzhao);
            make.right.equalTo(huzhaoIcon);
            make.centerY.equalTo(huzhao);
            make.height.equalTo(@44);
        }];
        
        [huzhaoInput mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(102);
            make.right.equalTo(self.contentView).offset(-30);
            make.centerY.equalTo(huzhao);
            make.height.equalTo(@(44));
        }];
        
        [lineFour mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(back).offset(0);
            make.right.equalTo(back).offset(0);
            make.top.equalTo(huzhao.mas_bottom).offset(24);
            make.height.equalTo(@(0.5));
        }];
        [guoji mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(30);
            make.top.equalTo(lineFour.mas_bottom).offset(24);
        }];
        [guojiIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(guojiInput.mas_right).offset(13);
            make.centerY.equalTo(guojiInput);
            make.width.equalTo(@(4));
            make.height.equalTo(@(8));
        }];
        [guojiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(guojiInput);
            make.right.equalTo(guojiIcon);
            make.centerY.equalTo(guojiInput);
            make.height.equalTo(@44);
        }];
        [guojiInput mas_makeConstraints:^(MASConstraintMaker *make) {
            //            make.left.equalTo(self.contentView).offset(102);
            make.right.equalTo(back).offset(-32);
            make.centerY.equalTo(guoji);
            make.height.equalTo(@(44));
        }];
        
        [lineFive mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(back).offset(0);
            make.right.equalTo(back).offset(0);
            make.top.equalTo(guoji.mas_bottom).offset(24);
            make.height.equalTo(@(0.5));
        }];
        [csrq mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(30);
            make.top.equalTo(lineFive.mas_bottom).offset(24);
        }];
        [csrqIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(csrqInput.mas_right).offset(13);
            make.centerY.equalTo(csrqInput);
            make.width.equalTo(@(4));
            make.height.equalTo(@(8));
        }];
        [csrqiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(csrqInput);
            make.right.equalTo(csrqIcon);
            make.centerY.equalTo(csrqInput);
            make.height.equalTo(@44);
        }];
        [csrqInput mas_makeConstraints:^(MASConstraintMaker *make) {
            //            make.left.equalTo(self.contentView).offset(102);
            make.right.equalTo(back).offset(-32);
            make.top.equalTo(csrq);
        }];
        
        [linesix mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(back).offset(0);
            make.right.equalTo(back).offset(0);
            make.top.equalTo(csrq.mas_bottom).offset(24);
            make.height.equalTo(@(0.5));
        }];
        [yxq mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(30);
            make.top.equalTo(linesix.mas_bottom).offset(24);
        }];
        [yxqIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(yxqInput.mas_right).offset(13);
            make.centerY.equalTo(yxqInput);
            make.width.equalTo(@(4));
            make.height.equalTo(@(8));
        }];
        [yxqBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(yxqInput);
            make.right.equalTo(yxqIcon);
            make.centerY.equalTo(yxqInput);
            make.height.equalTo(@44);
        }];
        [yxqInput mas_makeConstraints:^(MASConstraintMaker *make) {
            //            make.left.equalTo(self.contentView).offset(102);
            make.right.equalTo(back).offset(-32);
            make.top.equalTo(yxq);
        }];
        
        [lineseven mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(back).offset(0);
            make.right.equalTo(back).offset(0);
            make.top.equalTo(yxq.mas_bottom).offset(24);
            make.height.equalTo(@(0.5));
        }];
        
        
        [Phone mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(30);
            make.top.equalTo(lineseven.mas_bottom).offset(24);
        }];
        
        [PhoneInput mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(102);
            make.right.equalTo(self.contentView).offset(-30);
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
        
        //        cardTypeIcon.image = ImageNamed(@"勾");
        desIcon.image = ImageNamed(@"勾");
        desIcon.highlightedImage = ImageNamed(@"矩形25");
        
        [nameInput addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [huzhaoInput addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [yxqInput addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [csrqInput addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [PhoneInput addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        
        

        
        name.font = PingFangSC_Regular(15);
        name.textColor = ColorWithHex(0x2B3B54, 1.0);
        nameInput.font = PingFangSC_Regular(14);
        nameInput.textColor = ColorWithHex(0x2B3B54, 1.0);
        
        huzhao.font = PingFangSC_Regular(15);
        huzhao.textColor = ColorWithHex(0x2B3B54, 1.0);
        huzhaoInput.font = PingFangSC_Regular(14);
        huzhaoInput.textColor = ColorWithHex(0x2B3B54, 1.0);
        
        guoji.font = PingFangSC_Regular(15);
        guoji.textColor = ColorWithHex(0x2B3B54, 1.0);
        guojiInput.font = PingFangSC_Regular(14);
        guojiInput.textColor = ColorWithHex(0x2B3B54, 1.0);
        
        yxq.font = PingFangSC_Regular(15);
        yxq.textColor = ColorWithHex(0x2B3B54, 1.0);
        yxqInput.font = PingFangSC_Regular(14);
        yxqInput.textColor = ColorWithHex(0x2B3B54, 1.0);
        
        csrq.font = PingFangSC_Regular(15);
        csrq.textColor = ColorWithHex(0x2B3B54, 1.0);
        csrqInput.font = PingFangSC_Regular(14);
        csrqInput.textColor = ColorWithHex(0x2B3B54, 1.0);
        
        
        Phone.font = PingFangSC_Regular(15);
        Phone.textColor = ColorWithHex(0x2B3B54, 1.0);
        PhoneInput.font = PingFangSC_Regular(14);
        PhoneInput.textColor = ColorWithHex(0x2B3B54, 1.0);
        
        des.font = PingFangSC_Regular(14);
        des.textColor = ColorWithHex(0xFFFFFF, 1.0);
        des.text = @"设为默认乘机人";
        
        name.text = @"姓名";
        huzhao.text = @"其他";
        guoji.text = @"国籍";
        csrq.text = @"出生日期";
        yxq.text = @"证件有效期";
        Phone.text = @"手机号";
        
        nameInput.placeholder = @"乘机人真实姓名";
        huzhaoInput.placeholder = @"所持证件号码";
        guojiInput.placeholder = @"请选择国籍";
        csrqInput.placeholder = @"与证件保持一致";
        yxqInput.placeholder = @"请选择证件有效期";
        PhoneInput.placeholder = @"用于接收航司短信";
        
        
        self.nameInput = nameInput;
        self.PhoneInput = PhoneInput;
        self.huzhaoInput = huzhaoInput;
        self.guojiInput = guojiInput;
        self.csrqInput = csrqInput;
        self.yxqInput = yxqInput;
        self.desIcon = desIcon;
        
        self.nameInput.delegate = self;
        self.huzhaoInput.delegate = self;
        self.guojiInput.delegate = self;
        self.csrqInput.delegate = self;
        self.yxqInput.delegate = self;
        self.PhoneInput.delegate = self;
        self.guojiInput.enabled = NO;
        self.csrqInput.enabled = NO;
        self.yxqInput.enabled = NO;
        
        self.nameInput.tag = name_TextField_TYPE_ENMU;
        self.huzhaoInput.tag = huzhao_TextField_TYPE_ENMU;
        self.csrqInput.tag = csrq_TextField_TYPE_ENMU;
        self.yxqInput.tag = yxq_TextField_TYPE_ENMU;
        self.PhoneInput.tag = phone_TextField_TYPE_ENMU;
        self.csrqInput.textAlignment = NSTextAlignmentRight;
        self.yxqInput.textAlignment = NSTextAlignmentRight;
        self.guojiInput.textAlignment = NSTextAlignmentRight;
        self.huzhaoInput.keyboardType = UIKeyboardTypeASCIICapable;

        
        
        [self.nameInput setValue:placeholderLabeltextColor forKeyPath:@"_placeholderLabel.textColor"];
        [self.huzhaoInput setValue:placeholderLabeltextColor forKeyPath:@"_placeholderLabel.textColor"];
        [self.guojiInput setValue:placeholderLabeltextColor forKeyPath:@"_placeholderLabel.textColor"];
        [self.csrqInput setValue:placeholderLabeltextColor forKeyPath:@"_placeholderLabel.textColor"];
        [self.yxqInput setValue:placeholderLabeltextColor forKeyPath:@"_placeholderLabel.textColor"];
        [self.PhoneInput setValue:placeholderLabeltextColor forKeyPath:@"_placeholderLabel.textColor"];
        //        guojiInput.textAlignment = NSTextAlignmentRight;
        //        csrqInput.textAlignment = NSTextAlignmentRight;
        //        yxqInput.textAlignment = NSTextAlignmentRight;
        [women setBackgroundImage:[UIImage imageWithColor:ColorWithHex(0x3AC0EC, 1.0)] forState:UIControlStateSelected];
        [man setBackgroundImage:[UIImage imageWithColor:ColorWithHex(0x3AC0EC, 1.0)] forState:UIControlStateSelected];
        [women setTitle:@"女" forState:UIControlStateNormal];
        [man setTitle:@"男" forState:UIControlStateNormal];
        [women setTitleColor:ColorWithHex(0x2B3B54, 1.0) forState:UIControlStateNormal];
        [women setTitleColor:ColorWithHex(0xFFFFFF, 1.0) forState:UIControlStateSelected];
        [man setTitleColor:ColorWithHex(0x2B3B54, 1.0) forState:UIControlStateNormal];
        [man setTitleColor:ColorWithHex(0xFFFFFF, 1.0) forState:UIControlStateSelected];
        women.titleLabel.font = PingFangSC_Regular(14);
        man.titleLabel.font = PingFangSC_Regular(14);
//        women.selected = YES;
        LRViewRadius(women, cornerRadius_width);
        LRViewRadius(man, cornerRadius_width);
        man.restorationIdentifier = @"man";
        women.restorationIdentifier = @"women";
        [women addTarget:self action:@selector(sexSlecet:) forControlEvents:UIControlEventTouchUpInside];
        [man addTarget:self action:@selector(sexSlecet:) forControlEvents:UIControlEventTouchUpInside];
        [huzhaoBtn addTarget:self action:@selector(xuanZheClick:) forControlEvents:UIControlEventTouchUpInside];
        [desIconBtn addTarget:self action:@selector(xuanZheClick:) forControlEvents:UIControlEventTouchUpInside];
        desIconBtn.tag = 1;
        //        [cardTypeBtn addTarget:self action:@selector(xuanZheClick:) forControlEvents:UIControlEventTouchUpInside];
//        [desIconBtn addTarget:self action:@selector(xuanZheClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [guojiBtn addTarget:self action:@selector(guojiBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [csrqiBtn addTarget:self action:@selector(csrqiBtnBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [yxqBtn addTarget:self action:@selector(yxqBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        self.man = man;
        self.women = women;
        self.PhoneInput.keyboardType = UIKeyboardTypePhonePad;
        //test
        huzhaoIcon.image = ImageNamed(@"Group 4");
        guojiIcon.image = ImageNamed(@"Group");
        csrqIcon.image = ImageNamed(@"Group");
        yxqIcon.image = ImageNamed(@"Group");
        //
    }
    return self;
}

#pragma --<选择 国籍>
- (void)guojiBtnClick:(UIButton *)btn{
    NSLog(@"%s",__func__);
    if (self.xuanzguoji) {
        self.xuanzguoji();
    }
}
#pragma --<选择 出生日期>
- (void)csrqiBtnBtnClick:(UIButton *)btn{
    NSLog(@"%s",__func__);
    kWeakSelf(self);
    [self guanbitefiIN];
    datePiker *datese = [[datePiker alloc]init];
    datese.maxDate = [NSDate date];
    datese.minDate = [NSDate dateWithYear:1900 month:1 day:1];
    datese.nextClick = ^(NSString *startDate){
        weakself.csrqInput.text = startDate;
        if (weakself.FillIn) {
            weakself.FillIn(startDate,csrq_TextField_TYPE_ENMU);
        }
    };
    [datese windosViewshow];
}
#pragma --<选择 有效期>
- (void)yxqBtnClick:(UIButton *)btn{
    NSLog(@"%s",__func__);
    kWeakSelf(self);
    [self guanbitefiIN];
    datePiker *datese = [[datePiker alloc]init];
        datese.maxDate = [NSDate dateWithYear:2100 month:1 day:1];
        datese.minDate = [NSDate date];
        datese.nextClick = ^(NSString *startDate){
            if (weakself.FillIn) {
                weakself.FillIn(startDate,yxq_TextField_TYPE_ENMU);
            }
            weakself.yxqInput.text = startDate;
        };
    [datese windosViewshow];
}

- (void)guanbitefiIN{
    if ([self.nameInput isFirstResponder]) {
        [self.nameInput resignFirstResponder];
    } else if ([self.huzhaoInput isFirstResponder]) {
        [self.huzhaoInput resignFirstResponder];
    } else if ([self.PhoneInput isFirstResponder]) {
        [self.PhoneInput resignFirstResponder];
    }
}

#pragma --<选择性别>
- (void)sexSlecet:(UIButton *)btn{
    if ([btn.restorationIdentifier isEqualToString:@"man"]) {
        self.man.selected = YES;
        self.women.selected = NO;
        if (self.FillIn) {
            self.FillIn(@"M",sex_TextField_TYPE_ENMU);
        }
    } else if ([btn.restorationIdentifier isEqualToString:@"women"]) {
        self.man.selected = NO;
        self.women.selected = YES;
        if (self.FillIn) {
            self.FillIn(@"F",sex_TextField_TYPE_ENMU);
        }
    }
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
    if (textField.tag == name_TextField_TYPE_ENMU) {
        //        if (length > 15) {
        //            [textField resignFirstResponder];
        //            [MBProgressHUD showPrompt:@"不超过15个字"];
        //            return NO;
        //        }
    } else if (textField.tag == phone_TextField_TYPE_ENMU) {
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
    self.huzhaoInput.text = idNumber;
}
- (void)setPhone:(NSString *)phone{
    _phone = phone;
    self.PhoneInput.text = phone;
}
- (void)setIsDefualStr:(BOOL)isDefualStr{
    _isDefualStr = isDefualStr;
    self.desIcon.highlighted = isDefualStr;
}
- (void)setGuoji:(NSDictionary *)guoji{
    _guoji = guoji;
    self.guojiInput.text = guoji[@"countryName"];
}
- (void)setChusriqi:(NSString *)chusriqi{
    _chusriqi = chusriqi;
    self.csrqInput.text = chusriqi;
}
- (void)setYouxiaoqi:(NSString *)youxiaoqi{
    _youxiaoqi = youxiaoqi;
    self.yxqInput.text = youxiaoqi;
}
- (void)setSex:(NSString *)sex{
    if ([sex isEqualToString:@"M"]) {
        self.man.selected = YES;
        self.women.selected = NO;
    } else if ([sex isEqualToString:@"F"]) {
        self.man.selected = NO;
        self.women.selected = YES;
    }
}
@end
