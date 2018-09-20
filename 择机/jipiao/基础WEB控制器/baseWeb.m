//
//  baseWeb.m
//  jipiao
//
//  Created by Store on 16/10/28.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "baseWeb.h"
#import "Masonry.h"
#import "MJRefresh.h"
#import "DefineURL.h"
#import "baseWebView.h"
#import "Zhifugp.h"
#import "ReplicatorView.h"
#import "MHLoadContactController.h"
#import "TakeAndContact.h"

#define NOTIFINAME_baseWebView  @"NOTIFINAME_baseWebView"

@interface baseWeb ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>
@property (assign,nonatomic) BOOL IsFailedLoad; //是否加载失败的标志
@property (nonatomic,weak) UIImageView *errorImage;


@end

@implementation baseWeb
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.IsFailedLoad = NO;
        self.isRefeth = YES;
        self.isCloseRefeth = YES;
        self.showsVerticalScrolZE = YES;
        self.scrollViewbouncesZE = YES;
        self.LocalCity  =@"北京";
    }
    return self;
}
- (void)viewDidLoad{
    [super viewDidLoad];
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    [userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"toast"];
    [userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"homeContactCustomerService"];//首页联系客服(queryHint=航班信息)
    [userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"homeContactSecretary"];//(easemobId=秘书id,queryHint=航班信息)
    [userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"contactCustomerService"];//联系客服（不带参数
    [userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"contactCustomerServiceForInfo"];//联系客服（带票） jsonStr
    [userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"loginDialog"];//弹出登录框
    [userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"jumpCommonUrl"];//跳转页面(url=任何页面url)
    [userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"jumpCommonUrlH5"];//跳转页面(url=任何页面url)／／看协议用的
    [userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"jumpPayUrl"];//跳转到支付购票页面(url=支付页面url)
    [userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"jumpPayUrlFrontSetcookie"];//跳转到支付购票页面 跳转之前设置cookie
    [userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"tPay"];//T钱包支付(jsonData=订单信息)
    [userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"weixinPay"];//微信支付(jsonData=订单信息)
    [userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"paySuccess"];//支付成功回调
    [userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"callContacts"];//调用通讯录
    [userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"isShowLoading"];//加载框 isShow=是否显示
    [userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"isShowProgress"];//操作框 isShow=是否显
    [userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"finishPage"];//放回上一级页面
    [userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"contactForInfo"];//环信聊天
    [userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"shareWx"];//微信网页分享
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.userContentController = userContentController;
    
    
    UIView *BackWebView = [UIView new];
    [self.view addSubview:BackWebView];
    self.BackWebView = BackWebView;
    [BackWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    WKWebView *webView = [[WKWebView alloc]initWithFrame:CGRectZero configuration:config];
    //打开左划回退功能
//    webView.allowsBackForwardNavigationGestures =YES;
    [self.view addSubview:webView];
    self.webView = webView;
    webView.UIDelegate = self;
    webView.navigationDelegate = self;
    webView.scrollView.showsHorizontalScrollIndicator = NO;
    webView.scrollView.showsVerticalScrollIndicator = self.showsVerticalScrolZE;
    webView.scrollView.bounces = self.scrollViewbouncesZE;
    

    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    UIProgressView *pro1=[[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
    //设置的高度对进度条的高度没影响，整个高度=进度条的高度，进度条也是个圆角矩形
    //但slider滑动控件：设置的高度对slider也没影响，但整个高度=设置的高度，可以设置背景来检验
    [self.view addSubview:pro1];
    [pro1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.webView);
        make.right.equalTo(self.webView);
        make.top.equalTo(self.webView);
        make.height.equalTo(@2);
    }];
    self.pro1 = pro1;
    //设置进度条颜色
    pro1.trackTintColor = ColorBigBack;
    //设置进度默认值，这个相当于百分比，范围在0~1之间，不可以设置最大最小值
    pro1.progress=0.0;
    //设置进度条上进度的颜色
    pro1.progressTintColor=[UIColor redColor];
    
    [self setUserScripts];
    
    [webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setUserScriptsWhenloginState)name:NOTIFINAME_RESETCOOKIE object:nil];
    if (self.isRefeth) {
        [self example31];
    }else{
        [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        [self webViewreload];
    }
    if (@available(iOS 11.0, *)) {
        self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//UIScrollView也适用
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}
#pragma --mark<重写返回方法 可以返回就返回上一个网页，否则返回上一个页面>
- (void)popSelf
{
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)setUserScriptsWhenloginState{
    //js函数
    NSString *JSFuncString = @"function setCookieIOS(name,value,expires,urlpath)\
    {\
    var oDate=new Date();\
    oDate.setDate(oDate.getDate()+expires);\
    document.cookie=name+'='+value+';expires='+oDate+';path=/'\
    }";
    
    //拼凑js字符串
    NSString *tmp1 = [self getUserInformationStr];
    NSString *tmp2 = [self getMustInformationStr];
    NSMutableString *JSCookieString = JSFuncString.mutableCopy;
    //    for (NSHTTPCookie *cookie in cookieStorage.cookies) {
    NSString *excuteJSString1 = [NSString stringWithFormat:@"setCookieIOS('%@', '%@', 1);", @"userInfoIOS",tmp1];
    NSString *excuteJSString2 = [NSString stringWithFormat:@"setCookieIOS('%@', '%@', 1);", @"sessionContext",tmp2];
    NSString *excuteJSString3 = [NSString stringWithFormat:@"setCookieIOS('%@', '%@', 1);", @"sessionContextIOS",tmp2];

    [JSCookieString appendString:excuteJSString1];
    [JSCookieString appendString:excuteJSString2];
    [JSCookieString appendString:excuteJSString3];
    //    }
    //执行js
    [self.webView evaluateJavaScript:JSCookieString completionHandler:^(id data, NSError * _Nullable error) {
        if (error) {
            NSLog(@"失败:%@",error.description);
        } else {
            NSLog(@"成功");
        }
    }];
}




//- (void)setUserScriptsWhenloginState{
////    [self setUserScripts];
////    if (self.webView.isLoading) {
////        [self.webView stopLoading];
////        [self.webView reload];
////    }
////    return;
//    //js函数
//    NSString *JSFuncString =
//    @"function setCookieIOS(name,value,expires)\
//    {\
//    var oDate=new Date();\
//    oDate.setDate(oDate.getDate()+expires);\
//    document.cookie=name+'='+value+';expires='+oDate+';path=/'\
//    }\
//    function getCookieIOS(name)\
//    {\
//    var arr = document.cookie.match(new RegExp('(^| )'+name+'=([^;]*)(;|$)'));\
//    if(arr != null) return unescape(arr[2]); return null;\
//    }\
//    function delCookieIOS(name)\
//    {\
//    var exp = new Date();\
//    exp.setTime(exp.getTime() - 1);\
//    var cval=getCookieIOS(name);\
//    if(cval!=null) document.cookie= name + '='+cval+';expires='+exp.toGMTString();\
//    }";
//
//    //拼凑js字符串
//    NSString *tmp1 = [self getUserInformationStr];
//    NSString *tmp2 = [self getMustInformationStr];
//    NSMutableString *JSCookieString = JSFuncString.mutableCopy;
//    NSString *excuteJSStringDE1 = [NSString stringWithFormat:@"delCookieIOS('userInfoIOS');"];
//    NSString *excuteJSStringDE2 = [NSString stringWithFormat:@"delCookieIOS('sessionContext');"];
//    NSString *excuteJSStringDE3 = [NSString stringWithFormat:@"delCookieIOS('sessionContextIOS');"];
////    for (NSHTTPCookie *cookie in cookieStorage.cookies) {
//        NSString *excuteJSString1 = [NSString stringWithFormat:@"setCookieIOS('%@', '%@', 1);", @"userInfoIOS",tmp1];
//    NSString *excuteJSString2 = [NSString stringWithFormat:@"setCookieIOS('%@', '%@', 1);", @"sessionContext",tmp2];
//    NSString *excuteJSString3 = [NSString stringWithFormat:@"setCookieIOS('%@', '%@', 1);", @"sessionContextIOS",tmp2];
//    [JSCookieString appendString:excuteJSStringDE1];
//    [JSCookieString appendString:excuteJSStringDE2];
//    [JSCookieString appendString:excuteJSStringDE3];
//
//    [JSCookieString appendString:excuteJSString1];
//    [JSCookieString appendString:excuteJSString2];
//    [JSCookieString appendString:excuteJSString3];
////    }
//    //执行js
//    [self.webView evaluateJavaScript:JSCookieString completionHandler:^(id data, NSError * _Nullable error) {
//        if (error) {
//            NSLog(@"失败:%@",error.description);
//        } else {
//            NSLog(@"成功");
//        }
//    }];
//}
- (void)setUserScripts{
    NSString *tmp1 = [self getUserInformationStr];
    NSString *tmp2 = [self getMustInformationStr];
    NSString *cookieStr = [NSString stringWithFormat:@"document.cookie = 'userInfoIOS=%@';document.cookie = 'sessionContext=%@';document.cookie = 'AppVersionIOS=%@';document.cookie = 'sessionContextIOS=%@'",tmp1,tmp2,app_build,tmp2];
     if (self.CookieDic) {
         NSArray *arrykeyname = [self.CookieDic allKeys];
         NSArray *arryvalue = [self.CookieDic allValues];
         NSUInteger tmp = 0;
         for (NSString *name in arrykeyname) {
             cookieStr = [cookieStr stringByAppendingString:[NSString stringWithFormat:@";document.cookie = '%@=%@'",name,arryvalue[tmp]]];
             tmp++;
        }
     }
    
    WKUserScript * cookieScript = [[WKUserScript alloc]
                                   initWithSource:cookieStr
                                   injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
    // again, use stringWithFormat: in the above line to inject your values programmatically
    WKUserContentController *tmpuserContentController = self.webView.configuration.userContentController;
    [tmpuserContentController addUserScript:cookieScript];
}
- (NSString *)getUserInformationStr{
    userInfo *data = [Ticket sharedInstance].userinfo;
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    if (data.displayName) {
        [parameters setValue:data.displayName forKey:@"displayName"];
    }
    if (data.authenTicket) {
        [parameters setValue:data.authenTicket forKey:@"authenTicket"];
    }
    if (data.authenUserId) {
        [parameters setValue:data.authenUserId forKey:@"authenUserId"];
    }
    if (data.loginTime) {
        [parameters setValue:data.loginTime forKey:@"loginTime"];
    }
    if (data.avatar) {
        [parameters setValue:data.avatar forKey:@"avatar"];
    }
    if (data.easemobId) {
        [parameters setValue:data.easemobId forKey:@"easemobId"];
    }
    if (data.phone) {
        [parameters setValue:data.phone forKey:@"phone"];
    }
    return [NSString dictionaryToJsonForJs:parameters];
}
- (NSString *)getMustInformationStr{
    NSMutableDictionary *parameters2 = [[NSMutableDictionary alloc]init];
    if ([Ticket sharedInstance].userinfo.authenUserId) {
        [parameters2 setValue:[Ticket sharedInstance].userinfo.authenUserId forKey:@"userId"];
    }else{
        [parameters2 setValue:@"" forKey:@"userId"];
    }
    if ([Ticket sharedInstance].accessTokeninfo.accessToken) {
        [parameters2 setValue:[Ticket sharedInstance].accessTokeninfo.accessToken forKey:@"accessToken"];
    }else{
        [parameters2 setValue:@"" forKey:@"accessToken"];
    }
    [parameters2 setValue:ZJCHANNEL forKey:@"channel"];
    [parameters2 setValue:ZJserviceCode forKey:@"serviceCode"];
    [parameters2 setValue:[NSString returntimestamp] forKey:@"localDateTime"];
    [parameters2 setValue:ZJuserReferenceNo forKey:@"externalReferenceNo"];
    [parameters2 setValue:ZJexternalReferenceNo forKey:@"userReferenceNo"];
    [parameters2 setValue:ZJstepCode forKey:@"stepCode"];
    
    [parameters2 setValue:ZJaccessSource forKey:@"accessSource"];
    [parameters2 setValue:ZJaccessSourceType forKey:@"accessSourceType"];
    [parameters2 setValue:ZJversion forKey:@"version"];
    [parameters2 setValue:self.isDomestic?@"1":@"0" forKey:@"isDomestic"];
    [parameters2 setValue:self.LocalCity forKey:@"LocalCity"];
    
    return [NSString dictionaryToJsonForJs:parameters2];
}

- (void)example31
{
    //    __unsafe_unretained UIWebView *webView = self.webView;
    __unsafe_unretained __typeof(self) weakSelf = self;
    // 添加下拉刷新控件
    self.webView.scrollView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf webViewreload];
    }];
    [self.webView.scrollView.mj_header beginRefreshing];
}
- (void)AfterTheWebViewloadedToDo{
    if (self.webView.scrollView.mj_header.isRefreshing) {
        [self.webView.scrollView.mj_header endRefreshing];
    }
    if (self.isCloseRefeth) {
        self.webView.scrollView.mj_header.hidden = YES;
    } else {
        self.webView.scrollView.mj_header.hidden = NO;
    }
}
- (void)dealloc{
    [self.webView removeObserver:self forKeyPath:@"title"];
    if (!self.isRefeth) {
        [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    }
    NSLog(@"%s",__func__);
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if (object == self.webView && [keyPath isEqualToString:@"estimatedProgress"] ) {
        // 这里就不写进度条了，把加载的进度打印出来，进度条可以自己加上去！
        CGFloat newProgress = [[change objectForKey:NSKeyValueChangeNewKey] floatValue];
        NSLog(@"%f",newProgress);
        [self.pro1 setAlpha:1.0f];
        [self.pro1 setProgress:newProgress animated:YES];
        if (newProgress >= 1.0f) {
            [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.pro1 setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [self.pro1 setProgress:0.0f animated:NO];
            }];
        }
    } else if (object == self.webView && [keyPath isEqualToString:@"title"] ) {
        // 这里就不写进度条了，把加载的进度打印出来，进度条可以自己加上去！
        //NSString *title = self.webView.title;
        if ([self.webView.title rangeOfString:@"."].location == NSNotFound && self.webView.title.length) {
            self.title = self.webView.title;
        }
    }else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation { // 类似UIWebView的 -webViewDidStartLoad:
    if (self.IsFailedLoad) {
        self.errorImage.hidden = YES;
        [self.errorImage removeFromSuperview];
    }
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    self.pro1.alpha = 0;
    if (![self.webView canGoBack]) {
        self.errorImage.hidden = NO;
        self.IsFailedLoad = YES;
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    if (self.isRefeth) {
        [self AfterTheWebViewloadedToDo];
    }
    self.pro1.alpha = 0;
    
    
//    WKWebsiteDataStore *dataStore = [WKWebsiteDataStore defaultDataStore];
//    [dataStore fetchDataRecordsOfTypes:[WKWebsiteDataStore allWebsiteDataTypes]
//                     completionHandler:^(NSArray<WKWebsiteDataRecord *> * __nonnull records) {
//                         for (WKWebsiteDataRecord *record  in records)
//                         {
//                             NSString *tmp = record.dataTypes;
//                             NSLog(@"WKWebsiteDataRecord:%@",record.dataTypes);
//                             NSLog(@"WKWebsiteDataRecord:%@",record.dataTypes);
//                         }
//                     }];
    
    
}
#pragma mark - WKNavigationDelegate 页面跳转
#pragma mark 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSLog(@"sdfs===%@",navigationAction.request.URL.path.lowercaseString);
    NSLog(@"sdfs===%@",navigationAction.request.URL.path.lowercaseString);

    decisionHandler(WKNavigationActionPolicyAllow);
}

#pragma mark 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    NSHTTPURLResponse *response = (NSHTTPURLResponse *)navigationResponse.response;
    NSArray *cookies =[NSHTTPCookie cookiesWithResponseHeaderFields:[response allHeaderFields] forURL:response.URL];
    //读取wkwebview中的cookie
    for (NSHTTPCookie *cookie in cookies) {
        // 这里就是你需要的cookie
        NSLog(@"cookie=%@",cookie);
//        NSLog(@"cookie=%@",cookie);
    }
    decisionHandler(WKNavigationResponsePolicyAllow);
}


- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler

{    // js 里面的alert实现，如果不实现，网页的alert函数无效
    //    [MBProgressHUD showError:message toView:self.view];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message
                                          
                                                                             message:nil
                                          
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定"
                                
                                                        style:UIAlertActionStyleCancel
                                
                                                      handler:^(UIAlertAction *action) {
                                                          
                                                          completionHandler();
                                                          
                                                      }]];
    
    [self presentViewController:alertController animated:YES completion:^{
        
    }];
    
}
//  js 里面的alert实现，如果不实现，网页的alert函数无效
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler {
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message
                                          
                                                                             message:nil
                                          
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定"
                                
                                                        style:UIAlertActionStyleDefault
                                
                                                      handler:^(UIAlertAction *action) {
                                                          
                                                          completionHandler(YES);
                                                          
                                                      }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消"
                                
                                                        style:UIAlertActionStyleCancel
                                
                                                      handler:^(UIAlertAction *action){
                                                          
                                                          completionHandler(NO);
                                                          
                                                      }]];
    
    [self presentViewController:alertController animated:YES completion:^{}];
}

- (void)setUrl:(NSString *)url{
    if (url) {
        if (![url hasPrefix:@"http"]) {
            if (![url hasPrefix:@"/"]) {
                url = [@"/" stringByAppendingString:url];
            }
            url = [kURLAPIBase stringByAppendingString:url];
        }
        url = [url stringByReplacingOccurrencesOfString:@" " withString:@""];
//        url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        _url = url;
    }
}
- (void)webViewreload{
    if ([self.webView isLoading]) {
        [self.webView stopLoading];
    }
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.url] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:[NSDate date]. timeIntervalSince1970];
    [request addValue:@"TeskCookieKey1=TeskCookieValue1;TeskCookieKey2=TeskCookieValue2;" forHTTPHeaderField:@"Cookie"];
    
