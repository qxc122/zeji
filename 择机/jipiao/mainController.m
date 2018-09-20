//
//  mainController.m
//  jipiao
//
//  Created by Store on 16/7/29.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "mainController.h"
#import "HeaderTotal.h"
#import "leftdataamain.h"
#import "zejiMain.h"
#import "MIBadgeButton.h"
#import "SDImageCache.h"
#import "QCarousel.h"
#import "EMConversation.h"
#import "ChatViewController.h"
#import "XAlertView.h"
#import "QCarouselData.h"

#import "myinfo.h"
#import "ConversationListController.h"
#import "ChatDemoHelper.h"

#import "myinfoData.h"
#import "UIImage+GIF.h"
#import "SDWebImageManager.h"

#define widthbtnLeft 30  //登录 和 客服按钮的大小
#define widthhangb   150  //国际航班，国内航班的宽高
#define spaceingyTop  20 //国际航班，国内航班距离顶端的距离
#define spaceingxLF  20 //国际航班，国内航班距离左右的距离

#define WIDTHtiaoguo  80
#define HEIGHTtiaoguo 25
#define WIDTHlabelSes 20
#define SPaceingToToplabelSes 22





//两次提示的默认间隔
static const CGFloat kDefaultPlaySoundInterval = 3.0;
static NSString *kMessageType = @"MessageType";
static NSString *kConversationChatter = @"ConversationChatter";
static NSString *kGroupName = @"GroupName";

@interface mainController ()<CLLocationManagerDelegate,UIAlertViewDelegate>
{
    ConversationListController *_chatListVC;
}
@property (nonatomic,strong) CLLocationManager *manager;
@property (nonatomic,strong) NSString *LocalCity;

@property (strong, nonatomic) NSDate *lastPlaySoundDate;
@property (nonatomic,weak) UIImageView *backImage;
@property (nonatomic,weak) UIImageView *backImageTwo;
@property (nonatomic,weak) UIButton *domesticImage;
#ifdef guoji_tiket
@property (nonatomic,weak) UIButton *internationalImage;
#endif
@property (nonatomic,weak) MIBadgeButton *badge;//UIButton *btnLeft;
@property (nonatomic,weak) UIButton *btnRight;
@property (nonatomic,weak) UIImageView *titleImage;
@property (nonatomic,weak) QCarousel *tmpView;

@property (nonatomic,strong) QCarouselDataArry *arryGetCooperationApp;

@property (nonatomic,weak) UIImageView *activityImg; //活动页
@property (nonatomic,strong) GlobalParams *arrryDes; //全局参数

@end

