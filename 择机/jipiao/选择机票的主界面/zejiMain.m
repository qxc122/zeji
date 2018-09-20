//
//  ViewController.m
//  jipiao
//
//  Created by admin on 16/7/25.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "zejiMain.h"
#import "HeaderTotal.h"
#import "mainController.h"
#import "myinfo.h"
#import "rithtFlirhtdata.h"
#import "mainLeftView.h"
#import "mainRightView.h"
#import "imageAndBadge.h"
#import "MIBadgeButton.h"
#import "ReplicatorView.h"
#import "myinfoData.h"
#import "XAlertView.h"
#define zejiTitle  @"zejiTitle"

#define TITLE_ONE @"择机－腾邦国际"
#define TITLE_TWO @"航班查询"

typedef enum {
    VIEWTYPE_NONE,          //没有划出视图
    VIEWTYPE_LOADING,       //正在划出
    VIEWTYPE_LEFT,          //划出左边视图
    VIEWTYPE_RIGHT,         //划出右边视图
}VIEWTYPE; //枚举

#define widthsonVcLeft  screenWidth/4*3
#define widthsonVcRight  screenWidth/4*3
#define timeAnimationDuration  0.35

@interface zejiMain ()<WKNavigationDelegate,leftmainDelegate>

@property (nonatomic,weak) UIView *Mongolia;
@property (nonatomic,weak) mainLeftView *ViewLeft;
@property (nonatomic,weak) mainRightView *ViewRirht;
@property (nonatomic,assign) VIEWTYPE viewtype;
@property (nonatomic,strong) NSString *numUnread; //未读消息数

@property (nonatomic,weak) UILabel *mytitle;
@property (nonatomic,weak) MIBadgeButton *btnLeft;
@property (nonatomic,weak) UIButton *btnLeftReturn;
@property (nonatomic,weak) UIButton *btnRight;
@property (nonatomic,weak) UIView *titleView;

@property (nonatomic,strong) NSString *titleBack;
@end


@implementation zejiMain
- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;

    self.webView.backgroundColor = [UIColor clearColor];
    [self.webView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.top.equalTo(self.view).offset(64);
    }];
    
    self.viewtype = VIEWTYPE_NONE;

    [self CustomNavigationBar];   //自定义导航栏
    [self setNotificationCenter];

    if (self.isClose) {
        [self TwoControllersAreReleased];
    }
    self.loadingView.frame = CGRectMake(0,2,screenWidth, screenHeight-66);
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(Switchtoandfromthecity:)
                                                 name:RIRHTEXECUTIVEHOMEPAGE
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(needReLoadWeb)name:NOTIFINAME_RELOAD object:nil];

    UISwipeGestureRecognizer *lswip=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeLandR:)];
    lswip.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:lswip];
    
    UISwipeGestureRecognizer *rswip = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeLandR:)];
    rswip.direction=UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rswip];
    
    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
//    [self setUserScriptsWhenloginState];
}



- (void)needReLoadWeb{
    [self.webView reload];
}
- (void)TwoControllersAreReleased{
    NSMutableArray *navigationarray = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    for (NSInteger i = 0; i<navigationarray.count; i++) {
        UIViewController *conV = navigationarray[i];
        if ([conV isKindOfClass:[myinfo class]]) {
            [navigationarray removeObjectAtIndex:i];
            i = 0;
        }
    }
    self.navigationController.viewControllers = navigationarray;
}

- (void)setWeiduxiaoNUm{    //设置未读消息数目
    __weak typeof(self) weakself = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];
        NSInteger unreadCount = 0;
        for (EMConversation *conversation in conversations) {
            unreadCount += conversation.unreadMessagesCount;
        }
        dispatch_sync(dispatch_get_main_queue(), ^(){
            weakself.numUnread = [NSString stringWithFormat:@"%ld",(long)unreadCount];
            [weakself.btnLeft setBadgeString:[NSString stringWithFormat:@"%ld",(long)unreadCount]];
        });
    });
}

- (void)setWeiduxiaoNUmselector:(NSNotification *)user{
    NSDictionary *dic = user.userInfo;
    NSString *messge = dic[@"num"];
    self.numUnread = messge;
    [self.btnLeft setBadgeString:messge];
}

