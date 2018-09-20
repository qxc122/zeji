//
//  addPassenger.m
//  jipiao
//
//  Created by Store on 2017/5/16.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "addPassenger.h"
#import "ChooseNationality.h"
#import "GNCell.h"
#import "GJCell.h"
#import "UIImage+cir.h"
#import "OtherCell.h"
#import "TWClient+Debris.h"
#import "NSString+add.h"
#import "DefineUI.h"
#import "Masonry.h"
#import "HeaderTotal.h"
#import "UIImage+cir.h"
#import "datePiker.h"
#import "NSDate+DateTools.h"
@interface addPassenger ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,weak) UIButton *btnOk;

//@property (nonatomic,assign) NSInteger PageNumber;
//@property (nonatomic,assign) NSInteger PageSize;
//@property (nonatomic,strong) orderlistS *datess;
//
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *sex;
@property (nonatomic,strong) NSString *xing;
@property (nonatomic,strong) NSString *ming;
@property (nonatomic,strong) NSString *idNumber;
@property (nonatomic,strong) NSDictionary *guoji;
@property (nonatomic,strong) NSString *chusriqi;
@property (nonatomic,strong) NSString *youxiaoqi;
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,assign) BOOL isDefual; //是否默认乘机人
@end

@implementation addPassenger

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加乘机人";
    [self setUI];
}

- (void)setUI{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    //tableView.bounces = NO;
    //    tableView.tableHeaderView = cycleScrollView3;
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view);
        make.left.equalTo(self.view);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-80);
    }];
    
    [tableView registerClass:[GNCell class] forCellReuseIdentifier:NSStringFromClass([GNCell class])];
    [tableView registerClass:[GJCell class] forCellReuseIdentifier:NSStringFromClass([GJCell class])];
    [tableView registerClass:[OtherCell class] forCellReuseIdentifier:NSStringFromClass([OtherCell class])];
    
    UIButton *btnOk = [UIButton new];
    self.btnOk  =btnOk;
    [self.view addSubview:btnOk];
    [btnOk mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-15);
        make.left.equalTo(self.view).offset(15);
        make.top.equalTo(tableView.mas_bottom).offset(15);
        make.bottom.equalTo(self.view).offset(-15);
    }];
    [btnOk setBackgroundImage:[UIImage imageWithColor:ColorWithHex(0xEB4E52, 1.0)] forState:UIControlStateNormal];
    [btnOk setTitle:@"保存" forState:UIControlStateNormal];
    [btnOk setTitleColor:ColorWithHex(0xFFFFFF, 1.0) forState:UIControlStateNormal];
    btnOk.titleLabel.font = PingFangSC_Regular(17);
    [btnOk addTarget:self action:@selector(btnOkClick) forControlEvents:UIControlEventTouchUpInside];
    btnOk.enabled = NO;
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//UIScrollView也适用
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