@implementation mainController
- (void)viewDidLoad{
    [super viewDidLoad];

    self.fd_prefersNavigationBarHidden = YES;
    [self setUi];
//    [self startTimer];
//    GlobalParams *arrryDes = [NSKeyedUnarchiver unarchiveObjectWithFile:ALLHDATA];
//    if (arrryDes) {
//        [self.Advertisement sd_setImageWithURL:[NSURL URLWithString:arrryDes.startPicture]];
//    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupUnreadMessageCount)name:ZEJILoginsuccess object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupUnreadMessageCount)name:ZEJILogOutsuccess object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getdataInMainView)name:NOTIFINAME_REGETDATA object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupUnreadMessageCount) name:@"setupUnreadMessageCount" object:nil];
    
    _chatListVC = [[ConversationListController alloc]init];
    [ChatDemoHelper shareHelper].conversationListVC = _chatListVC;
    [ChatDemoHelper shareHelper].mainVC = self;
    

    [self getdataInMainView];

//    NSDictionary *dict = @{
//                          @"title":@"我是标题",
//                          @"description":@"阿斯顿发大发阿斯顿发阿斯顿发撒大的风阿斯顿发发啊发",
//                          @"thumbImage":[UIImage imageNamed:@"545"],
//                          @"webpageUrl":@"https://www.baidu.com/s?tn=monline_3_dg&wd=%E8%85%BE%E8%AE%AF%E5%BE%AE%E5%8D%9A&ie=utf-8&rsv_cq=%E7%BD%91%E9%A1%B5%E7%B1%BB%E5%9E%8B%E5%88%86%E4%BA%AB%E7%A4%BA%E4%BE%8B&rsv_dl=0_right_recommends_merge_28335&euri=3264698",
//                          @"scene":@(WXSceneSession),
//                           };
//    [WXApi registerApp:WechatAppID];
//    [[TWWechatPayManager sharedInstance]shareTOWXsceneWithinfo:dict];
    [self LoadLocalCity];
}
- (void)getdataInMainView{
    __weak typeof(self) weakself = self;
    [[TWClient sharedInstance]queryMenusuccess:^(id dataDict, NSString *msg, NSInteger code) {
        dicmenuArray *arrryDes = [MTLJSONAdapter modelOfClass:[dicmenuArray class] fromJSONDictionary:dataDict error:nil];
        [NSKeyedArchiver archiveRootObject:arrryDes toFile:LEFTDATA];
        NSLog(@"在首页  获取左侧列表成功");
    } failure:^(NSInteger errorCode, NSString *msg) {
        NSLog(@"在首页  获取左侧列表失败");
    }];

    [[TWClient sharedInstance]getGlobalParamssuccess:^(id dataDict, NSString *msg, NSInteger code) {
        NSLog(@"在首页  获取全局参数获取OK");
        GlobalParams *arrryDes = [MTLJSONAdapter modelOfClass:[GlobalParams class] fromJSONDictionary:dataDict error:nil];
        weakself.arrryDes = arrryDes;
        if (self.arrryDes.activityImg && self.arrryDes.activityUrl && self.arrryDes.activityImg.length && self.arrryDes.activityUrl.length ) {
            weakself.activityImg.hidden = NO;
            [weakself.activityImg sd_setImageWithURL:[NSURL URLWithString:self.arrryDes.activityImg]];
        }
        
        [NSKeyedArchiver archiveRootObject:arrryDes toFile:ALLHDATA];
//        [weakself.Advertisement sd_setImageWithURL:[NSURL URLWithString:arrryDes.startPicture]];
    } failure:^(NSInteger errorCode, NSString *msg) {
        NSLog(@"在首页  获取全局参数获取失败");
    }];
    
    if ([[Ticket sharedInstance]judgeIsLOgin]) {
        [[TWClient sharedInstance]getMyInfosuccess:^(id dataDict, NSString *msg, NSInteger code) {
            NSLog(@"在首页  查询我的信息OK");
            myinfoData *data =[MTLJSONAdapter modelOfClass:[myinfoData class] fromJSONDictionary:dataDict error:NULL];
            data.flyCreditInfo = [MTLJSONAdapter modelOfClass:[flyCreditInfoData class] fromJSONDictionary:dataDict[@"flyCreditInfo"] error:NULL];
            [NSKeyedArchiver archiveRootObject:data toFile:GRXXDATA];
        } failure:^(NSInteger errorCode, NSString *msg) {
            if (errorCode == 100003) {
                [[TWClient sharedInstance]logoutsuccess:^(id dataDict, NSString *msg, NSInteger code) {
                    [[Ticket sharedInstance]updateLogininfo:ZEJIOUT];
                } failure:^(NSInteger errorCode, NSString *msg) {
                    
                }];
            }
            NSLog(@"在首页  查询我的信息FAIL");
        }];
    }
    [self checkVerTheApp];
    [self loadExternalAppOrUrl];
}