//
//     [request addValue:@"customCookieName=1314521" forHTTPHeaderField:@"Cookie"];

//    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://h5.qzone.qq.com/mqzone/index"]];
//    [request setHTTPShouldHandleCookies:YES];
//    BOOL tmp = request.HTTPShouldHandleCookies;
//    
//    [request addValue:@"skey=skeyValue" forHTTPHeaderField:@"Cookie"];
    [self.webView loadRequest:request];
   // [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}
- (UIImageView *)errorImage{
    if (!_errorImage) {
        UIImageView *errorImage =[[UIImageView alloc]init];
        [self.webView addSubview:errorImage];
        errorImage.image = [UIImage imageNamed:@"404c"];
        errorImage.hidden = YES;
        errorImage.userInteractionEnabled = YES;
        _errorImage = errorImage;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(webViewreload)];
        [errorImage addGestureRecognizer:tap];
        [errorImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.webView);
            make.right.equalTo(self.webView);
            make.top.equalTo(self.webView);
            make.bottom.equalTo(self.webView);
        }];
    }
    return _errorImage;
}


- (ReplicatorView *)loadingView{
    if (!_loadingView) {
        //待加上 TODO
//        ReplicatorView *tmp = [[ReplicatorView alloc]initWithFrame:CGRectMake(0,0,screenWidth, screenHeight-64)];
//        
//        [self.webView addSubview:tmp];
//        self.loadingView = tmp;
//        tmp.hidden = YES;
    }
    return _loadingView;
}
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    //接受传过来的消息从而决定app调用的方法
    NSDictionary *dict = message.body;
    NSString *method = message.name;
    if ([method isEqualToString:@"toast"]) {
        NSString *tmp;
        if ([dict isKindOfClass:[NSString class]]) {
            tmp = (NSString *)dict;
          //  UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:tmp delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
         //   alert.tag = 1011;
         //   [alert show];
         
        if ([tmp rangeOfString:@"成功"].location != NSNotFound) {
                [MBProgressHUD showSuccess:tmp];
            } else {
                if ([tmp rangeOfString:@"null"].location == NSNotFound) {
                    [MBProgressHUD showError:tmp];
                }
            }
        }
    }else if ([method isEqualToString:@"homeContactCustomerService"]){
        NSString *tmp;
        if ([dict isKindOfClass:[NSString class]]) {
            tmp = (NSString *)dict;
            [self homeContactCustomerServiceMethod:tmp];
        }
    }else if ([method isEqualToString:@"homeContactSecretary"]){
        [self homeContactSecretaryMethod:dict];
    }else if ([method isEqualToString:@"contactCustomerService"]){
        [self contactCustomerServiceMethod:nil];
    }else if ([method isEqualToString:@"contactCustomerServiceForInfo"]){
        [self contactCustomerServiceForInfoMethod:dict];
    }else if ([method isEqualToString:@"loginDialog"]){
        [self loginDialogMethod:nil];
    }else if ([method isEqualToString:@"jumpCommonUrl"]){
        [self jumpCommonUrlMethod:dict];
    }else if ([method isEqualToString:@"jumpCommonUrlH5"]){
        [self jumpCommonUrlH5Method:dict];
    }else if ([method isEqualToString:@"jumpPayUrl"]){
        NSString *tmp;
        if ([dict isKindOfClass:[NSString class]]) {
            tmp = (NSString *)dict;
            [self jumpPayUrlMethod:tmp];
        }
    }else if ([method isEqualToString:@"jumpPayUrlFrontSetcookie"]){
        self.CookieDic = dict;
    }else if ([method isEqualToString:@"tPay"]){
        [self tPayMethod:dict];
    }else if ([method isEqualToString:@"weixinPay"]){
        [self weixinPayMethod:dict];
    }else if ([method isEqualToString:@"paySuccess"]){
        [self paySuccessMethod:nil];
    }else if ([method isEqualToString:@"callContacts"]){
        [self callContactsMethod:nil];
    }else if ([method isEqualToString:@"isShowLoading"]){
        
        NSString *tmp = dict[@"isShow"];
        if ([tmp boolValue]) {
            self.loadingView.hidden = NO;
        } else {
            self.loadingView.hidden = YES;
            [self.loadingView removeFromSuperview];
        }
    }else if ([method isEqualToString:@"isShowProgress"]){
        NSString *isShow = dict[@"isShow"];
        //    BOOL isCancelable = dict[@"isCancelable"];
        NSString *msg = dict[@"msg"];
        if (!msg || msg.length==0) {
            msg = @"数据加载中";
        }
        if (![msg hasSuffix:@"..."]) {
            msg = [msg stringByAppendingString:@"..."];
        }
        if ([isShow boolValue]) {
            [MBProgressHUD showMessage:msg toView:self.webView];
        } else {
            [MBProgressHUD hideHUDForView:self.webView];
        }
    }else if ([method isEqualToString:@"finishPage"]){
        [self popSelf];
        [[NSNotificationCenter defaultCenter]postNotificationName:NOTIFINAME_RELOAD object:nil];
    }else if ([method isEqualToString:@"contactForInfo"]){  //环信聊天
        if ([[Ticket sharedInstance]judgeIsLOgin]) {
            NSString *easemobId = dict[@"easemobId"];
            if (easemobId && easemobId.length) {
                ChatViewController *chatController = [[ChatViewController alloc]
                                                      initWithConversationChatter:easemobId conversationType:EMConversationTypeChat];
                chatController.title = dict[@"userNick"];
                NSDictionary *dicTmp = @{
                                         H5MSGMAINjsonSt:dict[@"jsonStr"],
                                         };
                chatController.info = dicTmp;

                [self.navigationController pushViewController:chatController animated:YES];
            }else{
                [MBProgressHUD showError:@"无效的联系ID" toView:self.view];
            }
        }else{
            [[NSNotificationCenter defaultCenter]postNotificationName:@"GoZeJiregisterNotificationCenter" object:nil];
        }
    }else if ([method isEqualToString:@"shareWx"]){
        [WXApi registerApp:WechatAppIDOther];
        [[TWWechatPayManager sharedInstance]shareTOWXsceneWithinfo:dict];
    }
}



