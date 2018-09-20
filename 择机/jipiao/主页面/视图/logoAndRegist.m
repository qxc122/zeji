//
//  logoAndRegist.m
//  jipiao
//
//  Created by Store on 16/8/8.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "logoAndRegist.h"
#import "HeaderTotal.h"
#import "Ticket.h"
#import "UITextField+YX.h"


@interface logoAndRegist ()<UITextFieldDelegate,UITextViewDelegate,YXTextFieldDelegate>
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic,weak) UILabel *label;
@property (nonatomic,weak) UITextField *phone;
@property (nonatomic,weak) UIButton *next;
@property (nonatomic,weak) UIButton *wx;
@property (nonatomic,weak) UILabel *other;
@property (nonatomic,weak) UIButton *btnPre;
@property (nonatomic,weak) UILabel *timess;

@property (nonatomic,weak) UITextField *one;
@property (nonatomic,weak) UITextField *two;
@property (nonatomic,weak) UITextField *three;
@property (nonatomic,weak) UITextField *four;
@end

@implementation logoAndRegist
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *backImage = [[UIImageView alloc]init];
        [self addSubview:backImage];
//        backImage.backgroundColor = RGBACOLOR(51, 206, 236, 1);
        backImage.image = [UIImage imageNamed:@"img_popup01"];
       
        UIButton *btnClose = [[UIButton alloc]init];
        [btnClose addTarget:self action:@selector(btnCloseClick:) forControlEvents:UIControlEventTouchUpInside];
        [btnClose setImage:[UIImage imageNamed:@"close_02"] forState:UIControlStateNormal];
        [self addSubview:btnClose];
        
        UILabel *label = [[UILabel alloc]init];
        self.label = label;
        label.text = @"登录";
        label.font = [UIFont fontWithName:@"MicrosoftYaHei" size:20];
        label.textColor = [UIColor whiteColor];
        [self addSubview:label];
        
        UIView *view1 = [[UIView alloc]init];
        [self addSubview:view1];
        
        UITextField *phone = [[UITextField alloc]init];
        self.phone = phone;
        phone.clearButtonMode =  UITextFieldViewModeWhileEditing;
        phone.keyboardType = UIKeyboardTypeNumberPad;
        phone.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self addSubview:phone];
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = RGBColor(255, 255, 255);
        [self addSubview:line];
        
        UIButton *next = [[UIButton alloc]init];
        self.next = next;
        [next setTitle:@"下一步" forState:UIControlStateNormal];
        [next addTarget:self action:@selector(nextClick:) forControlEvents:UIControlEventTouchUpInside];
        next.backgroundColor = RGBColor(235, 63, 66);
        [self addSubview:next];
        
        UIButton *wx = [[UIButton alloc]init];
        self.wx = wx;
        [wx addTarget:self action:@selector(wxClick:) forControlEvents:UIControlEventTouchUpInside];
        [wx setImage:[UIImage imageNamed:@"third party_01"] forState:UIControlStateNormal];
        [self addSubview:wx];
        
        UILabel *other = [[UILabel alloc]init];
        self.other = other;
        other.text = @"其它登录方式";
        other.textAlignment = NSTextAlignmentCenter;
        other.font = [UIFont fontWithName:@"MicrosoftYaHei" size:11];
        other.textColor = [UIColor whiteColor];
        [self addSubview:other];
        
        UIButton *btnPre = [[UIButton alloc]init];
        self.btnPre = btnPre;
        [btnPre addTarget:self action:@selector(btnPreClick:) forControlEvents:UIControlEventTouchUpInside];
        [btnPre setImage:[UIImage imageNamed:@"btnpre"] forState:UIControlStateNormal];
        [self addSubview:btnPre];
        
        UILabel *timess = [[UILabel alloc]init];
        timess.font = [UIFont fontWithName:@"MicrosoftYaHei" size:14];
        timess.backgroundColor = RGBColor(235, 78, 82);
        timess.textColor = [UIColor whiteColor];
        self.timess = timess;
        [self addSubview:timess];
        
        UITextField *one = [[UITextField alloc]init];
        self.one = one;
        [self addSubview:one];
        
        UITextField *two = [[UITextField alloc]init];
        self.two = two;
        [self addSubview:two];
        
        UITextField *three = [[UITextField alloc]init];
        self.three = three;
        [self addSubview:three];
        
        UITextField *four = [[UITextField alloc]init];
        self.four = four;
        [self addSubview:four];
        
        self.phone.tag = 1;
        self.one.tag = 2;
        self.two.tag = 3;
        self.three.tag = 4;
        self.four.tag = 5;
        self.one.font = [UIFont systemFontOfSize:30];
        self.two.font = [UIFont systemFontOfSize:30];
        self.three.font = [UIFont systemFontOfSize:30];
        self.four.font = [UIFont systemFontOfSize:30];
        self.one.clearsOnBeginEditing = YES;
        self.two.clearsOnBeginEditing = YES;
        self.three.clearsOnBeginEditing = YES;
        self.four.clearsOnBeginEditing = YES;
        self.phone.placeholder = @"请输入手机号";
        self.phone.textColor = [UIColor whiteColor];
        [self.phone addTarget:self  action:@selector(valueChanged:)  forControlEvents:UIControlEventAllEditingEvents];
        [self.one addTarget:self  action:@selector(valueChanged:)  forControlEvents:UIControlEventAllEditingEvents];
        [self.two addTarget:self  action:@selector(valueChanged:)  forControlEvents:UIControlEventAllEditingEvents];
        [self.three addTarget:self  action:@selector(valueChanged:)  forControlEvents:UIControlEventAllEditingEvents];
        [self.four addTarget:self  action:@selector(valueChanged:)  forControlEvents:UIControlEventAllEditingEvents];

        phone.textAlignment = NSTextAlignmentCenter;
        one.textAlignment = NSTextAlignmentCenter;
        two.textAlignment = NSTextAlignmentCenter;
        three.textAlignment = NSTextAlignmentCenter;
        four.textAlignment = NSTextAlignmentCenter;
        
        one.keyboardType = UIKeyboardTypeNumberPad;
        two.keyboardType = UIKeyboardTypeNumberPad;
        three.keyboardType = UIKeyboardTypeNumberPad;
        four.keyboardType = UIKeyboardTypeNumberPad;
        one.backgroundColor = [UIColor whiteColor];
        two.backgroundColor = [UIColor whiteColor];
        three.backgroundColor = [UIColor whiteColor];
        four.backgroundColor = [UIColor whiteColor];
        
        self.timess.userInteractionEnabled = YES;
        UITapGestureRecognizer *reg = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(timessClick)];
        [self.timess addGestureRecognizer:reg];
        [backImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.top.equalTo(self);
            make.bottom.equalTo(self);
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
        view1.backgroundColor = RGBColor(57, 128, 157);
        
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(60*WIDTHICON);
            make.right.equalTo(self).offset(-60*WIDTHICON);
            make.top.equalTo(self).offset(90*HEIGHTICON);
            make.height.equalTo(@1);
        }];

        [phone mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(line);
            make.right.equalTo(line);
            make.top.equalTo(view1.mas_bottom);
            make.bottom.equalTo(line.mas_top);
        }];

        [next mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(18*WIDTHICON);
            make.right.equalTo(self).offset(-18*WIDTHICON);
            make.height.equalTo(@(42*HEIGHTICON));
            make.top.equalTo(line.mas_bottom).offset(15*HEIGHTICON);
        }];
        [wx mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(43*WIDTHICON));
            make.height.equalTo(@(43*WIDTHICON));
            make.top.equalTo(next.mas_bottom).offset(15*HEIGHTICON);
            make.centerX.equalTo(self);
        }];
        [other mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.top.equalTo(wx.mas_bottom);
            make.bottom.equalTo(self);
        }];
        
        [btnPre setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
        [btnPre mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(2*WIDTHICON);
            make.centerY.equalTo(btnClose).offset(0);
            make.width.equalTo(@(10*WIDTHICON+20));
            make.height.equalTo(@(17*HEIGHTICON+20));
        }];
        btnPre.hidden = YES;
        
        [timess mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-10*WIDTHICON);
            make.top.equalTo(phone).offset(5);
            make.bottom.equalTo(phone).offset(-5);
            make.width.equalTo(@95);
        }];
        timess.hidden = YES;
        timess.textAlignment = NSTextAlignmentCenter;
        [one mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(line.mas_bottom).offset(17*HEIGHTICON);
            make.left.equalTo(self).offset(20*WIDTHICON);
            make.right.equalTo(two.mas_left).offset(-11*WIDTHICON);
            make.height.equalTo(one.mas_width);
            make.width.equalTo(@[two,three,four]);
            make.height.equalTo(@[two,three,four]);
        }];
        one.hidden = YES;
        
        [two mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(one);
            make.right.equalTo(three.mas_left).offset(-11*WIDTHICON);
        }];
        two.hidden = YES;
        
        [three mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(one);
            make.right.equalTo(four.mas_left).offset(-11*WIDTHICON);
        }];
        three.hidden = YES;
        
        [four mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(one);
            make.right.equalTo(self).offset(-20*WIDTHICON);
        }];
        four.hidden = YES;
        
        if ([WXApi isWXAppInstalled]){
            self.wx.hidden = NO;
            self.other.text = @"其它登录方式";
        }else{
            self.wx.hidden = YES;
            self.other.text = @"";
        }
        phone.delegate = self;
        one.delegate = self;
        two.delegate = self;
        three.delegate = self;
        four.delegate = self;
    }
    return self;
}
- (void)closeView{  //登录
    self.phone.enabled = YES;
    [self.phone becomeFirstResponder];
    self.phone.text = @"";
    
    self.label.text = @"登录";
    self.one.hidden = YES;
    self.two.hidden = YES;
    self.three.hidden = YES;
    self.four.hidden = YES;
    
    self.timess.hidden = YES;
    self.btnPre.hidden = YES;

    self.next.hidden = NO;
    
    if ([WXApi isWXAppInstalled]){
        self.wx.hidden = NO;
        self.other.text = @"其它登录方式";
    }else{
        self.wx.hidden = YES;
        self.other.text = @"";
    }
    
}
- (void)openView{  //注册
    [self sendPhoneCode];
    self.label.text = @"请输入验证码";
    self.one.hidden = NO;
    self.two.hidden = NO;
    self.three.hidden = NO;
    self.four.hidden = NO;
    
    self.timess.hidden = NO;
    self.btnPre.hidden = NO;
    
    self.next.hidden = YES;
    self.wx.hidden = YES;
    self.other.text = @"";
    self.timess.text = @"发送验证码";
    self.phone.enabled = NO;

    [self resetonetofour];

}
- (void)wxClick:(UIButton *)btn{
    if (![WXApi isWXAppInstalled]) {
        [MBProgressHUD showError:@"您没有安装微信"];
        return;
    }
    if ([self.delagate respondsToSelector:@selector(clickWeixinLogin)]) {
        [self.delagate clickWeixinLogin];
    }
}