- (void)setNotificationCenter{
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(whenpaymentoccurs)
                                                 name:KNOTIFICATION_HomePage
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setWeiduxiaoNUmselector:) name:ChangeTheBadgeZejiMain
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Returntothemaininterfaceselector:) name:Returntothemaininterface object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Domesticairticketsselector:) name:Domesticairtickets object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Closetherightinterfaceselector:) name:Closetherightinterface object:nil];
   
}
- (void)whenpaymentoccurs{
    [self returnHomePage];
    [self btnLeftReturnReturn];
}
- (void)Closetherightinterfaceselector:(NSNotification *)user{
    if (self.viewtype == VIEWTYPE_LEFT) {
        [self closeVc:directionLeft];
    } else if (self.viewtype == VIEWTYPE_RIGHT) {
        [self closeVc:directionRight];
    }
}
- (void)Returntothemaininterfaceselector:(NSNotification *)user{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)returnGJorGNBtn:(AIRLINETICKETTYPE)num{
    BOOL isDomestic = FALSE;
    NSLog(@"asdfasdfasdfasdf");
    NSLog(@"num=%u DOMESTICAIRTICKETS=%d",num,DOMESTICAIRTICKETS);
    if (num == DOMESTICAIRTICKETS) {
        NSLog(@"1");
        isDomestic = YES;
    } else {
        NSLog(@"0");
        isDomestic = NO;
    }
    self.isDomestic = isDomestic;
    
//    [self setUserScriptsWhenloginState];
//    
//    if ([self.webView canGoBack]) {
//        [self returnHomePage];
//        NSLog(@"0sdf");
//    } else {
//        NSLog(@"0sdf");
//        [self.webView reload];
//    }
    
    [self setUserScripts];
    [self webViewreload];
    
    
    [self btnLeftReturnReturn];
    [self closeVc:directionLeft];
}