- (void)homeContactCustomerServiceMethod:(NSString *)dic{   //首页联系客服
    NSDictionary *dicTmp = @{
                          H5MSGMAINqueryHint:dic,
                          };
    [self openChatViewControllerWithTiele:@"在线客服" and:dicTmp and:nil];
}
- (void)homeContactSecretaryMethod:(NSDictionary *)dic{
    NSString *easemobId = dic[@"easemobId"];
    NSString *nick = dic[@"nick"];
    NSString *queryHint = dic[@"queryHint"];
    NSDictionary *dictTmp = @{
                              H5MSGMAINeasemoqueryHint:queryHint,
                              };
    NSDictionary *dicData = @{
                          H5MSGMAINeasemo:dictTmp,
                          };
    [self openChatViewControllerWithTiele:nick and:dicData and:easemobId];
}
- (void)contactCustomerServiceMethod:(NSString *)dic{   //联系客服，无参数
    [self openChatViewControllerWithTiele:@"在线客服" and:nil and:nil];
}
- (void)contactCustomerServiceForInfoMethod:(NSDictionary *)dic{
    NSString *jsonStr = [NSString dictionaryToJson:dic];
    NSDictionary *dicTmp = @{
                          H5MSGMAINjsonSt:jsonStr,
                          };
    [self openChatViewControllerWithTiele:@"在线客服" and:dicTmp and:nil];
}
- (void)loginDialogMethod:(NSString *)dic{
    [self GoZeJiregister];
}
- (void)jumpCommonUrlMethod:(NSDictionary *)dic{
    NSString *url = dic[@"url"];
    NSString *title = dic[@"title"];
    
    baseWebView *bill = [[baseWebView alloc]init];
    if (self.CookieDic) {
        bill.CookieDic = self.CookieDic;
        self.CookieDic = nil;
    }
    bill.url = url;
    bill.isRefeth = NO;
    bill.title = title;
    [self.navigationController pushViewController:bill animated:YES];
}
- (void)jumpCommonUrlH5Method:(NSDictionary *)dic{
    NSString *url = dic[@"url"];
    NSString *title = dic[@"title"];
    
    baseWeb *bill = [[baseWeb alloc]init];
    bill.url = url;
    bill.isRefeth = NO;
    bill.title = title;
    [self.navigationController pushViewController:bill animated:YES];
}
- (void)jumpPayUrlMethod:(NSString *)dic{
    Zhifugp *bill = [[Zhifugp alloc]init];
    if (self.CookieDic) {
        bill.CookieDic = self.CookieDic;
        self.CookieDic = nil;
    }
    bill.url = dic;
    [self.navigationController pushViewController:bill animated:YES];
}