- (void)nextClick:(UIButton *)btn{
    if (![NSString checkTelNumber:self.phone.text]) {//不是手机号码
        [MBProgressHUD showError:@"请输入正确的手机号码"];
        return;
    }
    [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = (239-90-17)*HEIGHTICON - (screenWidth-(12+40+33)*WIDTHICON)/4 + IQdefaultHeight;
    [self openView];
}
- (void)btnPreClick:(UIButton *)btn{
    [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = (239-90+9)*HEIGHTICON + IQdefaultHeight;
    [self closeView];
}
- (void)btnCloseClick:(UIButton *)btn{
    if ([self.delagate respondsToSelector:@selector(logoAndRegistWillClose)]) {
        [self.delagate logoAndRegistWillClose];
    }
}

- (void)becomeFirst{

    [self closeView];
}
- (void)registFirst{
    [self.timer invalidate];
    if ([self.phone isFirstResponder]) {
        [self.phone resignFirstResponder];
    }
    if ([self.one isFirstResponder]) {
        [self.one resignFirstResponder];
    }
    if ([self.two isFirstResponder]) {
        [self.two resignFirstResponder];
    }
    if ([self.three isFirstResponder]) {
        [self.three resignFirstResponder];
    }
    if ([self.four isFirstResponder]) {
        [self.four resignFirstResponder];
    }
}

- (void)gotoLOgin{
    __weak typeof(self) weakSelf = self;
    NSString *str = [NSString stringWithFormat:@"%@%@%@%@",self.one.text,self.two.text,self.three.text,self.four.text];
    self.one.text = @"";
    self.two.text = @"";
    self.three.text = @"";
    self.four.text = @"";

    [MBProgressHUD showHUDAddedTo:self animated:YES];
    [[TWClient sharedInstance]loginWithmobile:self.phone.text verifyCode:str success:^(id dataDict, NSString *msg, NSInteger code) {
        [[Ticket sharedInstance]updateuserinfo:[MTLJSONAdapter modelOfClass:[userInfo class] fromJSONDictionary:dataDict error:nil] success:^(id dataDict, NSString *msg, NSInteger code) {
            if ([weakSelf.delagate respondsToSelector:@selector(logoAndRegistWillClose)]) {
                [weakSelf.delagate logoAndRegistWillClose];
            }
            [[Ticket sharedInstance]updateLogininfo:ZEJIIN];
            [MBProgressHUD hideHUDForView:weakSelf animated:YES];
            [MBProgressHUD showSuccess:@"登录成功"];
            self.other.text = @"登录成功";
        } failure:^(NSInteger errorCode, NSString *msg) {
            [MBProgressHUD hideHUDForView:weakSelf animated:YES];
            [MBProgressHUD showError:msg];
        }];
    } failure:^(NSInteger errorCode, NSString *msg) {
        [MBProgressHUD hideHUDForView:weakSelf animated:YES];
        [MBProgressHUD showError:msg];
        [self resetonetofour];
        self.other.text = @"验证码错误,请重新输入";
    }];
}
- (void)resetonetofour{
    self.one.text = @"";
    self.two.text = @"";
    self.three.text = @"";
    self.four.text = @"";
    [self.one becomeFirstResponder];
}
- (void)valueChanged:(UITextField *)sender {
    if (sender.tag == 1) {
//        if ([NSString checkTelNumber:self.phone.text]) {//不是手机号码
//            [self openView];
//        }
    } else {
        if (sender.text.length > 1) {
            sender.text = [sender.text substringFromIndex:sender.text.length-1];
        }
        if (sender.tag == 2 && sender.text.length>=1) {
            if (!self.two.text || self.two.text.length<1) {
                [self.two becomeFirstResponder];
            } else if (!self.three.text || self.three.text.length<1){
                [self.three becomeFirstResponder];
            } else if (!self.four.text || self.four.text.length<1){
                [self.four becomeFirstResponder];
            }
        } else if (sender.tag == 3 && sender.text.length>=1){
//            [self.three becomeFirstResponder];
            if (!self.three.text || self.three.text.length<1){
                [self.three becomeFirstResponder];
            } else if (!self.four.text || self.four.text.length<1){
                [self.four becomeFirstResponder];
            }
        } else if (sender.tag == 4 && sender.text.length>=1){
//            [self.four becomeFirstResponder];
            if (!self.four.text || self.four.text.length<1){
                [self.four becomeFirstResponder];
            }
        } else if (sender.tag == 5 && sender.text.length>=1){
            
        }
        if (self.one.text.length>=1 && self.two.text.length>=1&& self.three.text.length>=1&& self.four.text.length>=1) {
            [self gotoLOgin];
        }
    }
}
- (void)timessClick{
    //发送验证码
    if (![self.timess.text hasSuffix:@"s"]) {
        [self sendPhoneCode];
    }
}
- (void)sendPhoneCode{
    //type默认写 @"01" 表示登录验证码
    self.timess.enabled = NO;
    __weak typeof(self) weakSelf = self;
    [MBProgressHUD showHUDAddedTo:self animated:YES];
    [[TWClient sharedInstance]sendVerifyCodeWithmobile:self.phone.text type:@"01" success:^(id dataDict, NSString *msg, NSInteger code) {
        [MBProgressHUD hideHUDForView:weakSelf animated:YES];
        [MBProgressHUD showSuccess:@"验证码发送成功"];
        weakSelf.other.text = @"请输入验证码";
        self.timess.text = @"60s";
        self.timess.enabled = YES;
        [self startTimer];
        [self.one becomeFirstResponder];
    } failure:^(NSInteger errorCode, NSString *msg) {
        
        [MBProgressHUD hideHUDForView:weakSelf animated:YES];
        [MBProgressHUD showError:msg];
    }];
}
- (void)startTimer {
    //如果定时器已开启，先停止再重新开启
    if (self.timer) [self stopTimer];
    self.timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(nextPageloadAndOUT) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
- (void)stopTimer {
    [self.timer invalidate];
    self.timer = nil;
}
- (void)nextPageloadAndOUT {
    NSUInteger tmp = [[self.timess.text substringToIndex:2] integerValue];
    tmp--;
    if (tmp==-1) {
        self.timess.text = @"发送验证码";
        [self stopTimer];
        return;
    }
    self.timess.text = [NSString stringWithFormat:@"%lus",(unsigned long)tmp];
}
-(void)dealloc{
    [self stopTimer];
}
- (void)textFieldDidDeleteBackward:(UITextField *)textField{
    if (textField == self.one) {
        self.one.text = @"";
    } else if (textField == self.two){
        [self.one becomeFirstResponder];
        self.one.text = @"";
    } else if (textField == self.three){
        [self.two becomeFirstResponder];
        self.two.text = @"";
    } else if (textField == self.four){
        [self.three becomeFirstResponder];
        self.three.text = @"";
    }
}
@end
