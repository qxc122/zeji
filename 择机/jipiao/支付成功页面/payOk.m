//
//  payOk.m
//  jipiao
//
//  Created by Store on 16/8/31.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "payOk.h"
#import "HeaderTotal.h"


@interface payOk ()
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, weak) UILabel *labelsss;
@end

@implementation payOk

- (void)viewDidLoad {
    [super viewDidLoad];
//没有导航栏标题
    self.fd_prefersNavigationBarHidden = YES;
    self.fd_interactivePopDisabled = YES;
    self.view.backgroundColor = ColorBigBack;
    [self setuuui];
    [self startTimer];
    // Do any additional setup after loading the view.
}

- (void)setuuui{
    UIImageView *imageView = [[UIImageView alloc]init];
    [self.view addSubview:imageView];
    
    UILabel *label1 = [[UILabel alloc]init];
    [self.view addSubview:label1];
    
    UILabel *labelsss = [[UILabel alloc]init];
    self.labelsss = labelsss;
    [self.view addSubview:labelsss];
    
    UILabel *label2 = [[UILabel alloc]init];
    [self.view addSubview:label2];
    
    UIImageView *imageView2 = [[UIImageView alloc]init];
    [self.view addSubview:imageView2];
    
    UILabel *label3 = [[UILabel alloc]init];
    [self.view addSubview:label3];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(160*HEIGHTICON);
        make.width.equalTo(@(80*WIDTHICON));
        make.height.equalTo(@(80*WIDTHICON));
    }];
    
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_bottom).offset(25*HEIGHTICON);
        make.height.equalTo(@17);
        make.centerX.equalTo(self.view);
    }];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label1.mas_bottom).offset(20*HEIGHTICON);
        make.height.equalTo(@12);
        make.centerX.equalTo(self.view);
    }];
    [labelsss mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label2.mas_bottom).offset(9*HEIGHTICON);
        make.height.equalTo(@11);
        make.centerX.equalTo(self.view);
    }];
    [imageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(label3.mas_top).offset(-9*HEIGHTICON);
        make.height.equalTo(@1);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
    }];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-25*HEIGHTICON);
        make.height.equalTo(@10);
        make.centerX.equalTo(self.view);
    }];
    
    label1.text = @"恭喜您！订单已支付成功！";
    label2.text = @"请注意查收出票通知";
    NSString *tmpuu = @"3s后进入我的订单";
    label3.text = @"若需报销行程单，请进入我的机票订单中登记";
    label1.textColor = [UIColor colorWithWhite:1.0 alpha:1.0];
    label2.textColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:tmpuu];
    NSRange rangeone = [tmpuu rangeOfString:@"我的订单"];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:47/255.0 green:191/255.0 blue:238/255.0 alpha:1.0] range:rangeone];
    NSRange rangeone2 = NSMakeRange(0, tmpuu.length-rangeone.length);
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] range:rangeone2];
    [labelsss setAttributedText:attributedString];
    
    label3.textColor = [UIColor colorWithWhite:1.0 alpha:0.5];

    label1.font = [UIFont systemFontOfSize:18];
    label2.font = [UIFont systemFontOfSize:11];
    labelsss.font = [UIFont systemFontOfSize:10];
    label3.font = [UIFont systemFontOfSize:10];
    
    imageView.image = [UIImage imageNamed:@"gou"];
    imageView2.image = [UIImage imageNamed:@"line02"];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelsssSelector)];
    [labelsss addGestureRecognizer:tap];
    labelsss.userInteractionEnabled = YES;
}
-(void)labelsssSelector{
    [self stopTimer];
    [self openZEJImyBill];
}

- (void)startTimer {
    //如果定时器已开启，先停止再重新开启
    if (self.timer) [self stopTimer];
    self.timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(nextSesss) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
- (void)nextSesss{
    NSString *tmp = self.labelsss.text;

    NSScanner *scanner = [NSScanner scannerWithString:tmp];
    [scanner scanUpToCharactersFromSet:[NSCharacterSet decimalDigitCharacterSet] intoString:nil];
    int number;
    [scanner scanInt:&number];
    tmp =  [NSString stringWithFormat:@"%d",number];
    
//    tmp = [tmp returnNum:tmp];
    NSInteger num = [tmp integerValue];
    num--;
    if (num < 0) {
        [self tiaoguoClick];
    } else {
        NSString *tmpuu = [[NSString stringWithFormat:@"%ld",(long)num] stringByAppendingString:@"s后进入我的订单"];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:tmpuu];
        NSRange rangeone = [tmpuu rangeOfString:@"我的订单"];
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:47/255.0 green:191/255.0 blue:238/255.0 alpha:1.0] range:rangeone];
        NSRange rangeone2 = NSMakeRange(0, tmpuu.length-rangeone.length);
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] range:rangeone2];
        [self.labelsss setAttributedText:attributedString];
    }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.fd_interactivePopDisabled = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.fd_interactivePopDisabled = NO;
}
- (void)tiaoguoClick{
    NSLog(@"跳出其它的蒂法");
    [self openZEJImyBill];
    [self stopTimer];
}
- (void)openZEJImyBill{
    baseWebView *vc = [[baseWebView alloc]init];
//    LookMyBill *vc = [[LookMyBill alloc]init];
    vc.isCloseZhifu = YES;
    vc.isRefeth = NO;
//    if (self.isMyOrder) {
        NSString *tmp = nil;
#ifdef DEBUG
        tmp = @"我的机票订单";
#else
        tmp = @"机票订单";
#endif
        vc.title = tmp;
        vc.url = [kURLAPIBase stringByAppendingString:myOrder];

    [self.navigationController pushViewController:vc animated:YES];
}
- (void)dealloc{
    [self stopTimer];
}
- (void)stopTimer {
    [self.timer invalidate];
    self.timer = nil;
}
@end