- (void)tPayMethod:(NSDictionary *)dic{
    NSDictionary *datajsonData = dic;
    NSString *TUlr = @"testwalletTbi://";
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"ThirdPartyPay://"]]){
        NSNumber *numAmt = datajsonData[@"tranAmt"];
        NSString *supportTcoinstr = @"";
        if (datajsonData[@"supportTcoin"]) {
            supportTcoinstr = datajsonData[@"supportTcoin"];
        }
        NSDictionary *data = @{
                               @"businessID":datajsonData[@"prepayId"],
                               @"businessName":datajsonData[@"orderDesc"], //  orderDesc
                               @"money":[NSString stringWithFormat:@"%@",numAmt],
                               @"supportTcoin":supportTcoinstr,
                               @"WhoCalls":@"zeji",
                               
                               };

        NSString *url = [NSString stringWithFormat:@"ThirdPartyPay://%@",[data ToUrl]];
        NSString *urlStringUTF8 = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStringUTF8]];
        
    }else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:TUlr]]){
        
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        NSNumber *numAmt = datajsonData[@"tranAmt"];
        NSString *supportTcoinstr = @"";
        if (datajsonData[@"supportTcoin"]) {
            supportTcoinstr = datajsonData[@"supportTcoin"];
        }
        NSDictionary *data = @{
                               @"businessID":datajsonData[@"prepayId"],
                               @"businessName":datajsonData[@"orderDesc"], //  orderDesc
                               @"money":[NSString stringWithFormat:@"%@",numAmt],
                               @"supportTcoin":supportTcoinstr,
                               @"WhoCalls":@"zeji",
                               };
        [pasteboard setData:[NSDictionary returnDataWithDictionary:data] forPasteboardType:@"data"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:TUlr]];
    }else{
        if (![NSThread isMainThread]) {
            dispatch_sync(dispatch_get_main_queue(), ^(){
                if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"testwallet://"]]){
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"您当前的T钱包版本不支持该操作" message:@"去升级" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                    alert.tag = 1011;
                    [alert show];
                }else{
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"您还没有安装T钱包客户端哦" message:@"去安装" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                    alert.tag = 1011;
                    [alert show];
                }
            });
        }else{
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"testwallet://"]]){
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"您当前的T钱包版本不支持该操作" message:@"去升级" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                alert.tag = 1011;
                [alert show];
            }else{
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"您还没有安装T钱包客户端哦" message:@"去安装" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                alert.tag = 1011;
                [alert show];
            }
        }
    }
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
- (void)weixinPayMethod:(NSDictionary *)dic{
    if(![WXApi isWXAppInstalled]) {
        if (![NSThread isMainThread]) {
            dispatch_sync(dispatch_get_main_queue(), ^(){
                [MBProgressHUD showError:@"您还没有安装微信客户端哦"];
            });
        }else{
            [MBProgressHUD showError:@"您还没有安装微信客户端哦"];
        }
    }else{
        NSDictionary *datajsonData = dic;
        NSNumber *numAmt = datajsonData[@"tranAmt"];
        CGFloat price = [numAmt doubleValue];
//        [WXApi registerApp:WechatAppID];
        [WXApi registerApp:datajsonData[@"appId"]];
        [TWWechatPayManager sharedInstance].payType = wechatTYZF;
        [TWWechatPayManager sharedInstance].orderPirce = [NSString stringWithFormat:@"%.2f",price];
        [[TWWechatPayManager sharedInstance] wechatpayWithPrepayInfo:datajsonData];
    }
}
- (void)paySuccessMethod:(NSDictionary *)dic{
    payOk *vc = [[payOk alloc]init];
    [NaVc pushViewController:vc animated:YES];
}
- (void)callContactsMethod:(NSDictionary *)dic{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(returnMyContacts:)
                                                 name:NOTIFINAME_baseWebView
                                               object:nil];
    MHLoadContactController *vc = [[MHLoadContactController alloc]init];
    vc.NotificationName = NOTIFINAME_baseWebView;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)returnMyContacts:(NSNotification *)user{
    NSDictionary *dic = user.userInfo;
    NSString *name = dic[@"name"];
    NSString *tel = dic[@"tel"];
    
    [self.navigationController popToViewController:self animated:YES];
    [self.webView  evaluateJavaScript:[NSString stringWithFormat:@"contactsResult('%@','%@')",name,tel] completionHandler:^(id tt, NSError * _Nullable error) {
        if (error) {
            NSLog(@"NO");
        } else {
            NSLog(@"YES");
        }
    }];
    
//    [self.webView evaluateJavaScript:[NSString stringWithFormat:@"contactsResult('%@','%@')",name,tel] completionHandler:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFINAME_baseWebView object:nil];
}

