//
//  baseWeb.h
//  jipiao
//
//  Created by Store on 16/10/28.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "baseVc.h"
#import <WebKit/WKFoundation.h>
#import <WebKit/WebKit.h>
#import "ReplicatorView.h"

@interface baseWeb : baseVc

@property (nonatomic,assign) BOOL isDomestic;
@property (nonatomic,strong) NSString *LocalCity;
@property (nonatomic,weak) ReplicatorView *loadingView;
@property (weak,nonatomic) UIProgressView *pro1;
@property (nonatomic,weak) WKWebView *webView;
@property (nonatomic,weak) UIView *BackWebView;
@property (nonatomic,strong) NSString *url;
@property (nonatomic,assign) BOOL isRefeth; //是否MJ
@property (nonatomic,assign) BOOL isCloseRefeth; //加载完是否关闭MJ 默认关闭

@property (nonatomic,assign) BOOL showsVerticalScrolZE; //是否showsVerticalScrollIndicator
@property (nonatomic,assign) BOOL scrollViewbouncesZE; //是否bounces
- (void)webViewreload;
@property (nonatomic,strong) NSDictionary *CookieDic;  //暂时储存用，取完设置为空
- (void)setUserScriptsWhenloginState;
- (void)setUserScripts;
@end

@interface WeakScriptMessageDelegate : NSObject<WKScriptMessageHandler>

@property (nonatomic, weak) id<WKScriptMessageHandler> scriptDelegate;

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate;
@end
