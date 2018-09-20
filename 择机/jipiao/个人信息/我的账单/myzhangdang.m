//
//  myzhangdang.m
//  jipiao
//
//  Created by Store on 16/9/2.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "myzhangdang.h"
#import "HeaderTotal.h"
#import "billTwoCell.h"
#import "billOneCell.h"
#import "huankuangBtn.h"
#import "TakeAndContact.h"

@interface myzhangdang ()<UITableViewDelegate,UITableViewDataSource,billTwoCellLJHKDelegate,huankuangBtnDelegate,UIAlertViewDelegate>
@property (weak, nonatomic)  UITableView *tableview;
@property (strong, nonatomic)  xinyongdata *xinyongdataclient;
@property (strong, nonatomic)  billListdata *billListdataclient;
@property (assign, nonatomic)  BOOL openOrClose;
@property (nonatomic,weak) huankuangBtn *logoandregist;
//@property (nonatomic,weak) UIVisualEffectView *Woolglass;
@property (nonatomic,weak) billTwoCell *twoCell;

@property (nonatomic,weak) UIImageView *image1;
@property (nonatomic,weak) UIImageView *image2;
@property (nonatomic,weak) UILabel *nomsg;
@end

@implementation myzhangdang

- (void)viewDidLoad {
    [super viewDidLoad];
    self.openOrClose = NO;
    self.title = @"我的账单";
    billTwoCell *twoCell = [[billTwoCell alloc]init];
    twoCell.delegate = self;
    _twoCell = twoCell;
    [self.view addSubview:twoCell];
    twoCell.hidden = YES;
    
    UITapGestureRecognizer *teg = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(twoCellselector)];
    [twoCell addGestureRecognizer:teg];
    
    UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];// UITableViewStyleGrouped UITableViewStylePlain
    self.tableview = tableview;
    self.tableview.backgroundColor = ColorBigBack;
    [self.view addSubview:tableview];
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
    self.tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    [tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.twoCell.mas_top).offset(0);
    }];
    [twoCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.top.equalTo(self.tableview.mas_bottom);
        make.height.equalTo(@174);
    }];
    
    [self Refreshdata];
    [self loadingXinyongData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wechatPaySuccessller:) name:@"wechatPaySuccess" object:nil];
    if (@available(iOS 11.0, *)) {
        self.tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//UIScrollView也适用
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc] init];
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] init];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (void)wechatPaySuccessller:(NSNotification *)user{
    [self.tableview.mj_header beginRefreshing];
    [self loadingXinyongData];
    [MBProgressHUD showSuccess:@"支付成功" toView:self.view];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.billListdataclient.billList.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 67;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (void)twoCellselector{
    self.openOrClose = !self.openOrClose;
    self.twoCell.openOrClose = self.openOrClose;
    CGFloat tmp = 174;
    if (self.openOrClose) {
        NSInteger num =  self.xinyongdataclient.loanList.count;
        tmp = tmp + num*heigthvieetmpcont+(num-1)*spaingvieetmptoptolinesbottomcont + 103;
        if (num == 0) {
            tmp += spaingvieetmptoptolinesbottomcont;
        }
        if (tmp > self.view.bounds.size.height) {
            tmp = self.view.bounds.size.height;
        }
    }else{
        tmp = 174;
    }

    [self.twoCell mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.height.equalTo(@(tmp));
        make.top.equalTo(self.tableview.mas_bottom);
    }];

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        billOneCell *cell = [billOneCell returnCellWith:tableView];
        cell.data = self.billListdataclient.billList[indexPath.row];
        return cell;
}
-(void)Refreshdata{
    __weak typeof(self) weakSelf = self;
    
    self.tableview.mj_header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
        [[TWClient sharedInstance]myBillsuccess:^(id dataDict, NSString *msg, NSInteger code) { //我的账单
            weakSelf.billListdataclient = [MTLJSONAdapter modelOfClass:[billListdata class] fromJSONDictionary:dataDict error:NULL];
//            self.tableview.mj_header.hidden = YES;
            [weakSelf.tableview.mj_header endRefreshing];
            [weakSelf.tableview reloadData];
            if (!weakSelf.billListdataclient.billList || !weakSelf.billListdataclient.billList.count) {
//                [MBProgressHUD showError:@"您没有记录"];
//                [self popSelf];
                weakSelf.image1.hidden = NO;
                weakSelf.image2.hidden = NO;
                weakSelf.nomsg.hidden = NO;

            }else{
                weakSelf.image1.hidden = YES;
                weakSelf.image2.hidden = YES;
                weakSelf.nomsg.hidden = YES;
                [weakSelf.image1 removeFromSuperview];
                [weakSelf.image2 removeFromSuperview];
                [weakSelf.nomsg removeFromSuperview];
            }

        } failure:^(NSInteger errorCode, NSString *msg) {
            [weakSelf.tableview.mj_header endRefreshing];
            [MBProgressHUD showError:msg];
        }];
    }];
    [self.tableview.mj_header beginRefreshing];
}
- (void)loadingXinyongData{
    if ([[Ticket sharedInstance]judgeIsLOgin]) {
        __weak typeof(self) weakSelf = self;
        [[TWClient sharedInstance]queryMyCreditsuccess:^(id dataDict, NSString *msg, NSInteger code) {//我的信用信息
            weakSelf.xinyongdataclient = [MTLJSONAdapter modelOfClass:[xinyongdata class] fromJSONDictionary:dataDict error:NULL];
            weakSelf.twoCell.hidden = NO;
            //            weakSelf.xinyongdataclient.loanList = nil;
            weakSelf.twoCell.data = weakSelf.xinyongdataclient;
            weakSelf.twoCell.openOrClose = weakSelf.openOrClose;
        } failure:^(NSInteger errorCode, NSString *msg) {
            [MBProgressHUD showError:msg];
        }];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)btnClickLJHK{
    [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = (239-90+9)*HEIGHTICON + IQdefaultHeight;
    self.logoandregist.transform = CGAffineTransformMakeScale(0.3, 0.3);
    self.logoandregist.alpha = 0;
    [UIView animateWithDuration:0.2 animations:^{
        self.logoandregist.alpha = 1;
        self.logoandregist.transform = CGAffineTransformMakeScale(1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.1 animations:^{
            self.logoandregist.transform = CGAffineTransformMakeScale(0.9, 0.9);
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:.1 animations:^{
                self.logoandregist.transform = CGAffineTransformMakeScale(1, 1);
            }];
        }];
    }];
}

- (void)huankuangWithTorWeichat:(NSInteger)num tranAmt:(NSString *)tranAmt{
//    num = 0;
    if (num==1) {
        if (![WXApi isWXAppInstalled]) {
            [MBProgressHUD showError:@"您还没有安装微信客户端哦"];
            return;
        }
    } else {
        if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"testwalletTbi://"]]){
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"testwallet://"]]){
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"您当前的T钱包版本不支持改操作" message:@"去升级" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                alert.tag = 1011;
                [alert show];
            }else{
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"您还没有安装T钱包客户端哦" message:@"去安装" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                alert.tag = 1011;
                [alert show];
            }
            return;
        }
    }