#pragma -mark<确定按钮 >
- (void)btnOkClick{
    NSLog(@"btnOk");
    kWeakSelf(self);
    NSString *certType;
    if (!self.name || !self.name.length) {
        [MBProgressHUD showError:@"请输入姓名" toView:self.view];
        return;
    }
    if (self.type == GN_addPassenger_TYPE) {
        if (![NSString checkIdCardNumber:self.idNumber]) {
            [MBProgressHUD showError:@"请输入正确的身份证号" toView:self.view];
            return;
        }
    } else {
        if (!self.idNumber || !self.idNumber.length) {
            [MBProgressHUD showError:@"请输入证件号" toView:self.view];
            return;
        }
    }


    if (self.type == GN_addPassenger_TYPE) {
        certType = @"NI";
    } else if (self.type == GJ_addPassenger_TYPE || self.type == Other_addPassenger_TYPE) {
        if (!self.sex || !self.sex.length) {
            [MBProgressHUD showError:@"请选择性别" toView:self.view];
            return;
        }
        if (self.type == GJ_addPassenger_TYPE) {
            certType = @"P";
            if (!self.xing || !self.xing.length) {
                [MBProgressHUD showError:@"请输入英文姓" toView:self.view];
                return;
            }
            if (!self.ming || !self.ming.length) {
                [MBProgressHUD showError:@"请输入英文名" toView:self.view];
                return;
            }
        } else if (self.type == Other_addPassenger_TYPE) {
            certType = @"ID";
        }
        if (!self.guoji) {
            [MBProgressHUD showError:@"请选择国籍" toView:self.view];
            return;
        }
        if (!self.chusriqi || !self.chusriqi.length) {
            [MBProgressHUD showError:@"请选择出生日期" toView:self.view];
            return;
        }
        if (!self.youxiaoqi || !self.youxiaoqi.length) {
            [MBProgressHUD showError:@"请选择有效期" toView:self.view];
            return;
        }
    }
    if (![NSString checkTelNumber:self.phone]) {
        [MBProgressHUD showError:@"请输入正确的手机号" toView:self.view];
        return;
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[TWClient sharedInstance]addContactWithcontactType:@"1"  mobile:self.phone name:self.name surname:self.xing enName:self.ming sex:self.sex nationality:self.guoji[@"countryCode"] certType:certType certNo:self.idNumber birthday:self.chusriqi expireDate:self.youxiaoqi defaultFlag:self.isDefual?@"1":@"0" friendFlag:@"0" success:^(id dataDict, NSString *msg, NSInteger code) {
        [MBProgressHUD hideHUDForView:weakself.view  animated:YES];
        [MBProgressHUD showSuccess:@"添加秘书成功" toView:self.view];
        if (weakself.reload) {
            weakself.reload();
            [weakself.navigationController popViewControllerAnimated:YES];
        }

    } failure:^(NSInteger errorCode, NSString *msg) {
        [MBProgressHUD hideHUDForView:weakself.view animated:YES];
        [MBProgressHUD showError:msg toView:weakself.view];
    }];
}

//#pragma -mark<MJ_head加载数据   底部>
//- (void)MJRefreshFoot{
//    __weak typeof(self) weakSelf = self;
//    // 上拉加载更多
//    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        // 增加10条数据
//        [weakSelf shuxingshujudata:MJREFRESH_LOADMORE];
//    }];
//    // 默认先隐藏footer
//    self.tableView.mj_footer.hidden = YES;
//}


