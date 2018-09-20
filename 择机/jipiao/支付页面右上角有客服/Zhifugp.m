//
//  Zhifugp.m
//  jipiao
//
//  Created by Store on 16/9/3.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "Zhifugp.h"
#import "HeaderTotal.h"
#import "imageAndBadge.h"
#import "payOk.h"
#import "MIBadgeButton.h"
#define WIDTHRIGHT  25

@interface Zhifugp ()<UIWebViewDelegate>
@property (nonatomic,weak) MIBadgeButton *badge;
@end

@implementation Zhifugp
- (void)viewDidLoad{
    self.isRefeth = NO;
    [super viewDidLoad];
    self.title = @"支付购票";
//    if ([self.url hasSuffix:zhifugoupiaoURL]) {
//        [self customRightButton];
//    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setWeiduxiaoNUmselector:) name:ChangeTheBadgeZejiKefu object:nil];
}

//- (void)customRightButton
//{
//    MIBadgeButton *badge = [MIBadgeButton buttonWithType:UIButtonTypeCustom];
//    self.badge = badge;
//    [badge setFrame:CGRectMake(0, 0, WIDTHRIGHT, WIDTHRIGHT*56/76)];
//    [badge setImage:[UIImage imageNamed:@"WechatIMG18"] forState:UIControlStateNormal];
//    [badge setBadgeString:@"0"];
//    [badge setBadgeTextColor:[UIColor whiteColor]];
//    [badge setBadgeBackgroundColor:[UIColor redColor]];
//    badge.hideWhenZero = YES;
//    [badge setBadgeEdgeInsets:UIEdgeInsetsMake(10, 0, 0, 0)];
//    [badge addTarget:self action:@selector(openku) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *leftBarutton = [[UIBarButtonItem alloc]initWithCustomView:badge];
//    self.navigationItem.rightBarButtonItem = leftBarutton;
//}
//- (void)openku{
//    if ([[Ticket sharedInstance]judgeIsLOgin]) {
//        NSString *tmp1 = @"contactCustomerService()";
//        [self.webView evaluateJavaScript:tmp1 completionHandler:nil];
//    } else {
//        [[NSNotificationCenter defaultCenter]postNotificationName:@"GoZeJiregisterNotificationCenter" object:nil];
//    }
//}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([[Ticket sharedInstance]judgeIsLOgin]) {
        [self ChangeTheBadgeMainLeftSelector];
    }
}
- (void)ChangeTheBadgeMainLeftSelector{
    // 统计未读消息数 是登录的
    __weak typeof(self) weakself = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];
        NSInteger unreadCountkefu = 0; //客服未读消息数
        for (EMConversation *conversation in conversations) {
            if ([conversation.conversationId isEqualToString:@"kefu"]) {
                unreadCountkefu += conversation.unreadMessagesCount;
            }
        }
        dispatch_sync(dispatch_get_main_queue(), ^(){
            weakself.badge.badgeString = [NSString stringWithFormat:@"%ld",(long)unreadCountkefu];
        });
    });
}
- (void)setWeiduxiaoNUmselector:(NSNotification *)user{
    NSDictionary *dic = user.userInfo;
    NSString *messge = dic[@"num"];
    self.badge.badgeString = messge;
}
@end