- (void)openChatViewControllerWithTiele:(NSString *)title and:(NSDictionary *)dic and:(NSString *)emsoid{
    if ([[Ticket sharedInstance]judgeIsLOgin]) {
        if (!emsoid) {
            emsoid = HXkefuID;
//            emsoid = @"per00006074";    //17004965055
//            emsoid = @"per00032021"; //18888
        }
        ChatViewController *chatController = [[ChatViewController alloc]
                                              initWithConversationChatter:emsoid conversationType:EMConversationTypeChat];
        chatController.title = title;
        chatController.info = dic;
        NSLog(@"main=%@",[NSThread currentThread]);
        if ([NSThread isMainThread]) {
            [self openNewVc:chatController animated:YES];
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self openNewVc:chatController animated:YES];
            });
        }
    } else {
        if ([NSThread isMainThread]) {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"GoZeJiregisterNotificationCenter" object:nil];
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter]postNotificationName:@"GoZeJiregisterNotificationCenter" object:nil];
            });
        }
    }
}
- (void)openNewVc:(UIViewController *)Vc animated:(BOOL)animated{
    UINavigationController *NaVctmp = NaVc;
    if ([NaVctmp.topViewController isKindOfClass:[ChatViewController class]] && [Vc isKindOfClass:[ChatViewController class]]) {
        
    }else{
        [NaVc pushViewController:Vc animated:animated];
    }
}
@end


@implementation WeakScriptMessageDelegate

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate
{
    self = [super init];
    if (self) {
        _scriptDelegate = scriptDelegate;
    }
    return self;
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    [self.scriptDelegate userContentController:userContentController didReceiveScriptMessage:message];
}
@end
