//
//  mainLeftView.m
//  jipiao
//
//  Created by Store on 16/10/20.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "mainLeftView.h"
#import "HeaderTotal.h"
#import "leftmainCell.h"
#import "leftmainHead.h"
#import "leftmainFoot.h"
#import "leftdataamain.h"
#import "myinfo.h"
#import "zejiMain.h"
#import "DefineCommon.h"
#import "ChatDemoHelper.h"
#import "myzhangdang.h"
#import "myinfoData.h"


#define height_head   120
#define height_foot   100
@interface mainLeftView ()<UITableViewDelegate,UITableViewDataSource,leftmainHeadDelegate>
@property (nonatomic,weak) UIImageView *icon;
@property (nonatomic,weak) UILabel *name;

@property (nonatomic,weak) UITableView *tableView;
@end

@implementation mainLeftView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.alpha = 0.95;
        
        self.backgroundColor = RGBColor(23, 36,52);

        UITableView *tableView = [[UITableView alloc]init];
        tableView.bounces  = NO;
        self.tableView = tableView;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.backgroundColor = RGBColor(23, 36,52);
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:tableView];
        
//        leftmainHead *head = [[leftmainHead alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 150*HEIGHTICON)];
//        tableView.tableHeaderView = head;
//        tableView.tableHeaderView.userInteractionEnabled = YES;
//        
//        leftmainFoot *foot = [[leftmainFoot alloc]initWithFrame:CGRectMake(0, 0,self.frame.size.width, 150*HEIGHTICON)];
//        tableView.tableFooterView = foot;
//        tableView.tableFooterView.userInteractionEnabled = YES;
        
        UIImageView *icon = [[UIImageView alloc]init];
        self.icon = icon;
        icon.userInteractionEnabled = YES;
        [self addSubview:icon];
        UITapGestureRecognizer *tapge = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(iconClick:)];
        [icon addGestureRecognizer:tapge];
        
        
        UILabel *name = [[UILabel alloc]init];
        name.userInteractionEnabled = YES;
        name.font = [UIFont systemFontOfSize:14];
        name.textColor = [UIColor whiteColor];
        self.name = name;
        UITapGestureRecognizer *tapge2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(iconClick:)];
        [name addGestureRecognizer:tapge2];
        [self addSubview:name];
        
        UIImageView *imngeBtn = [[UIImageView alloc]init];
        [self addSubview:imngeBtn];
        
        UIButton *btn = [[UIButton alloc]init];
        btn.backgroundColor = [UIColor clearColor];
        [btn addTarget:self action:@selector(btnLClick:)
      forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        leftmainHead *head = [[leftmainHead alloc]init];
        head.delegate = self;
        [self addSubview:head];
        
        leftmainFoot *foot = [[leftmainFoot alloc]init];
        [self addSubview:foot];
        
        
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.top.equalTo(head.mas_bottom);
            make.bottom.equalTo(foot.mas_top);
        }];
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(20*WIDTHICON);
            make.top.equalTo(self).offset(30*HEIGHTICON);
            make.width.equalTo(@30);
            make.height.equalTo(@30);
        }];
        icon.layer.cornerRadius = 30/2.0;
        icon.layer.masksToBounds = YES;
        
        [name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(icon.mas_right).offset(3);
            //        make.top.equalTo(icon);
            make.centerY.equalTo(icon);
            make.height.equalTo(@15);
        }];
        
        [imngeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(icon);
            make.right.equalTo(self).offset(-13*WIDTHICON);
            make.height.equalTo(@28);
            make.width.equalTo(@28);
        }];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(imngeBtn);
            make.centerX.equalTo(imngeBtn);
            make.height.equalTo(@44);
            make.width.equalTo(@44);
        }];
        [head mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.top.equalTo(self).offset(64);
            make.height.equalTo(@(height_head));
        }];
        [foot mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.top.equalTo(tableView.mas_bottom);
            make.bottom.equalTo(self);
            make.height.equalTo(@(height_foot));
        }];
        icon.layer.cornerRadius = 30/2.0;
        icon.layer.masksToBounds = YES;
        imngeBtn.image = [UIImage imageNamed:@"jt"];
        name.text = @"未登陆";
        icon.image = [UIImage imageNamed:@"img_head portrait"];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetname:)name:NAMEUploadSuccess object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetavator)name:AvatarUploadSuccess object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ZEJILogOutleftsuccessSelector)name:ZEJILogOutsuccess object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ZEJILoginsuccessSelectormainLeft)name:ZEJILoginsuccess object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setWeiduxiaoNUmselector:) name:ChangeTheBadgeZejiMain object:nil];
        UISwipeGestureRecognizer *lswip=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeCloseSelf)];
        lswip.direction=UISwipeGestureRecognizerDirectionLeft;
        [self addGestureRecognizer:lswip];
    }
    return self;
}
- (void)swipeCloseSelf{
    [[NSNotificationCenter defaultCenter]postNotificationName:Closetherightinterface object:nil];
}
- (void)btnLClick:(UIButton*)btn{
    [[NSNotificationCenter defaultCenter]postNotificationName:Returntothemaininterface object:nil];
}
- (void)returnGJorGNBtn:(AIRLINETICKETTYPE)num{
    if ([self.delegate respondsToSelector:@selector(returnGJorGNBtn:)]) {
        [self.delegate returnGJorGNBtn:num];
    }
}
- (void)ZEJILogOutleftsuccessSelector{
    if ([NSThread isMainThread]) {
        self.icon.image = [UIImage imageNamed:@"img_head portrait"];
        self.name.text = @"未登陆";
    }else{
        dispatch_sync(dispatch_get_main_queue(), ^(){
            self.icon.image = [UIImage imageNamed:@"img_head portrait"];
            self.name.text = @"未登陆";
        });
    }
    self.numWeidu = @"0";
    [self.tableView reloadData];
}
- (void)ZEJILoginsuccessSelectormainLeft{
    [self.icon sd_setImageWithURL:[NSURL URLWithString:[Ticket sharedInstance].userinfo.avatar] placeholderImage:[UIImage imageNamed:@"img_head portrait"]];
    self.name.text = [Ticket sharedInstance].userinfo.displayName;
}
- (void)resetname:(NSNotification *)user{
    NSDictionary *dic = user.userInfo;
    NSString *messge = dic[@"msg"];
    self.name.text = messge;
}
- (void)resetavator{
    [self.icon sd_setImageWithURL:[NSURL URLWithString:[Ticket sharedInstance].userinfo.avatar] placeholderImage:[UIImage imageNamed:@"img_head portrait"]];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < [self.arrryDes.menuArray count]) {
        leftdataamain *onedata = self.arrryDes.menuArray[indexPath.row];
        if ([onedata.must_login_flag isEqualToString:@"1"]) {
            if (![[Ticket sharedInstance]judgeIsLOgin]) {//没登录
                [self gotoloading];
                return;
            }
        }
        baseWebView *vc = [[baseWebView alloc]init];
        vc.title = onedata.menuName;
        vc.url = onedata.url;
//        vc.url = @"http://bbs.csdn.net/topics/391008067";
        vc.isRefeth = NO;
        [NaVc pushViewController:vc animated:YES];
    } else if(indexPath.row == [self.arrryDes.menuArray count]){
        myzhangdang *vc = [[myzhangdang alloc]init];
         [NaVc pushViewController:vc animated:YES];
    }