- (void)loadExternalAppOrUrl{
    __weak typeof(self) weakSelf = self;
    [[TWClient sharedInstance]getCooperationAppsuccess:^(id dataDict, NSString *msg, NSInteger code) {//QCarouselData
        weakSelf.arryGetCooperationApp = [MTLJSONAdapter modelOfClass:[QCarouselDataArry class] fromJSONDictionary:dataDict error:nil];
        
        weakSelf.tmpView.imageArray = weakSelf.arryGetCooperationApp;
        [NSKeyedArchiver archiveRootObject:weakSelf.arryGetCooperationApp toFile:APPORURL];
    } failure:^(NSInteger errorCode, NSString *msg) {
        
    }];
}
- (void)checkVerTheApp{ //检查更新
//    __weak typeof(self) weakSelf = self;
    [[TWClient sharedInstance]appUpdatesuccess:^(id dataDict, NSString *msg, NSInteger code) {
        NSString *isGengxing = dataDict[@"updateType"];;
        NSString *detail = dataDict[@"updateInfoUrl"];
        if ([isGengxing isEqualToString:@"1"] || [isGengxing isEqualToString:@"2"]) {
            XAlertView *alert = [[XAlertView alloc] initWithTitle:@"提示" message:detail clickedBlock:^(XAlertView *alertView, BOOL canceled, NSInteger clickedIndex) {
                if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/ze-ji/id1151039931?mt=8"]] && !canceled) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/ze-ji/id1151039931?mt=8"]];
                }
            }cancelButtonTitle:[isGengxing isEqualToString:@"2"]?nil:@"取消" otherButtonTitles:@"去更新",nil];
            //TODO:
            if ([isGengxing isEqualToString:@"2"]) {
                alert.isDisappear = NO;
            } else {
                alert.isDisappear = YES;
            }
            [alert show];
        }else if ([isGengxing isEqualToString:@"0"]){
            
        }
    } failure:^(NSInteger errorCode, NSString *msg) {
        NSLog(@"检查更新失败");
    }];
}
- (void)setUi{
    UIImageView *backImage = [[UIImageView alloc]init];
    self.backImage = backImage;
    backImage.image = [UIImage imageNamed:@"img_home_base"];
    [self.view addSubview:backImage];
    [self.backImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    UIImageView *backImageTwo = [[UIImageView alloc]init];
    self.backImageTwo = backImageTwo;
    backImageTwo.image = [UIImage imageNamed:@"img_01_logo"];
    
    [self.view addSubview:backImageTwo];
    [self.backImageTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_top).offset(283*HEIGHTICON);
    }];

    UIButton *domesticImage = [[UIButton alloc]init];
    self.domesticImage = domesticImage;
    [self.domesticImage setImage:[UIImage imageNamed:@"icon_domestic"] forState:UIControlStateNormal];
    [self.domesticImage setImage:[UIImage imageNamed:@"icon_domestic_press"] forState:UIControlStateHighlighted];
    [self.view addSubview:domesticImage];
#ifdef guoji_tiket
    UIButton *internationalImage = [[UIButton alloc]init];
    self.internationalImage = internationalImage;
    [self.internationalImage setImage:[UIImage imageNamed:@"icon_international"] forState:UIControlStateNormal];
    [self.internationalImage setImage:[UIImage imageNamed:@"icon_international_press"] forState:UIControlStateHighlighted];
    
    [self.view addSubview:internationalImage];
#endif
    QCarousel *tmpView = [[QCarousel alloc]init];
    tmpView.layer.borderColor = RGBColor(134, 134, 134).CGColor;
    tmpView.layer.borderWidth = 0.5;
    [self.view addSubview:tmpView];
    self.tmpView = tmpView;
    
    UIImageView *titleImage = [[UIImageView alloc]init];
    titleImage.layer.borderColor = RGBColor(134, 134, 134).CGColor;
    titleImage.layer.borderWidth = 0.5;
    self.titleImage = titleImage;
    titleImage.image = [UIImage imageNamed:@"img_slogan"];
    [self.view addSubview:titleImage];
    
    MIBadgeButton *badge = [MIBadgeButton buttonWithType:UIButtonTypeCustom];
    self.badge = badge;
    [self.view addSubview:badge];
    [badge setFrame:CGRectMake(0, 0, 30, 30)];
    [badge setImage:[UIImage imageNamed:@"icon_customer"] forState:UIControlStateNormal];
    [badge setImage:[UIImage imageNamed:@"icon_customer_01"] forState:UIControlStateHighlighted];
    [badge setBadgeString:@"0"];
    [badge setBadgeTextColor:[UIColor whiteColor]];
    [badge setBadgeBackgroundColor:[UIColor redColor]];
    badge.hideWhenZero = YES;
    [badge setBadgeEdgeInsets:UIEdgeInsetsMake(10, 0, 0, 0)];
    
    UIButton *btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btnRight];
    self.btnRight = btnRight;
    
    [self.btnRight setImage:[UIImage imageNamed:@"icon_user"] forState:UIControlStateNormal];
//    [self.btnRight setImage:[UIImage imageNamed:@"icon_personal_01"] forState:UIControlStateHighlighted];
    
    UIImageView *activityImg = [[UIImageView alloc]init];
//    activityImg.backgroundColor = [UIColor redColor];
    self.activityImg = activityImg;
    [self.view addSubview:activityImg];
    activityImg.contentMode = UIViewContentModeScaleAspectFit;
#ifndef guoji_tiket
    CGFloat widthImage = (screenWidth-(58+47+47)*WIDTHICON)/2;
#endif
    [self.domesticImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-244*HEIGHTICON);
#ifdef guoji_tiket
        make.left.equalTo(self.view).offset(47*WIDTHICON);
        make.right.equalTo(self.internationalImage.mas_left).offset(-58*WIDTHICON);
        make.width.equalTo(@[self.internationalImage]);
        make.height.equalTo(@[self.internationalImage]);