//- (void)Domesticairticketsselector:(NSNotification *)user{  
//    NSDictionary *tmp = user.userInfo;
//    BOOL isDomestic = [tmp[@"isDomestic"] boolValue];
//    self.isDomestic = isDomestic;
//    
//    [self setUserScriptsWhenloginState];
//    if ([self.webView canGoBack]) {
//        [self returnHomePage];
//    } else {
//        [self.webView reload];
//    }
//
//    [self btnLeftReturnReturn];
//    [self closeVc:directionLeft];
//}
- (void)CustomNavigationBar{
    
    UIView *titleView = [[UILabel alloc]init];
    titleView.userInteractionEnabled = YES;
    self.titleView =titleView;
    [self.view addSubview:titleView];
    
    
    UILabel *mytitle = [[UILabel alloc]init];
    mytitle.font = [UIFont systemFontOfSize:18];
    mytitle.textColor = [UIColor whiteColor];
    mytitle.textAlignment = NSTextAlignmentCenter;
    self.mytitle = mytitle;
    [self.titleView addSubview:mytitle];
    
    MIBadgeButton *badge = [MIBadgeButton buttonWithType:UIButtonTypeCustom];
//    badge.backgroundColor = [UIColor redColor];
    self.btnLeft = badge;
    [self.titleView addSubview:badge];
    [badge setFrame:CGRectMake(0, 0, 30, 30)];
    [badge setImage:[UIImage imageNamed:@"mainTwoleft"] forState:UIControlStateNormal];
    [badge setBadgeString:@"0"];
    [badge setBadgeTextColor:[UIColor whiteColor]];
    [badge setBadgeBackgroundColor:[UIColor redColor]];
    badge.hideWhenZero = YES;
    [badge setBadgeEdgeInsets:UIEdgeInsetsMake(15, -5, 0, 0)];
    [badge addTarget:self action:@selector(openOrCloseLeftView) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *btnLeftReturn = [[UIButton alloc]init];
    self.btnLeftReturn = btnLeftReturn;
    btnLeftReturn.hidden = YES;
    [self.titleView addSubview:btnLeftReturn];
    [btnLeftReturn setImage:[UIImage imageNamed:@"btnpre"] forState:UIControlStateNormal];
    [btnLeftReturn addTarget:self action:@selector(btnLeftReturnReturntouchIn) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btnright = [[UIButton alloc]init];
    self.btnRight = btnright;
    [self.titleView addSubview:btnright];
    [btnright setImage:[UIImage imageNamed:@"mainTworight"] forState:UIControlStateNormal];
    [btnright addTarget:self action:@selector(openOrCloseRightView) forControlEvents:UIControlEventTouchUpInside];
    
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.webView.mas_top);
    }];
    
    [mytitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleView);
        make.right.equalTo(self.titleView);
        make.top.equalTo(self.titleView).offset(20);
        make.bottom.equalTo(self.titleView);
    }];

    
    [badge mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleView).offset(5);
        make.centerY.equalTo(mytitle);
        make.height.equalTo(@40);
        make.width.equalTo(@40);
    }];
    [btnLeftReturn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(badge).offset(0);
        make.centerY.equalTo(badge);
        make.height.equalTo(badge);
        make.width.equalTo(badge);
    }];
    
    [btnright mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@40);
        make.width.equalTo(@40);
        make.right.equalTo(self.titleView).offset(-5);
        make.centerY.equalTo(mytitle);
    }];
}
- (void)openOrCloseLeftView{
    if (self.viewtype == VIEWTYPE_RIGHT) {
        [self closeVc:directionRight];
        [self openVc:directionLeft];
    } else if (self.viewtype == VIEWTYPE_LEFT){
        [self closeVc:directionLeft];
    } else if (self.viewtype == VIEWTYPE_NONE){
        [self openVc:directionLeft];
    }
}
- (void)openOrCloseRightView{
    if (self.viewtype == VIEWTYPE_LEFT) {
        [self closeVc:directionLeft];
        [self openVc:directionRight];
    } else if (self.viewtype == VIEWTYPE_RIGHT){
        [self closeVc:directionRight];
    } else if (self.viewtype == VIEWTYPE_NONE){
        [self openVc:directionRight];
    }
}
- (void)mongoliaSelector{
    if (self.viewtype == VIEWTYPE_RIGHT) {
        [self closeVc:directionRight];
    } else if (self.viewtype == VIEWTYPE_LEFT){
        [self closeVc:directionLeft];
    }
}
- (void)btnLeftReturnReturntouchIn{//点击返回按钮的时
//    [self btnLeftReturnReturn];
    [self returnHomePage];
}
- (void)returnHomePage{
    if ([self.webView canGoBack]) {
        [self.webView goBack];
        [self.loadingView removeFromSuperview];
        [MBProgressHUD hideHUDForView:self.webView];
    }

    if (self.viewtype == VIEWTYPE_LEFT) {
        [self closeVc:directionLeft];
    }
}
- (void)btnLeftReturnReturn{
//    self.mytitle.text = TITLE_ONE;
    self.btnLeftReturn.hidden = YES;
    self.btnLeft.hidden = NO;
    self.btnRight.hidden = NO;
}
- (UIView *)Mongolia{
    if (!_Mongolia) {
        UIView *Mongolia = [[UIView alloc]init];
        _Mongolia = Mongolia;
        Mongolia.hidden = YES;
        UITapGestureRecognizer *rep = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(mongoliaSelector)];
        [Mongolia addGestureRecognizer:rep];
        Mongolia.backgroundColor = RGBACOLOR(0, 0, 0, 0.5);
        [self.view addSubview:Mongolia];

        [Mongolia mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.webView);
            make.right.equalTo(self.webView);
            make.top.equalTo(self.webView);
            make.bottom.equalTo(self.webView);
        }];
    }
    return _Mongolia;
}
- (UIView *)ViewLeft{
    if (!_ViewLeft) {
        mainLeftView *tmp = [[mainLeftView alloc]init];
        tmp.delegate = self;
        [self.view addSubview:tmp];
        [tmp mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(-widthsonVcLeft);
            make.right.equalTo(self.view.mas_left).offset(0);
            make.top.equalTo(self.view).offset(0);
            make.bottom.equalTo(self.view).offset(0);
        }];
        tmp.hidden = YES;
        _ViewLeft = tmp;
        if ([[Ticket sharedInstance]judgeIsLOgin]) {    //如果是登录的
            tmp.nameStr = [Ticket sharedInstance].userinfo.displayName;
            tmp.iconStr = [Ticket sharedInstance].userinfo.avatar;
            tmp.numWeidu = self.numUnread;
        }
        
        dicmenuArray *data = [NSKeyedUnarchiver unarchiveObjectWithFile:LEFTDATA];
        tmp.arrryDes = data;
        if (!data) {
            __weak typeof(self) weakSelf = self;
            [[TWClient sharedInstance]queryMenusuccess:^(id dataDict, NSString *msg, NSInteger code) {
                dicmenuArray *data = [MTLJSONAdapter modelOfClass:[dicmenuArray class] fromJSONDictionary:dataDict error:nil];
                [NSKeyedArchiver archiveRootObject:data toFile:LEFTDATA];
                weakSelf.ViewLeft.arrryDes = data;
            } failure:^(NSInteger errorCode, NSString *msg) {
            }];
        }
    }
    return _ViewLeft;
}
- (mainRightView *)ViewRirht{
    if (!_ViewRirht) {
        mainRightView *tmp = [[mainRightView alloc]init];
        [self.view addSubview:tmp];
        [tmp mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_right).offset(0);
            make.right.equalTo(self.view.mas_right).offset(widthsonVcLeft);
            make.top.equalTo(self.view).offset(0);
            make.bottom.equalTo(self.view).offset(0);
        }];
        tmp.hidden = YES;
        _ViewRirht = tmp;
    }
    return _ViewRirht;
}
//划动手势
-(void)swipeLandR:(UIGestureRecognizer*)sender{

//        [self.webView evaluateJavaScript:@"window.webkit.messageHandlers.toast.postMessage({'name':'sdf','age':'80'})" completionHandler:^(id _Nullable, NSError * _Nullable error) {
//            
//        }];
    

    UISwipeGestureRecognizerDirection direction=[(UISwipeGestureRecognizer*) sender direction];
        //判断是上下左右
    switch (direction) {
      case UISwipeGestureRecognizerDirectionLeft:
            if (self.btnRight.hidden == NO) {
                [self showView:directionRight];
            }
         break;
       case UISwipeGestureRecognizerDirectionRight:
            if (self.btnLeft.hidden == NO) {
                [self showView:directionLeft];
            }
            
//            if (self.tmp.frame.origin.y >= 64) {
//            }
          break;
        default:
           break;
    }
}
//关闭左或右显示器
- (void)closeVc:(NSUInteger)num{
    self.viewtype = VIEWTYPE_NONE;
    [self.Mongolia removeFromSuperview];
    self.Mongolia = nil;
    [UIView animateWithDuration:timeAnimationDuration animations:^{
        if (num==directionLeft) {
            self.ViewLeft.transform = CGAffineTransformIdentity;
        } else {
            self.ViewRirht.transform = CGAffineTransformIdentity;
        }
        self.Mongolia.hidden = YES;
    } completion:^(BOOL finished) {
        if (num==directionLeft) {
            [self.ViewLeft removeFromSuperview];
            self.ViewLeft = nil;
        } else {
            [self.ViewRirht removeFromSuperview];
            self.ViewRirht = nil;
        }
    }];
}
//打开左或右显示器
- (void)openVc:(NSUInteger)num{
    self.Mongolia.hidden = NO;
    if (num==directionLeft) {
        self.viewtype = VIEWTYPE_LEFT;
        self.ViewLeft.hidden = NO;
    } else {
        self.viewtype = VIEWTYPE_RIGHT;
        self.ViewRirht.hidden = NO;
    }
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:timeAnimationDuration animations:^{
        weakSelf.Mongolia.hidden = NO;
        if (num==directionLeft) {
            weakSelf.ViewLeft.transform = CGAffineTransformMakeTranslation(widthsonVcLeft, 0);
        } else {
            weakSelf.ViewRirht.transform = CGAffineTransformMakeTranslation(-widthsonVcRight, 0);
        }
    }];
}