#pragma --mark< UITableViewDelegate 高>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    kWeakSelf(self);
    if (self.type == GJ_addPassenger_TYPE) {
        return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([GJCell class]) configuration:^(GJCell *cell) {
            [self configureGJCell:cell atIndexPath:indexPath];
        }];
    } else if (self.type == GN_addPassenger_TYPE) {
        return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([GNCell class]) configuration:^(GNCell *cell) {
            [self configureGNCell:cell atIndexPath:indexPath];
        }];
    } else if (self.type == Other_addPassenger_TYPE) {
        return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([OtherCell class]) configuration:^(OtherCell *cell) {
            [self configureOtherCell:cell atIndexPath:indexPath];
        }];
    }
    return 0.01;
}
#pragma --mark<配置OtherCell cell>
- (void)configureOtherCell:(OtherCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    kWeakSelf(self);
    cell.xuanzguoji = ^(){
        ChooseNationality *vc = [ChooseNationality new];
        vc.ChoseOK = ^(NSDictionary *dic){
            NSLog(@"dic=%@",dic);
            weakself.guoji = dic;
            [weakself.tableView reloadData];
        };
        [weakself.navigationController pushViewController:vc animated:YES];
    };
    cell.reload = ^(){
        [weakself ChoseType];
    };
    cell.FillIn = ^(NSString *peopleOne,TextField_TYPE_ENMU type) {
        if (type == name_TextField_TYPE_ENMU) {
            weakself.name = peopleOne;
        } else if (type == sex_TextField_TYPE_ENMU) {
            weakself.sex = peopleOne;
        } else if (type == xing_TextField_TYPE_ENMU) {
            weakself.xing = peopleOne;
        } else if (type == ming_TextField_TYPE_ENMU) {
            weakself.ming = peopleOne;
        } else if (type == huzhao_TextField_TYPE_ENMU) {
            weakself.idNumber = peopleOne;
        } else if (type == csrq_TextField_TYPE_ENMU) {
            weakself.chusriqi = peopleOne;
        } else if (type == yxq_TextField_TYPE_ENMU) {
            weakself.youxiaoqi = peopleOne;
        } else if (type == phone_TextField_TYPE_ENMU) {
            weakself.phone = peopleOne;
        }
        if (weakself.name && weakself.name.length && weakself.idNumber && weakself.idNumber.length && weakself.phone && weakself.phone.length && weakself.sex && weakself.sex.length && weakself.chusriqi && weakself.chusriqi.length && weakself.youxiaoqi && weakself.youxiaoqi.length) {
            weakself.btnOk.enabled = YES;
        } else {
            weakself.btnOk.enabled = NO;
        }
    };
    cell.isDefual = ^(BOOL isDefual) {
        weakself.isDefual = isDefual;
    };
    cell.name= self.name;
    
    cell.idNumber = self.idNumber;
    cell.guoji = self.guoji;
    cell.chusriqi= self.chusriqi;
    cell.youxiaoqi= self.youxiaoqi;
    cell.phone= self.phone;
    cell.isDefualStr = self.isDefual;
}


#pragma --mark<配置GJCell cell>
- (void)configureGJCell:(GJCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    [self configureOtherCell:(OtherCell *)cell atIndexPath:indexPath];
    cell.xing = self.xing;
    cell.ming = self.ming;
    if (self.btnOk.enabled) {
        if (self.xing && self.xing.length && self.ming && self.ming.length) {
            self.btnOk.enabled = YES;
        } else {
            self.btnOk.enabled = NO;
        }
    }
}
#pragma --mark<配置 GNCell cell>
- (void)configureGNCell:(GNCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    kWeakSelf(self);
    cell.reload = ^(){
        [weakself ChoseType];
    };
    cell.FillIn = ^(NSString *peopleOne,TextField_TYPEGNCell_ENMU type) {
        if (type == name_TextField_TYPEGNCell_ENMU) {
            weakself.name = peopleOne;
        } else if (type == card_TextField_TYPEGNCell_ENMU) {
            weakself.idNumber = peopleOne;
        } else if (type == phone_TextField_TYPEGNCell_ENMU) {
            weakself.phone = peopleOne;
        }
        if (weakself.name && weakself.name.length && weakself.idNumber && weakself.idNumber.length && weakself.phone && weakself.phone.length) {
            weakself.btnOk.enabled = YES;
        } else {
            weakself.btnOk.enabled = NO;
        }
    };
    cell.isDefual = ^(BOOL isDefual) {
        weakself.isDefual = isDefual;
    };
    cell.name= self.name;
    cell.idNumber = self.idNumber;
    cell.phone= self.phone;
    cell.isDefualStr = self.isDefual;
}


#pragma --mark<切换类型>
- (void)ChoseType{
    NSString *str = @"选择证件类型";
    NSArray *str2 = @[@"身份证",@"护照",@"其它"];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:str message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    for (NSString *strt in str2) {
        [alert addAction:[UIAlertAction actionWithTitle:strt style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //点击按钮的响应事件；
            if ([action.title isEqualToString:@"身份证"]) {
                self.type = GN_addPassenger_TYPE;
            } else if ([action.title isEqualToString:@"护照"]) {
                self.type = GJ_addPassenger_TYPE;
            } else if ([action.title isEqualToString:@"其它"]) {
                self.type = Other_addPassenger_TYPE;
            }
            [self.tableView reloadData];
        }]];
    }
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //点击按钮的响应事件；
    }]];
    //弹出提示框；
    [self.navigationController presentViewController:alert animated:true completion:nil];
}