//    __weak typeof(self) weakSelf = self;
    [MBProgressHUD showMessage:@"正在跳转..."];
    NSString *tranChannell = (num == 1)?wechatTYZF:tpurseTYZF;
//    CGFloat tmpNum = [tranAmt floatValue];
//    NSString *strNum = [NSString stringWithFormat:@"%.2f",tmpNum];
    NSNumber *tranAmt1 = [NSNumber numberWithFloat:[tranAmt floatValue]];
    [[TWClient sharedInstance]sendVerifyCodeWithreferenceId:nil tranAmt:tranAmt1 tranChannel:tranChannell tranType:HKZFTYZF success:^(id dataDict, NSString *msg, NSInteger code) {
        [MBProgressHUD hideHUD];
        
        NSNumber *numAmt = dataDict[@"tranAmt"];
        CGFloat tmpNum = [numAmt floatValue];
        NSString *strNum = [NSString stringWithFormat:@"%.2f",tmpNum];
        NSLog(@"====%@", dataDict);
        if (dataDict) {
            if (num == 1) {
//                [WXApi registerApp:WechatAppID];
                [WXApi registerApp:dataDict[@"appId"]];

                
                [TWWechatPayManager sharedInstance].payType = tranChannell;
                [TWWechatPayManager sharedInstance].orderPirce = strNum;
                [[TWWechatPayManager sharedInstance] wechatpayWithPrepayInfo:dataDict];
            }else{
                NSString *TUlr = @"testwalletTbi://";
                UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                universalpaymentInfo *info = [MTLJSONAdapter modelOfClass:[universalpaymentInfo class] fromJSONDictionary:dataDict error:nil];
                NSDictionary *data = @{
                                       @"businessID":info.prepayId,
                                       @"businessName":info.orderId,
                                       @"money":[NSString stringWithFormat:@"%@",info.tranAmt],
                                       @"supportTcoin":info.supportTcoin,
                                       };
                [pasteboard setData:[NSDictionary returnDataWithDictionary:data] forPasteboardType:@"data"];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:TUlr]];
            }
            [self logoAndRegistWillClose];
        }
        
    } failure:^(NSInteger errorCode, NSString *msg) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:msg];
    }];
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
- (void)logoAndRegistWillClose{
    [UIView animateWithDuration:.1 animations:^{
        self.logoandregist.transform = CGAffineTransformMakeScale(1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            self.logoandregist.transform = CGAffineTransformMakeScale(0.1, 0.1);
            self.logoandregist.alpha = 0.0;
            
        } completion:^(BOOL finished) {
            if (finished) {
                [self.logoandregist removeFromSuperview];
            }
        }];
        [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = IQdefaultHeight;
    }];
}
- (huankuangBtn *)logoandregist{
    if (!_logoandregist) {
        huankuangBtn *logoandregist = [[huankuangBtn alloc]init];
        logoandregist.delagate = self;
        [self.view addSubview:logoandregist];
        self.logoandregist = logoandregist;
//        self.logoandregist.userInteractionEnabled = YES;
        logoandregist.totalNum = self.xinyongdataclient.needRepay;
        [self.logoandregist mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(6*WIDTHICON);
            make.right.equalTo(self.view).offset(-6*WIDTHICON);
            //make.top.equalTo(self.view.mas_bottom);
            make.centerY.equalTo(self.view);
            make.height.equalTo(@(239*HEIGHTICON));
        }];
    }
    return _logoandregist;
}