#else
        make.centerX.equalTo(self.view);
        make.width.equalTo(@(widthImage));
        make.height.equalTo(@(widthImage));
#endif
    }];
#ifdef guoji_tiket
    [self.internationalImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.domesticImage);
        make.bottom.equalTo(self.domesticImage);
        make.right.equalTo(self.view).offset(-47*WIDTHICON);
    }];
#endif
    [btnRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-26);
        make.bottom.equalTo(tmpView.mas_top).offset(-14);
        make.height.equalTo(@(widthbtnLeft));
        make.width.equalTo(@(widthbtnLeft));
    }];
    [badge mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(26);
        make.bottom.equalTo(tmpView.mas_top).offset(-14);
        make.height.equalTo(@(widthbtnLeft));
        make.width.equalTo(@(widthbtnLeft));
    }];
//    [UILabelBage mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(btnLeft).offset(13);
//        make.centerY.equalTo(btnLeft).offset(-13);
//        make.height.equalTo(@(MINIWIDTHANDHEIGHT));
//        make.width.equalTo(@(MINIWIDTHANDHEIGHT));
//    }];
    
    
    [titleImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@132);
        make.height.equalTo(@23);
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.tmpView.mas_top);
    }];
    [tmpView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-20);
        make.height.equalTo(@(HEIGHTICON*92));
    }];
    
    [activityImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleImage);
        make.right.equalTo(titleImage);
        make.top.equalTo(domesticImage.mas_bottom).offset(10);
        make.bottom.equalTo(titleImage.mas_top).offset(-15);
    }];

    activityImg.hidden = YES;
    activityImg.userInteractionEnabled = YES;
    UITapGestureRecognizer *acticiRes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(activityImgClick)];
    [activityImg addGestureRecognizer:acticiRes];
    [self.domesticImage addTarget:self action:@selector(clickdomesticImage:) forControlEvents:UIControlEventTouchUpInside];
#ifdef guoji_tiket
    [self.internationalImage addTarget:self action:@selector(clickinternationalImage:) forControlEvents:UIControlEventTouchUpInside];
#endif
    [self.badge addTarget:self action:@selector(clickbtnLeft:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnRight addTarget:self action:@selector(clickbtnRight:) forControlEvents:UIControlEventTouchUpInside];

    self.arryGetCooperationApp = [NSKeyedUnarchiver unarchiveObjectWithFile:APPORURL];
    if (self.arryGetCooperationApp) {
        tmpView.imageArray = self.arryGetCooperationApp;
    }
}
- (void)activityImgClick{
    //点击活动页面;
    baseWebView *vc = [[baseWebView alloc]init];
    vc.isRefeth = NO;
    vc.title = self.arrryDes.activityTitle;
    vc.url = self.arrryDes.activityUrl;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)clickdomesticImage:(UIGestureRecognizer *)gestureRecognizer{
    [self openZeJiTwoController:YES];
}
- (void)clickinternationalImage:(UIGestureRecognizer *)gestureRecognizer{
    [self openZeJiTwoController:NO];
//        MBProgressHUD * HUD = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
//        HUD.mode = MBProgressHUDModeText;
//
//        HUD.removeFromSuperViewOnHide = YES;
//
//        HUD.label.text = @"功能待完善,敬请期待"; //把这一行
//        HUD.detailsLabel.text = @"Function improving and coming soon";  //换成这一行就 可以
//        [HUD hideAnimated:YES afterDelay:1.0];
//    }
}
- (void)openZeJiTwoController:(BOOL)isDomestic{
    zejiMain *Vc = [[zejiMain alloc]init];
    Vc.LocalCity = self.LocalCity;
    Vc.isDomestic = isDomestic;
    Vc.url = mainUrl;
//    Vc.url = @"https://zeji.tempus.cn/zeji-front/test/locationTest.html";
    Vc.isRefeth = NO;
    Vc.scrollViewbouncesZE = NO;
    Vc.ticketype = DOMESTICAIRTICKETS;
    [self.navigationController pushViewController:Vc animated:YES];
}
- (void)clickbtnLeft:(UIGestureRecognizer *)gestureRecognizer{
    if ([[Ticket sharedInstance]judgeIsLOgin]) {
        ChatViewController *chatController = [[ChatViewController alloc]
                                              initWithConversationChatter:HXkefuID conversationType:EMConversationTypeChat];
        chatController.title = @"在线客服";
        [self.navigationController pushViewController:chatController animated:YES];
    }else{
        [[NSNotificationCenter defaultCenter]postNotificationName:@"GoZeJiregisterNotificationCenter" object:nil];
    }
}
- (void)clickbtnRight:(UIGestureRecognizer *)gestureRecognizer{

    [MobClick event:@"name1" attributes:@{@"book" : @"Swift Fundamentals"} counter:110];
    [MobClick event:@"name2"];
    if ([[Ticket sharedInstance]judgeIsLOgin]) {
        myinfo *Vc = [[myinfo alloc]init];
        [self.navigationController pushViewController:Vc animated:YES];
//        [MBProgressHUD showError:@"您已登录"];
    }else{
        [[NSNotificationCenter defaultCenter]postNotificationName:@"GoZeJiregisterNotificationCenter" object:nil];
    }
}
- (void)customBackButton{

}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    [[NSURLCache sharedURLCache]removeAllCachedResponses];
//    [[IQKeyboardManager sharedManager] setEnable:NO];
//
//    [[IQKeyboardManager sharedManager] disableToolbarInViewControllerClass:[self class]];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