#pragma -mark<UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

#pragma --mark< 创建cell >
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.type == GJ_addPassenger_TYPE) {
        GJCell *cell = [GJCell returnCellWith:tableView];
        [self configureGJCell:cell atIndexPath:indexPath];
        return  cell;
    } else if (self.type == GN_addPassenger_TYPE) {
        GNCell *cell = [GNCell returnCellWith:tableView];
        [self configureGNCell:cell atIndexPath:indexPath];
        return  cell;
    } else if (self.type == Other_addPassenger_TYPE) {
        OtherCell *cell = [OtherCell returnCellWith:tableView];
        [self configureOtherCell:cell atIndexPath:indexPath];
        return  cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NO"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"NO"];
        }
        return cell;
    }
    return nil;
}

#pragma --<空白页处理>
////- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView{
////    UIView *tmp = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth)];
////    tmp.backgroundColor = [UIColor redColor];
////    [scrollView addSubview:tmp];
////    [tmp mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.left.equalTo(self.tableView);
////        make.right.equalTo(self.tableView);
////        make.top.equalTo(self.tableView);
////        make.bottom.equalTo(self.tableView);
////    }];
////    return tmp;
////}
//
//
//- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
//    if (self.IsLoadSuccessfully) {
//        return [UIImage imageNamed:@"空状态dd"];
//    } else {
//        return [UIImage imageNamed:load_fail_image];
//    }
//    return nil;
//}
//
//- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
//    if (!self.IsLoadSuccessfully) {
//        NSString *text = @"服务器开小差了，刷新一下吧";
//        
//        NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:14.0f],
//                                     NSForegroundColorAttributeName: [UIColor darkGrayColor]};
//        
//        return [[NSAttributedString alloc] initWithString:text attributes:attributes];
//    }
//    return nil;
//}
//
//
//- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
//    NSString *text;
//    NSDictionary *attributes;
//    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
//    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
//    paragraph.alignment = NSTextAlignmentCenter;
//    if (self.IsLoadSuccessfully) {
//        text = @"亲，暂无相关订单哦";
//        attributes = @{NSFontAttributeName: PingFangSC_Regular(14),
//                       NSForegroundColorAttributeName: ColorWithHex(0x779CF4, 1.0),
//                       NSParagraphStyleAttributeName: paragraph};
//    } else {
//        text = @"点击重新加载";
//        attributes = @{NSFontAttributeName: PingFangSC_Regular(17),
//                       NSForegroundColorAttributeName: ColorWithHex(0x779CF4, 1.0),
//                       NSParagraphStyleAttributeName: paragraph};
//    }
//    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
//}
//
////按钮文本或者背景样式
//
////- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
////    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:17.0f]};
////
////    return [[NSAttributedString alloc] initWithString:@"Continue 点击继续" attributes:attributes];
////}
////
////- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
////    return [UIImage imageNamed:@"123"];
////}
//
////空白页的背景色
//
//- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView {
//    return [UIColor whiteColor];
//}
//
////是否显示空白页，默认YES
//- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
//    if (!self.datess || !self.datess.contentA.count) {
//        return YES;
//    }
//    return NO;
//}
//
////空白页点击事件
//- (void)emptyDataSetDidTapView:(UIScrollView *)scrollView {
//    if (!self.IsLoadSuccessfully) {
//        self.tableView.mj_header.hidden = NO;
//        [self.tableView.mj_header beginRefreshing];
//    }
//}
//
//
////- (CGPoint)offsetForEmptyDataSet:(UIScrollView *)scrollView{
////    return CGPointMake(300, 10);
////}
////- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
////    return -100;
////}
//
////- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView{
////    return 15;
////}
@end
