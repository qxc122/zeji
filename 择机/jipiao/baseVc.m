//
//  baseVc.m
//  jipiao
//
//  Created by admin on 16/7/25.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "baseVc.h"
#import "HeaderTotal.h"
#import "UIImage+cir.h"
#define WoolglassAlpha  0.9

@interface baseVc ()<logoAndRegistDelegate>
@property (nonatomic,weak) logoAndRegist *logoandregist;
@property (nonatomic,weak) UIVisualEffectView *Woolglass;
//@property (nonatomic,assign) BOOL isHidden; //保存导航栏的隐藏状态
@end

@implementation baseVc

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self customNavigationBar];
    [self customBackButton];
    self.view.backgroundColor = ColorBigBack;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(GoZeJiregister)
                                                name:@"GoZeJiregisterNotificationCenter" object:nil];
}

- (void)customNavigationBar
{
    
    self.navigationController.navigationBar.shadowImage=[UIImage new];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"hanbanchaxun"] forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:ColorWithHex(0x2B3B54, 1.0)] forBarMetrics:UIBarMetricsDefault];

    // 1.2设置所有导航条的标题颜色
    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setTintColor:[UIColor whiteColor]];
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    md[NSFontAttributeName] = [UIFont systemFontOfSize:17];
    md[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [navBar setTitleTextAttributes:md];
}

- (void)customBackButton
{
    UIImage* image = [[UIImage imageNamed:@"btnpre"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem* leftBarutton = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(popSelf)];
    self.navigationItem.leftBarButtonItem = leftBarutton;
}

- (void)popSelf
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (logoAndRegist *)logoandregist{
    if (!_logoandregist) {
        logoAndRegist *logoandregist = [[logoAndRegist alloc]init];
        logoandregist.delagate = self;
        [self.view addSubview:logoandregist];
        self.logoandregist = logoandregist;
        
        [self.logoandregist mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(6*WIDTHICON);
            make.right.equalTo(self.view).offset(-6*WIDTHICON);
            make.centerY.equalTo(self.view).offset(0);
            make.height.equalTo(@(239*HEIGHTICON));
        }];
    }
    return _logoandregist;
}
- (void)wechatLogin
{
    SendAuthReq *req = [[SendAuthReq alloc] init];
    req.scope = @"snsapi_userinfo";
    req.state = @"zeji";
    [WXApi sendReq:req];
}
- (void)clickWeixinLogin{
    [self logoAndRegistWillClose];
    [self wechatLogin];
}
- (void)logoAndRegistWillClose{
    [self.navigationController setNavigationBarHidden:self.fd_prefersNavigationBarHidden animated:YES];
    [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = IQdefaultHeight;
    
    [UIView animateWithDuration:.1 animations:^{
        self.logoandregist.transform = CGAffineTransformMakeScale(0.1, 0.1);
        self.logoandregist.alpha = 0.0;
        self.Woolglass.alpha = 0.0;
        //self.Woolglass.transform = CGAffineTransformMakeScale(0.1, 0.1);
    } completion:^(BOOL finished) {
        if (finished) {
            [self.logoandregist removeFromSuperview];
            [self.Woolglass removeFromSuperview];
            self.Woolglass = nil;
            self.logoandregist = nil;
        }
    }];
}
- (void)GoZeJiregister{
    if ([self.navigationController.topViewController isKindOfClass:[self class]]) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        [WXApi registerApp:WechatAppIDOther];
        self.Woolglass.hidden = NO;
        self.logoandregist.hidden = NO;
        
        self.logoandregist.transform = CGAffineTransformMakeScale(0.3, 0.3);
        self.logoandregist.alpha = 0;
        //self.Woolglass.transform = CGAffineTransformMakeScale(0.3, 0.3);
        self.Woolglass.alpha = 0;
        [UIView animateWithDuration:0.2 animations:^{
            self.logoandregist.alpha = 1;
            self.Woolglass.alpha = WoolglassAlpha;
            self.logoandregist.transform = CGAffineTransformMakeScale(1, 1);
            //self.Woolglass.transform = CGAffineTransformMakeScale(1, 1);
        } completion:^(BOOL finished) {
            
        }];
        [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = (239-90+9)*HEIGHTICON + IQdefaultHeight;
    }
}

- (UIVisualEffectView *)Woolglass{
    if (!_Woolglass) {
        UIVisualEffectView *visualEfView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
        visualEfView.alpha = WoolglassAlpha;
        [self.view addSubview:visualEfView];
        [visualEfView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(0);
            make.right.equalTo(self.view).offset(0);
            make.bottom.equalTo(self.view).offset(0);
            make.height.equalTo(@(screenHeight));
        }];
        visualEfView.hidden = YES;
        _Woolglass = visualEfView;
        UITapGestureRecognizer *rep = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(logoAndRegistWillClose)];
        [visualEfView addGestureRecognizer:rep];
    }
    return _Woolglass;
}
@end