//环信
// 统计未读消息数
-(void)setupUnreadMessageCount
{
        __weak typeof(self) weakself = self;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSInteger unreadCount = 0; //未读消息数
            NSInteger unreadCountkefu = 0; //客服未读消息数
            if ([[Ticket sharedInstance]judgeIsLOgin]) {
                NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];
                for (EMConversation *conversation in conversations) {
                    if ([conversation.conversationId isEqualToString:@"kefu"]) {
                        unreadCountkefu += conversation.unreadMessagesCount;
                    }
                    unreadCount += conversation.unreadMessagesCount;
                }
            } else {
                unreadCount = 0;
                unreadCountkefu = 0;
            }
            dispatch_sync(dispatch_get_main_queue(), ^(){
                NSString *num1 = [NSString stringWithFormat:@"%ld",(long)unreadCount];
                NSString *num2 = [NSString stringWithFormat:@"%ld",(long)unreadCountkefu];
                NSDictionary *dictTmp1 = @{@"num":num1};
                NSNotification *notification1 =[NSNotification notificationWithName:ChangeTheBadgeZejiMain object:nil userInfo:dictTmp1];
                [[NSNotificationCenter defaultCenter] postNotification:notification1];
                
                NSDictionary *dictTmp2 = @{@"num":num2};
                NSNotification *notification2 =[NSNotification notificationWithName:ChangeTheBadgeZejiKefu object:nil userInfo:dictTmp2];
                [[NSNotificationCenter defaultCenter] postNotification:notification2];
                
                weakself.badge.badgeString = [NSString stringWithFormat:@"%ld",(long)unreadCountkefu];
   
                //发送通知  改变徽章数目
                UIApplication *application = [UIApplication sharedApplication];
                [application setApplicationIconBadgeNumber:unreadCount];
            });
        });
}

- (void)setupUntreatedApplyCount
{

}

- (void)networkChanged:(EMConnectionState)connectionState
{
    _connectionState = connectionState;

}

- (void)playSoundAndVibration{
    NSTimeInterval timeInterval = [[NSDate date]
                                   timeIntervalSinceDate:self.lastPlaySoundDate];
    if (timeInterval < kDefaultPlaySoundInterval) {
        //如果距离上次响铃和震动时间太短, 则跳过响铃
        NSLog(@"skip ringing & vibration %@, %@", [NSDate date], self.lastPlaySoundDate);
        return;
    }

    //保存最后一次响铃时间
    self.lastPlaySoundDate = [NSDate date];
    
    // 收到消息时，播放音频
//    [[EMCDDeviceManager sharedInstance] playNewMessageSound];
    // 收到消息时，震动
    [[EMCDDeviceManager sharedInstance] playVibration];
}