- (void)Switchtoandfromthecity:(NSNotification *)user{
    NSDictionary *dic = user.userInfo;
    NSString *tmp = [NSString dictionaryToJsonNoCokieForJs:dic];
    tmp = [NSString stringWithFormat:@"findFlights('%@')",tmp];
//    tmp = [tmp stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self closeVc:directionRight];
    [self.webView evaluateJavaScript:tmp completionHandler:nil];
}

- (void)showView:(NSUInteger)num{
    NSLog(@"showView");
    if (num == directionLeft) {
        if (self.viewtype == VIEWTYPE_RIGHT) {
            [self closeVc:directionRight];
        }else if(self.viewtype == VIEWTYPE_NONE){
            [self openVc:directionLeft];
        }
    } else if(num == directionRight){
        if (self.viewtype == VIEWTYPE_LEFT) {
            [self closeVc:directionLeft];
        }else if(self.viewtype == VIEWTYPE_NONE){
            [self openVc:directionRight];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.fd_interactivePopDisabled = YES;
    if ([[Ticket sharedInstance]judgeIsLOgin]) {
        [self setWeiduxiaoNUm];
    }
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.fd_interactivePopDisabled = NO;
}

- (void)dealloc{
    NSLog(@"%s",__func__);
    [self.webView removeObserver:self forKeyPath:@"title"];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

//// 页面开始加载时调用
//- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
//    NSLog(@"sdfsdfsdf");
//}
/**
 *  在收到响应后，决定是否跳转
 *
 *  @param webView            实现该代理的webview
 *  @param navigationResponse 当前navigation
 *  @param decisionHandler    是否跳转block
 */
//在接受到服务器的重定向请求之后调用
//-(void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
//    NSLog(@"didReceiveServerRedirectForProvisionalNavigation");
//    NSLog(@"didReceiveServerRedirectForProvisionalNavigation");
//    NSLog(@"didReceiveServerRedirectForProvisionalNavigation");
//
//
//}

//// 接收到服务器跳转请求之后再执行
//- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
//    NSLog(@"222");
//}
// 在收到响应后，决定是否跳转
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
//   NSLog(@"333"); 
//}


// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{  //checklist.html web/checklist.html
    NSString *tmp = navigationAction.request.URL.absoluteString;
    NSLog(@"tmp=%@",tmp);
//    if ([tmp hasSuffix:@"index.html"] || [tmp hasSuffix:@"index.html#/"] || [tmp hasSuffix:@"index.html#/home"] || [tmp hasSuffix:@"date.html"]) {  //mainUrl
////        self.mytitle.text = TITLE_TWO;
//        self.btnLeftReturn.hidden = YES;
//        self.btnLeft.hidden = NO;
//        self.btnRight.hidden = NO;
//    }else{
//        self.btnLeftReturn.hidden = NO;
//        self.btnLeft.hidden = YES;
//        self.btnRight.hidden = YES;
//    }

    
//    NSString *tmp1 = navigationAction.request.URL;
//    NSString *tmp = navigationAction.request.URL.path.lowercaseString;
    NSLog(@"sdfs===%@",tmp);
    NSLog(@"sdfsURL===%@",navigationAction.request.URL);

    if ([tmp rangeOfString:@"city"].location != NSNotFound) {
        [UIView animateWithDuration:0.5 animations:^{
            self.titleView.transform = CGAffineTransformMakeTranslation(0, -64);
            self.webView.frame = CGRectMake(0, 20, screenWidth, screenHeight-20);
        } completion:nil];
    } else {
        self.titleView.transform = CGAffineTransformIdentity;
        self.webView.frame = CGRectMake(0, 64, screenWidth, screenHeight-64);
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self.webView && [keyPath isEqualToString:@"title"] ) {
        // 这里就不写进度条了，把加载的进度打印出来，进度条可以自己加上去！
        //NSString *title = self.webView.title;
        self.mytitle.text = self.webView.title;
        NSLog(@"self.webView.title=%@",self.webView.title);
        if (self.webView.title && self.webView.title.length) {
            if (!self.titleBack || !self.titleBack.length) {
                self.titleBack = self.webView.title;
            }
            if ([self.webView.title isEqualToString:self.titleBack]) {
                self.btnLeftReturn.hidden = YES;
                self.btnLeft.hidden = NO;
                self.btnRight.hidden = NO;
            } else {
                self.btnLeftReturn.hidden = NO;
                self.btnLeft.hidden = YES;
                self.btnRight.hidden = YES;
            }
        }
        
        
//        NSString *tt = self.webView.title;
//        if (tt && tt.length && !self.webView.isLoading) {
//            if (![self.webView canGoBack]) {
//                self.btnLeftReturn.hidden = YES;
//                self.btnLeft.hidden = NO;
//                self.btnRight.hidden = NO;
//            } else {
//                self.btnLeftReturn.hidden = NO;
//                self.btnLeft.hidden = YES;
//                self.btnRight.hidden = YES;
//            }
//        }
//         存数据
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end