#ifdef DEBUGLONG
    else if(indexPath.row == [self.arrryDes.menuArray count]+3){
        baseWebView *vc = [[baseWebView alloc]init];
        vc.title = mylongOrderName;
        vc.url = mylongOrderUrl;
        vc.isRefeth = NO;
        [NaVc pushViewController:vc animated:YES];
    }
#endif
    else if(indexPath.row == [self.arrryDes.menuArray count]+2){
        if ([[Ticket sharedInstance]judgeIsLOgin]) {//已经登录
            myinfo *vc = [[myinfo alloc]init];
            [NaVc pushViewController:vc animated:YES];
        } else {//去注册
            [self gotoloading];
        }
    } else if(indexPath.row == [self.arrryDes.menuArray count]+1){
        if ([[Ticket sharedInstance]judgeIsLOgin]) {//已经登录
            if ([ChatDemoHelper shareHelper].conversationListVC) {
                [NaVc pushViewController:[ChatDemoHelper shareHelper].conversationListVC animated:YES];
            } else {
                ConversationListController *chatListVC = [[ConversationListController alloc]init];
                [ChatDemoHelper shareHelper].conversationListVC = chatListVC;
                [NaVc pushViewController:chatListVC animated:YES];
            }
        } else {//去注册
            [self gotoloading];
        }
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
#ifdef DEBUGLONG
    return [self.arrryDes.menuArray count] +4;
#else
    return [self.arrryDes.menuArray count] +3;
#endif
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (screenWidth == 375) {
    CGFloat heigg = (screenHeight-height_head-height_foot-64)/([self.arrryDes.menuArray count] +3);
    if (heigg < 25) {
        heigg = 25;
    }
    return heigg;
//        return (screenHeight-height_head-height_foot-64)/([self.arrryDes.menuArray count] +3);
//    }
    return 55*HEIGHTICON;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    leftmainCell *cell = [leftmainCell returnCellWith:tableView];
    if (indexPath.row == [self.arrryDes.menuArray count]) {
        cell.icon = @"icon_bill";
        cell.des = @"我的账单";
    }else if (indexPath.row == ([self.arrryDes.menuArray count]+2)) {
        cell.icon = @"icon_my message";
        cell.des = @"我的信息";
    }else if (indexPath.row == ([self.arrryDes.menuArray count]+1)) {
        cell.icon = @"WechatIMG17";
        cell.des = @"我的消息";
        cell.numWeidu = self.numWeidu;
    }
#ifdef DEBUGLONG
    else if (indexPath.row == ([self.arrryDes.menuArray count]+3)) {
        cell.icon = @"WechatIMG17";
        cell.des = mylongOrderName;
    }
#endif
    else {
        leftdataamain *leftdataamain = self.arrryDes.menuArray[indexPath.row];
        cell.icon = leftdataamain.menuLogo;
        cell.des = leftdataamain.menuName;
    }
    return  cell;
}
- (void)iconClick:(UITapGestureRecognizer *)reg{
    if ([[Ticket sharedInstance]judgeIsLOgin]) {//已经登录
        myinfo *Vc = [[myinfo alloc]init];
        [NaVc pushViewController:Vc animated:YES];
    } else {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"GoZeJiregisterNotificationCenter" object:nil];
    }
}
- (void)setNameStr:(NSString *)nameStr{
    _nameStr = nameStr;
    self.name.text = nameStr;
}
- (void)setIconStr:(NSString *)iconStr{
    [self.icon sd_setImageWithURL:[NSURL URLWithString:iconStr] placeholderImage:[UIImage imageNamed:@"img_head portrait"]];
}

#pragma 点击我的信息的时候，没有登录就去登录
- (void)gotoloading{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"GoZeJiregisterNotificationCenter" object:nil];
}
- (void)setArrryDes:(dicmenuArray *)arrryDes{
    _arrryDes = arrryDes;
    [self.tableView reloadData];
}

- (void)setWeiduxiaoNUmselector:(NSNotification *)user{
     NSDictionary *dic = user.userInfo;
     NSString *messge = dic[@"num"];
     self.numWeidu = messge;
     [self.tableView reloadData];
}
@end