- (void)showNotificationWithMessage:(EMMessage *)message
{
    EMPushOptions *options = [[EMClient sharedClient] pushOptions];
    //发送本地推送
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.fireDate = [NSDate date]; //触发通知的时间
    
    if (options.displayStyle == EMPushDisplayStyleMessageSummary) {
        EMMessageBody *messageBody = message.body;
        NSString *messageStr = nil;
        switch (messageBody.type) {
            case EMMessageBodyTypeText:
            {
                messageStr = ((EMTextMessageBody *)messageBody).text;
            }
                break;
            case EMMessageBodyTypeImage:
            {
                messageStr = NSLocalizedString(@"message.image", @"Image");
            }
                break;
            case EMMessageBodyTypeLocation:
            {
                messageStr = NSLocalizedString(@"message.location", @"Location");
            }
                break;
            case EMMessageBodyTypeVoice:
            {
                messageStr = NSLocalizedString(@"message.voice", @"Voice");
            }
                break;
            case EMMessageBodyTypeVideo:{
                messageStr = NSLocalizedString(@"message.video", @"Video");
            }
                break;
            default:
                break;
        }
        
        do {
            NSString *title = nil;
            if (message.chatType == EMChatTypeGroupChat) {
                NSDictionary *ext = message.ext;
                if (ext && ext[kGroupMessageAtList]) {
                    id target = ext[kGroupMessageAtList];
                    if ([target isKindOfClass:[NSString class]]) {
                        if ([kGroupMessageAtAll compare:target options:NSCaseInsensitiveSearch] == NSOrderedSame) {
                            notification.alertBody = [NSString stringWithFormat:@"%@%@", title, NSLocalizedString(@"group.atPushTitle", @" @ me in the group")];
                            break;
                        }
                    }
                    else if ([target isKindOfClass:[NSArray class]]) {
                        NSArray *atTargets = (NSArray*)target;
                        if ([atTargets containsObject:[EMClient sharedClient].currentUsername]) {
                            notification.alertBody = [NSString stringWithFormat:@"%@%@", title, NSLocalizedString(@"group.atPushTitle", @" @ me in the group")];
                            break;
                        }
                    }
                }
                NSArray *groupArray = [[EMClient sharedClient].groupManager getAllGroups];
                for (EMGroup *group in groupArray) {
                    if ([group.groupId isEqualToString:message.conversationId]) {
                        title = [NSString stringWithFormat:@"%@(%@)", message.from, group.subject];
                        break;
                    }
                }
            }
            else if (message.chatType == EMChatTypeChatRoom)
            {
                NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                NSString *key = [NSString stringWithFormat:@"OnceJoinedChatrooms_%@", [[EMClient sharedClient] currentUsername]];
                NSMutableDictionary *chatrooms = [NSMutableDictionary dictionaryWithDictionary:[ud objectForKey:key]];
                NSString *chatroomName = [chatrooms objectForKey:message.conversationId];
                if (chatroomName)
                {
                    title = [NSString stringWithFormat:@"%@(%@)", message.from, chatroomName];
                }
            }
            
            notification.alertBody = [NSString stringWithFormat:@"%@:%@", title, messageStr];
        } while (0);
    }
    else{
        notification.alertBody = NSLocalizedString(@"receiveMessage", @"you have a new message");
    }
    
#warning 去掉注释会显示[本地]开头, 方便在开发中区分是否为本地推送
    //notification.alertBody = [[NSString alloc] initWithFormat:@"[本地]%@", notification.alertBody];
    
    notification.alertAction = NSLocalizedString(@"open", @"Open");
    notification.timeZone = [NSTimeZone defaultTimeZone];
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:self.lastPlaySoundDate];
    if (timeInterval < kDefaultPlaySoundInterval) {
        NSLog(@"skip ringing & vibration %@, %@", [NSDate date], self.lastPlaySoundDate);
    } else {
        notification.soundName = UILocalNotificationDefaultSoundName;
        self.lastPlaySoundDate = [NSDate date];
    }
    
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    [userInfo setObject:[NSNumber numberWithInt:message.chatType] forKey:kMessageType];
    [userInfo setObject:message.conversationId forKey:kConversationChatter];
    notification.userInfo = userInfo;
    
    //发送通知
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    UIApplication *application = [UIApplication sharedApplication];
    application.applicationIconBadgeNumber += 1;
}

#pragma mark - public

- (void)jumpToChatList
{
    
    if ([self.navigationController.topViewController isKindOfClass:[ChatViewController class]]) {

    }else if(_chatListVC){
        [self.navigationController  pushViewController:_chatListVC animated:YES];
    }
}

- (EMConversationType)conversationTypeFromMessageType:(EMChatType)type
{
    EMConversationType conversatinType = EMConversationTypeChat;
    switch (type) {
        case EMChatTypeChat:
            conversatinType = EMConversationTypeChat;
            break;
        case EMChatTypeGroupChat:
            conversatinType = EMConversationTypeGroupChat;
            break;
        case EMChatTypeChatRoom:
            conversatinType = EMConversationTypeChatRoom;
            break;
        default:
            break;
    }
    return conversatinType;
}

