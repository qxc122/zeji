//
//  youhuimaCell.m
//  jipiao
//
//  Created by Store on 16/9/27.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "youhuimaCell.h"
#import "Masonry.h"
#import "HeaderTotal.h"
#import "zejiMain.h"
@interface youhuimaCell ()<UITextFieldDelegate,UIAlertViewDelegate>
@property (nonatomic,weak) UITextField *textField;
@property (nonatomic,weak) UIImageView *image;
@property (nonatomic,weak) UIButton *btn;

@property (nonatomic,weak) UIImageView *oneImage;
@property (nonatomic,weak) UILabel *oneLabel;
@property (nonatomic,weak) UILabel *oneLabelLeft;
@property (nonatomic,weak) UILabel *oneLabelRight;

@end


@implementation youhuimaCell
#define youhuimaCellIdentifier @"youhuimaCellIdentifier"
+ (instancetype)returnCellWith:(UITableView *)tableView
{
    youhuimaCell *cell = [tableView dequeueReusableCellWithIdentifier:youhuimaCellIdentifier];
    if (cell == nil) {
        cell = [[youhuimaCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:youhuimaCellIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = RGBACOLOR(25, 36, 52, 1);
        UIImageView *imageBackAll = [[UIImageView alloc]init];
        [self addSubview:imageBackAll];
        imageBackAll.userInteractionEnabled = YES;
        
        UIImageView *image = [[UIImageView alloc]init];
        self.image = image;
        [self addSubview:image];
        UITextField *textField = [[UITextField alloc]init];
        self.textField  =textField;
        [self addSubview:textField];
        UIButton *btn = [[UIButton alloc]init];
        self.btn = btn;
        [self addSubview:btn];
        
        UIImageView *oneImage = [[UIImageView alloc]init];
        self.oneImage = oneImage;
        [self addSubview:oneImage];
        UILabel *oneLabel = [[UILabel alloc]init];
        self.oneLabel = oneLabel;
        [self addSubview:oneLabel];
        UILabel *oneLabelLeft = [[UILabel alloc]init];
        self.oneLabelLeft = oneLabelLeft;
        [self addSubview:oneLabelLeft];
        UILabel *oneLabelRight = [[UILabel alloc]init];
        self.oneLabelRight = oneLabelRight;
        [self addSubview:oneLabelRight];
        
        oneLabel.textColor = RGBACOLOR(169, 171, 171, 1);
        oneLabel.font = [UIFont systemFontOfSize:12];
        oneLabelRight.textColor = RGBACOLOR(249, 53, 67, 1);
        oneLabelLeft.textColor = RGBACOLOR(249, 53, 67, 1);
        oneLabelLeft.textAlignment = NSTextAlignmentCenter;
        oneLabelRight.textAlignment = NSTextAlignmentCenter;
        oneLabelRight.font = [UIFont systemFontOfSize:12];
        oneLabelLeft.font = [UIFont systemFontOfSize:12];
        oneLabelLeft.layer.borderColor = RGBACOLOR(249, 53, 67, 1).CGColor;
        oneLabelLeft.layer.borderWidth = 1.0;
        oneLabelRight.layer.borderColor = RGBACOLOR(249, 53, 67, 1).CGColor;
        oneLabelRight.layer.borderWidth = 1.0;
        oneLabel.hidden = YES;
        oneLabelLeft.hidden = YES;
        oneLabelRight.hidden = YES;
        oneImage.hidden = YES;
        oneLabelRight.userInteractionEnabled = YES;
        oneLabelLeft.userInteractionEnabled = YES;

        UITapGestureRecognizer *tapL = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(LeftBtnClick)];
        UITapGestureRecognizer *tapR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(RightBtnClick)];
        [oneLabelLeft addGestureRecognizer:tapL];
        [oneLabelRight addGestureRecognizer:tapR];
        
        textField.placeholder = @"请输入优惠码";
        [textField setValue:RGBColor(173, 173, 173) forKeyPath:@"_placeholderLabel.textColor"];
        textField.delegate = self;
//        textField.keyboardType = UIKeyboardTypeNumberPad;
        textField.textColor = [UIColor whiteColor];
        textField.font = [UIFont systemFontOfSize:12];
        btn.backgroundColor = RGBACOLOR(235, 63, 66, 1);
        [btn setTitle:@"提交" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnyouhuiquan) forControlEvents:UIControlEventTouchUpInside];
        [imageBackAll mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.right.equalTo(self).offset(-10);
            make.top.equalTo(self).offset(10);
            make.bottom.equalTo(self).offset(-10);
        }];
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(30);
            make.right.equalTo(self).offset(-30);
            make.top.equalTo(self).offset(30);
            make.height.equalTo(@41);
        }];
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(image).offset(10);
            make.right.equalTo(image);
            make.top.equalTo(image);
            make.bottom.equalTo(image);
        }];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(image);
            make.right.equalTo(image);
            make.top.equalTo(image.mas_bottom).offset(15);
            make.bottom.equalTo(imageBackAll.mas_bottom).offset(-15);
        }];
        imageBackAll.image = [UIImage imageNamed:@"矩形22拷贝4"];
        image.image = [UIImage imageNamed:@"矩形22拷贝2"];
    }
    return self;
}
- (void)btnyouhuiquan{
    if ([self.textField isFirstResponder]) {
        [self.textField resignFirstResponder];
    }else{
        [self youhuiquanadd];
    }
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = 60;
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self youhuiquanadd];
    [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = IQdefaultHeight;
    NSLog(@"%f",[IQKeyboardManager sharedManager].keyboardDistanceFromTextField);
    
}
- (void)youhuiquanadd{
    
    if (!self.textField.text || !self.textField.text.length) {
        [MBProgressHUD showError:@"请输入有效的优惠券号"];
    } else {
        __weak typeof(self) weakSelf = self;
        [MBProgressHUD showMessage:@"正在添加"];
//        NSString *unicodeStr = self.textField.text;
//        unicodeStr = [unicodeStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [[TWClient sharedInstance]couponCodeRechargeWithcouponCode:self.textField.text success:^(id dataDict, NSString *msg, NSInteger code) {
            //            tcoinCnt
            [MBProgressHUD hideHUD];
            NSNumber *tcoinCnt = dataDict[@"tcoinCnt"];
            if (tcoinCnt && [tcoinCnt isKindOfClass:[NSNumber class]]) {
                weakSelf.oneImage.image = [UIImage imageNamed:@"勾"];
                weakSelf.oneLabel.text = [NSString stringWithFormat:@"优惠金%@T币已放入您T钱包账户",tcoinCnt];
                weakSelf.oneLabelLeft.text = @"我要购买机票";
                weakSelf.oneLabelRight.text = @"打开T钱包查看";
                weakSelf.oneLabelRight.tag = 10;
                
                weakSelf.oneLabelRight.hidden = NO;
                weakSelf.oneLabelLeft.hidden = NO;
                weakSelf.oneLabel.hidden = NO;
                weakSelf.oneImage.hidden = NO;
                weakSelf.textField.hidden = YES;
                weakSelf.btn.hidden = YES;
                weakSelf.image.hidden = YES;
                [weakSelf.oneImage mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.width.equalTo(@25);
                    make.height.equalTo(@25);
                    make.right.equalTo(self.oneLabel.mas_left).offset(-5);
                    make.centerY.equalTo(self.oneLabel);
                }];
                [weakSelf.oneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.equalTo(self.image).offset(15);
                    make.centerY.equalTo(self.image);
                }];
                [weakSelf.oneLabelLeft mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(self.btn);
                    make.height.equalTo(self.btn);
                    make.left.equalTo(self).offset((screenWidth-240*WIDTHICON-50*WIDTHICON)/2.0);
                    make.right.equalTo(self.oneLabelRight.mas_left).offset(-50*WIDTHICON);
                    make.width.equalTo(@(120*WIDTHICON));
                }];
                [weakSelf.oneLabelRight mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(self.btn);
                    make.height.equalTo(self.btn);
                    make.width.equalTo(@(120*WIDTHICON));
                }];
            }
        } failure:^(NSInteger errorCode, NSString *msg) {
            [MBProgressHUD hideHUD];
            if (![msg isKindOfClass:[NSNull class]] && msg && msg.length) {
                [MBProgressHUD showError:msg];
            }
        }];
    }
}
- (void)RightBtnClick{
    if (self.oneLabelRight.tag == 10) {
        NSLog(@"去T钱包查看");
        NSString *TUlr = @"testwallet://";
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:TUlr]]){

            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:TUlr]];
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"您还没有安装T钱包客户端哦" message:@"去安装" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alert.tag = 1011;
            [alert show];
        }
    } else if (self.oneLabelRight.tag == 11){
        self.oneLabelRight.hidden = YES;
        self.oneLabelLeft.hidden = YES;
        self.oneLabel.hidden = YES;
        self.oneImage.hidden = YES;
        
        self.textField.hidden = NO;
        self.btn.hidden = NO;
        self.image.hidden = NO;
    }
}
- (void)LeftBtnClick{
    NSLog(@"我要购买机票");
    UINavigationController *navc = NaVc;
    NSArray *arry = navc.childViewControllers;
    for (UIViewController *vc in arry) {
        if ([vc isKindOfClass:[zejiMain class]]) {
            [[NSNotificationCenter defaultCenter]postNotificationName:KNOTIFICATION_HomePage object:nil];
            [vc.navigationController popToViewController:vc animated:YES];
            return;
        }
    }
    
    zejiMain *Vc = [[zejiMain alloc]init];
    Vc.url = mainUrl;
    Vc.isRefeth = NO;
    Vc.scrollViewbouncesZE = NO;
    Vc.isClose = YES;
    Vc.ticketype = DOMESTICAIRTICKETS;
    [NaVc pushViewController:Vc animated:YES];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 1011) {
        if (buttonIndex == 1) {
            NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/cn/app/t-qian-bao/id1061514008?mt=8"];
            if ([[UIApplication sharedApplication] canOpenURL:url]){
                [[UIApplication sharedApplication] openURL:url];
            }
        }
    }
}
@end