//- (UIVisualEffectView *)Woolglass{
//    if (!_Woolglass) {
//        UIBlurEffect *beffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
//        UIVisualEffectView *Woolglass = [[UIVisualEffectView alloc]initWithEffect:beffect];
//        Woolglass.frame = self.view.bounds;
//        Woolglass.alpha = 0.75f;
//        [self.view addSubview:Woolglass];
//        _Woolglass = Woolglass;
//        _Woolglass.hidden = YES;
//    }
//    return _Woolglass;
//}
//- (billTwoCell *)twoCell{
//    if (!_twoCell) {
//        billTwoCell *twoCell = [[billTwoCell alloc]init];
//        twoCell.delegate = self;
//        _twoCell = twoCell;
//        [self.view addSubview:twoCell];
//        [twoCell mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.view);
//            make.right.equalTo(self.view);
//            make.bottom.equalTo(self.view);
//            make.height.equalTo(@174);
//        }];
//        UITapGestureRecognizer *teg = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(twoCellselector)];
//        [twoCell addGestureRecognizer:teg];
//    }
//    return _twoCell;
//}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (UIImageView *)image1{
    if (!_image1) {
        UIImageView *image = [[UIImageView alloc]init];
        image.image = [UIImage imageNamed:@"niao"];
        [self.view addSubview:image];
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
//            make.bottom.equalTo(self.view.mas_centerY);
            make.bottom.equalTo(self.twoCell.mas_top).offset(-110);
            make.width.equalTo(@50);
            make.height.equalTo(@50);
        }];
        _image1 = image;
        _image1.hidden = YES;
    }
    return _image1;
}
- (UIImageView *)image2{
    if (!_image2) {
        UIImageView *image = [[UIImageView alloc]init];
        image.image = [UIImage imageNamed:@"wu"];
        [self.view addSubview:image];
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nomsg).offset(-5);
            make.right.equalTo(self.nomsg).offset(5);;
            make.top.equalTo(self.nomsg).offset(-5);;
            make.bottom.equalTo(self.nomsg).offset(5);;
        }];
        _image2 = image;
        _image2.hidden = YES;
    }
    return _image2;
}
- (UILabel *)nomsg{
    if (!_nomsg) {
        UILabel *image = [[UILabel alloc]init];
        [self.view addSubview:image];
        image.text = @"当前无账单";
        //        image.textColor = RGBACOLOR(52, 52, 52, 1);
        image.font = [UIFont systemFontOfSize:14];
        image.textAlignment = NSTextAlignmentCenter;
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.image1.mas_bottom).offset(5);
            make.width.equalTo(@100);
            make.height.equalTo(@30);
        }];
        _nomsg = image;
        _nomsg.hidden = YES;
    }
    return _nomsg;
}
@end