- (void)didReceiveLocalNotification:(UILocalNotification *)notification
{
    
    NSDictionary *userInfo = notification.userInfo;
    if (userInfo)
    {
//        if ([self.navigationController.topViewController isKindOfClass:[ChatViewController class]]) {
//            NSString *conversationChatter = userInfo[kConversationChatter];
//            ChatViewController *chatViewController = (ChatViewController *)self.navigationController.topViewController;
//            if (![chatViewController.conversation.conversationId isEqualToString:conversationChatter]){
//                [self.navigationController popViewControllerAnimated:NO];
//                
//                EMChatType messageType = [userInfo[kMessageType] intValue];
//                chatViewController = [[ChatViewController alloc]initWithConversationChatter:conversationChatter conversationType:[self conversationTypeFromMessageType:messageType]];
//                chatViewController.title = conversationChatter;
//                [self.navigationController pushViewController:chatViewController animated:NO];
//            }
//        }else{
//            ChatViewController *chatViewController = nil;
//            NSString *conversationChatter = userInfo[kConversationChatter];
//            EMChatType messageType = [userInfo[kMessageType] intValue];
//            chatViewController = [[ChatViewController alloc]initWithConversationChatter:conversationChatter conversationType:[self conversationTypeFromMessageType:messageType]];
//            chatViewController.title = conversationChatter;
//            if (self.navigationController) {
//                NSLog(@"yes");
//            } else {
//               NSLog(@"no"); 
//            }
//            [self.navigationController pushViewController:chatViewController animated:NO];
//        }
//        return;
    NSArray *viewControllers = self.navigationController.viewControllers;
    [viewControllers enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop){
        if (obj != self){
            if (![obj isKindOfClass:[ChatViewController class]]){
                [self.navigationController popViewControllerAnimated:NO];
            }else{
                NSString *conversationChatter = userInfo[kConversationChatter];
                ChatViewController *chatViewController = (ChatViewController *)obj;
                    if (![chatViewController.conversation.conversationId isEqualToString:conversationChatter]){
                        [self.navigationController popViewControllerAnimated:NO];
                        EMChatType messageType = [userInfo[kMessageType] intValue];
                        chatViewController = [[ChatViewController alloc]initWithConversationChatter:conversationChatter conversationType:[self conversationTypeFromMessageType:messageType]];
                        switch (messageType) {
                            case EMChatTypeChat:{
                                chatViewController.title = conversationChatter;
//                                NSArray *groupArray = [[EMClient sharedClient].groupManager getAllGroups];
//                            for (EMGroup *group in groupArray) {
//                                if ([group.groupId isEqualToString:conversationChatter]){
//                                    chatViewController.title = group.subject;
//                                                              break;
//                                    }
//                                }
                            }
                            break;
                            default:
                            chatViewController.title = conversationChatter;
                            break;
                        }
                        [self.navigationController pushViewController:chatViewController animated:NO];
                }
                *stop = YES;
        }
    } else{
            ChatViewController *chatViewController = nil;
            NSString *conversationChatter = userInfo[kConversationChatter];
            EMChatType messageType = [userInfo[kMessageType] intValue];
            chatViewController = [[ChatViewController alloc]initWithConversationChatter:conversationChatter conversationType:[self conversationTypeFromMessageType:messageType]];
//            switch (messageType) {
//                case EMChatTypeGroupChat:{
//                    NSArray *groupArray = [[EMClient sharedClient].groupManager getAllGroups];
//                    for (EMGroup *group in groupArray) {
//                        if ([group.groupId isEqualToString:conversationChatter]) {
//                            chatViewController.title = group.subject;
//                            break;
//                        }
//                    }
//                }
//                    break;
//                default:
                    chatViewController.title = conversationChatter;
//               break;
//            }
            [self.navigationController pushViewController:chatViewController animated:NO];
         }
        }];
     }else if (_chatListVC){
        [self.navigationController pushViewController:_chatListVC animated:YES];
     }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"Tourism://"]]){
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"Tourism://"]];
//    }
    
    GlobalParams *arrryDes = [NSKeyedUnarchiver unarchiveObjectWithFile:ALLHDATA];
    if ([arrryDes.clearCacheFlag isEqualToString:@"1"]) {
        if ([[UIDevice currentDevice].systemVersion floatValue] < 9.0) {
            //
            //    但开发app必须要兼容所有iOS版本，可是iOS8，iOS7没有这种直接的方法，那该怎么办呢？
            //    （iOS7.0只有UIWebView， 而iOS8.0是有WKWebView， 但8.0的WKWebView没有删除缓存方法。）
            //    针对与iOS7.0、iOS8.0、iOS9.0 WebView的缓存，我们找到了一个通吃的办法:
            
            NSString *libraryDir = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,
                                                                       NSUserDomainMask, YES)[0];
            NSString *bundleId  =  [[[NSBundle mainBundle] infoDictionary]
                                    objectForKey:@"CFBundleIdentifier"];
            NSString *webkitFolderInLib = [NSString stringWithFormat:@"%@/WebKit",libraryDir];
            NSString *webKitFolderInCaches = [NSString
                                              stringWithFormat:@"%@/Caches/%@/WebKit",libraryDir,bundleId];
            
            
            NSError *error;
            /* iOS8.0 WebView Cache的存放路径 */
            [[NSFileManager defaultManager] removeItemAtPath:webKitFolderInCaches error:&error];
            [[NSFileManager defaultManager] removeItemAtPath:webkitFolderInLib error:nil];
        } else {
            NSSet *websiteDataTypes = [NSSet setWithArray:@[
                                                            WKWebsiteDataTypeDiskCache,
                                                            WKWebsiteDataTypeOfflineWebApplicationCache,
                                                            WKWebsiteDataTypeMemoryCache,
                                                            WKWebsiteDataTypeLocalStorage,
                                                            WKWebsiteDataTypeCookies,
                                                            WKWebsiteDataTypeSessionStorage,
                                                            WKWebsiteDataTypeIndexedDBDatabases,
                                                            WKWebsiteDataTypeWebSQLDatabases
                                                            ]];
            //你可以选择性的删除一些你需要删除的文件 or 也可以直接全部删除所有缓存的type
            //NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
            NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
            [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes
                                                       modifiedSince:dateFrom completionHandler:^{
                                                           // code
                                                       }];
        }
    }else{
        NSLog(@"sdf");
    }

    if ([[Ticket sharedInstance]judgeIsLOgin]) {
        [self setupUnreadMessageCount];
    }
    [MobClick beginLogPageView:NAMEMAIN];//("PageOne"为页面名称，可自定义)
}
//- (void)webViewDidFinishLoad:(UIWebView *)webView{
//    self.context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
//    TestJSObject *testJO = [TestJSObject sharedInstance];
//    self.context[@"HostApp"]=testJO;
//}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:NAMEMAIN];
}


