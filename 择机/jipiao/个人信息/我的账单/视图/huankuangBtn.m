//
//  huankuangBtn.m
//  jipiao
//
//  Created by Store on 16/9/5.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "huankuangBtn.h"
#import "HeaderTotal.h"

#define testLabel1 @"当前需归还本息： "

@interface huankuangBtn ()<UITextFieldDelegate,UITextViewDelegate>

@property (nonatomic,weak) UILabel *label1;
@property (nonatomic,weak) UITextField *phone;
@property (nonatomic,assign) NSInteger payType;
@property (nonatomic,weak) UIImageView *image1;
@property (nonatomic,weak) UIImageView *image2;
@end

@implementation huankuangBtn
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        UIImageView *backImage = [[UIImageView alloc]init];
        [self addSubview:backImage];
        self.backgroundColor = RGBACOLOR(51, 206, 236, 1);
        backImage.image = [UIImage imageNamed:@"img_popup01"];
        
        UIButton *btnClose = [[UIButton alloc]init];
        [btnClose addTarget:self action:@selector(btnCloseClick:) forControlEvents:UIControlEventTouchUpInside];
        [btnClose setImage:[UIImage imageNamed:@"close_02"] forState:UIControlStateNormal];
        [self addSubview:btnClose];
        
        UILabel *label = [[UILabel alloc]init];
        label.text = @"还款金额（元）";
        label.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
        label.textColor = [UIColor whiteColor];
        [self addSubview:label];
        
        UITextField *phone = [[UITextField alloc]init];
        self.phone = phone;
        phone.textAlignment = NSTextAlignmentCenter;
        phone.clearButtonMode =  UITextFieldViewModeWhileEditing;
        phone.keyboardType = UIKeyboardTypeDecimalPad;
        phone.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self addSubview:phone];
        
        UIView *view1 = [[UIView alloc]init];
        [self addSubview:view1];
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = RGBColor(255, 255, 255);
        [self addSubview:line];

        UILabel *label1 = [[UILabel alloc]init];
        self.label1 = label1;
        [self addSubview:label1];
        
        UILabel *label2 = [[UILabel alloc]init];
        [self addSubview:label2];
        
        UIImageView *image1 = [[UIImageView alloc]init];
        [self addSubview:image1];
        UIImageView *image11 = [[UIImageView alloc]init];
        [self addSubview:image11];
        UIImageView *image2 = [[UIImageView alloc]init];
        [self addSubview:image2];
        
        UIButton *btnOK = [[UIButton alloc]init];
        [self addSubview:btnOK];
        
        [backImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(0);
            make.top.equalTo(self).offset(0);
            make.left.equalTo(self).offset(0);
            make.bottom.equalTo(self).offset(0);
        }];
        [btnClose setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
        [btnClose mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-4*WIDTHICON);
            make.top.equalTo(self).offset(4*HEIGHTICON);
            make.width.equalTo(@(39*WIDTHICON));
            make.height.equalTo(@(39*WIDTHICON));
        }];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(15*HEIGHTICON);
            make.centerX.equalTo(self);
            make.height.equalTo(@(20*HEIGHTICON));
        }];
        [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(label.mas_bottom).offset(10);
            make.height.equalTo(@1);
            make.left.equalTo(self);
            make.right.equalTo(self);
        }];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(60*WIDTHICON);
            make.right.equalTo(self).offset(-60*WIDTHICON);
            make.top.equalTo(self).offset(90*HEIGHTICON);
            make.height.equalTo(@1);
        }];
        
        [phone mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(line);
            make.right.equalTo(line);
            make.bottom.equalTo(line).offset(0);
            make.top.equalTo(view1);
        }];
        
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(line);
            make.right.equalTo(line);
            make.top.equalTo(line.mas_bottom).offset(5*WIDTHICON);
            make.height.equalTo(@(14*HEIGHTICON));
        }];
        [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(line).offset(-5*WIDTHICON);
            make.top.equalTo(label1.mas_bottom).offset(25*HEIGHTICON);
            make.height.equalTo(@(12*HEIGHTICON));
        }];
        [image11 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(image1).offset(0);
            make.centerY.equalTo(image1.mas_top).offset(0);
            make.width.equalTo(@(33));
            make.height.equalTo(@(8));
        }];
        [image1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(label2).offset(0);
            make.top.equalTo(label2.mas_bottom).offset(10*HEIGHTICON);
            make.width.equalTo(@(76*WIDTHICON));
            make.height.equalTo(@(26*HEIGHTICON));
        }];
        [image2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(image1.mas_right).offset(10*WIDTHICON);
            make.top.equalTo(label2.mas_bottom).offset(10*WIDTHICON);
            make.width.equalTo(@(76*WIDTHICON));
            make.height.equalTo(@(26*HEIGHTICON));
        }];
        [btnOK mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(18*WIDTHICON);
            make.right.equalTo(self).offset(-18*WIDTHICON);
            make.top.equalTo(image1.mas_bottom).offset(20*HEIGHTICON);
            make.bottom.equalTo(self).offset(-5*HEIGHTICON);
        }];
        self.image1 = image1;
        self.image2 = image2;
        view1.backgroundColor = RGBColor(57, 128, 157);
        phone.placeholder = @"请输入还款金额";
        [phone setValue:[UIFont boldSystemFontOfSize:10] forKeyPath:@"_placeholderLabel.font"];
        
        phone.font = [UIFont fontWithName:@"Helvetica" size:24];
        label1.font = [UIFont fontWithName:@"Helvetica" size:14];
        label2.font = [UIFont fontWithName:@"Helvetica" size:14];
        phone.textColor = RGBACOLOR(235, 63, 66, 1);
        label1.textColor = RGBACOLOR(255, 255, 255, 1);
        label2.textColor = RGBACOLOR(255, 255, 255, 1);
        label1.textAlignment = NSTextAlignmentCenter;
        
        label2.text = @"还款方式：";
        
        image11.image = [UIImage imageNamed:@"icon_payment_02"];
        image2.image = [UIImage imageNamed:@"icon_payment_weixin"];
        image2.highlightedImage = [UIImage imageNamed:@"icon_payment_weixin_01"];
        
        image1.image = [UIImage imageNamed:@"icon_payment_tqianbao"];
        image1.highlightedImage = [UIImage imageNamed:@"icon_payment_tqianbao_01"];
        btnOK.backgroundColor = RGBACOLOR(235, 63, 66, 1);
        [btnOK setTitle:@"立即还款" forState:UIControlStateNormal];
        [btnOK addTarget:self action:@selector(btnOkClick) forControlEvents:UIControlEventTouchUpInside];
        image2.highlighted = YES;
        image1.tag = 0;    //T钱包支付
        image2.tag = 1; //微信支付
        self.payType = image2.tag;
        image1.userInteractionEnabled = YES;
        image2.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageselector:)];
        [image1 addGestureRecognizer:tap1];
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageselector:)];
        [image2 addGestureRecognizer:tap2];
        //test
        label1.text = [testLabel1 stringByAppendingString:@"2000 元"];
    }
    return self;
}
- (void)btnCloseClick:(UIButton *)btn{
    if ([self.delagate respondsToSelector:@selector(logoAndRegistWillClose)]) {
        [self.delagate logoAndRegistWillClose];
    }
}
- (void)btnOkClick{
    if (![NSString checkOKAmt:self.phone.text]) {
        [MBProgressHUD showError:@"请输入正确的金额"];
    } else if ([self.totalNum floatValue]<[self.phone.text floatValue]){
        [MBProgressHUD showError:[NSString stringWithFormat:@"请输入不大于%@的金额",self.totalNum]];
    }else if ([self.phone.text floatValue]<=0){
        [MBProgressHUD showError:@"请输入大于0的金额"];
    }else if ([self.phone.text rangeOfString:@" "].location != NSNotFound){
        [MBProgressHUD showError:@"请不要包含空格"];
    }else if (![self.phone.text hasPrefix:@"0."] && [self.phone.text hasPrefix:@"0"]){
        [MBProgressHUD showError:@"请输入正确的金额"];
    }else{
        if ([self.delagate respondsToSelector:@selector(huankuangWithTorWeichat:tranAmt:)]) {
            NSLog(@"self.payType=%ld",(long)self.payType);
            [self.delagate huankuangWithTorWeichat:self.payType tranAmt:self.phone.text];
        }
    }
}
- (void)becomeFirst{
    [self.phone becomeFirstResponder];
}
- (void)registFirst{
    if ([self.phone isFirstResponder]) {
        [self.phone resignFirstResponder];
    }
}
- (void)setTotalNum:(NSString *)totalNum{
    _totalNum = totalNum;
    self.label1.text =  [testLabel1 stringByAppendingFormat:@"%@ 元",totalNum];
}
- (void)imageselector:(UITapGestureRecognizer *)sendr{
    if (sendr.view.tag == 1) {  //微信
        self.image1.highlighted = NO;
        self.image2.highlighted = YES;
    } else {
        self.image1.highlighted = YES;
        self.image2.highlighted = NO;
    }
    self.payType = sendr.view.tag;
}
@end
