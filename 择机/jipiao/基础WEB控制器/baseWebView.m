//
//  baseWebView.m
//  jipiao
//
//  Created by Store on 16/9/20.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "baseWebView.h"
#import "Zhifugp.h"
#import "zejiMain.h"

@interface baseWebView ()

@end

@implementation baseWebView

- (void)viewDidLoad{
    [super viewDidLoad];
    self.loadingView.hidden = NO;
    [self increaseNotice];
}
- (void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    if (self.isCloseZhifu) {
        NSMutableArray *navigationarray = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
        for (NSInteger i = 0; i<[navigationarray count]; i++) {
            UIViewController *conV = navigationarray[i];
            if ([conV isKindOfClass:[Zhifugp class]]) {
                [navigationarray removeObjectAtIndex:i];
                i = 0;
            }else if ([conV isKindOfClass:[payOk class]]) {
                [navigationarray removeObjectAtIndex:i];
                i = 0;
            }
        }
        [[NSNotificationCenter defaultCenter]postNotificationName:KNOTIFICATION_HomePage object:nil];
        self.navigationController.viewControllers = navigationarray;
        self.isCloseZhifu = NO;
    }
}

- (void)increaseNotice{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wechatPaySuccessller:) name:@"wechatPaySuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wechatPayUserCancelller:) name:@"wechatPayUserCancel" object:nil];
    
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wechatPaySuccessller:) name:@"wechatPayUserCancel" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wechatPayFaildller:) name:@"wechatPayFaild" object:nil];
}

//- (void)reloadWebpage{
//    //等待H5改进 刷新会有错误
//    [self.webView reload];
//}
//

- (void)dealloc{
    NSLog(@"%s",__func__);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)wechatPaySuccessller:(NSNotification *)user{
    if (self.navigationController.topViewController == self) {
        [MBProgressHUD showSuccess:@"支付成功"];
        if ([self isKindOfClass:[zejiMain class]]) {
            [self backGenWeb];
            payOk *vc = [[payOk alloc]init];
            vc.isMyOrder = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else if ([self isKindOfClass:[Zhifugp class]]){
            payOk *vc = [[payOk alloc]init];
            vc.isMyOrder = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            [self backGenWeb];
        }
    }
}

- (void)backGenWeb{
    if ([self.webView canGoBack]) {
        NSArray *arry = self.webView.backForwardList.backList;
        WKBackForwardListItem *first = [arry firstObject];
        [self.webView goToBackForwardListItem:first];
    }
}

- (void)wechatPayUserCancelller:(NSNotification *)user{
    [self tozhipiaodingdangView];
}
- (void)wechatPayFaildller:(NSNotification *)user{
    [self tozhipiaodingdangView];
}
- (void)tozhipiaodingdangView{
    NSString *tmp = nil;
#ifdef DEBUG
    tmp = @"我的机票订单";
#else
    tmp = @"机票订单";
#endif
    if (self.navigationController.topViewController == self) {
        if ([self isKindOfClass:[zejiMain class]] || [self isKindOfClass:[Zhifugp class]]) {
            baseWebView *vc = [[baseWebView alloc]init];
            vc.isRefeth = NO;
            vc.isCloseZhifu = YES;
            vc.title = tmp;
            vc.url = [kURLAPIBase stringByAppendingString:myOrder];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
        
        }
    }
}

@end