//定位相关
- (void)LoadLocalCity{
//    XAlertView *alert = [[XAlertView alloc]initWithTitle:@"提示" message:@"无权限使用您的定位" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去打开", nil];
//    alert.isDisappear = YES;
//    [alert show];
//    return;
    if ([CLLocationManager locationServicesEnabled]) {
        self.manager.desiredAccuracy = kCLLocationAccuracyBest;
        self.manager.distanceFilter = 10;
        [self.manager requestWhenInUseAuthorization];
        [self.manager startUpdatingLocation];
    } else {
        XAlertView *alert = [[XAlertView alloc]initWithTitle:@"提示" message:@"无权限使用您的定位" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去打开", nil];
        alert.isDisappear = YES;
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        NSLog(@"%ld",(long)buttonIndex);
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
            
        }
    }
}
//4.通过相关的代理方法获取经纬度，进而转为城市名
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray* )locations
{
    CLLocation *loc = [locations firstObject];
    // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:loc completionHandler:^(NSArray *array, NSError *error)
     {
         if (array.count > 0)
         {
             CLPlacemark *placemark = [array objectAtIndex:0];
             //NSLog(@%@,placemark.name);//具体位置
             //获取城市
             NSString *city = placemark.locality;
             if (!city) {
                 //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                 city = placemark.administrativeArea;
             }
             //            [self loadWeather:city];
             self.LocalCity = city;
             NSLog(@"定位完成:%@",city);
             
         }else if (error == nil && [array count] == 0)
         {
             NSLog(@"No results were returned.");
         }else if (error != nil)
         {
             NSLog(@"An error occurred = %@", error);
         }
         //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
         [manager stopUpdatingLocation];
     }];
    
}
- (CLLocationManager *)manager{
    if (!_manager) {
        _manager = [[CLLocationManager alloc]init];
        _manager.delegate = self;
    }
    return _manager;
}
@end
