//
//  myinfo.m
//  jipiao
//
//  Created by Store on 16/8/12.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "myinfo.h"
#import "myinfoData.h"
#import "headmyinfo.h"
#import "tableHead.h"
#import "tableFoot.h"
#import "onemycell.h"
#import "twomycell.h"
#import "fourmycell.h"
#import "addhaoyou.h"
#import "addmishu.h"
#import "nullcell.h"
#import "youhuimaCell.h"
#import "NSString+add.h"

#import "addPassenger.h"

#define aleetTag  10  //打开通讯录权限
@interface myinfo ()<UITableViewDelegate,UITableViewDataSource,onemycellDelegate,headmyinfoDelegate,fourbtnnnmycellDelegate,addhaoyouDelegate,addmishuDelegate,tableFootDelegate,UIAlertViewDelegate,youhuimaCellDelegate>
@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,strong)myinfoData *data;
@property (nonatomic,strong)NSArray *icons;
@property (nonatomic,strong)NSArray *titles;
@property (nonatomic,strong)tableHead *head;
@property (nonatomic,strong)tableFoot *foot;
@property (nonatomic,strong)NSMutableArray *arrySectionIsopen; //存储2 3的信息是否打开还是关闭

@property (nonatomic,strong)NSString *phoneTel;  //存通讯录返回的电话
@property (nonatomic,strong)NSString *phoneName;  //存通讯录返回的电话

@property (nonatomic,strong)NSString *phoneTelTwo;  //存通讯录返回的电话针对秘书的
@property (nonatomic,assign) BOOL IsIDcard;
@end

@implementation myinfo
- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"我的信息";
    self.IsIDcard = YES;
    self.titles = @[@"个人信息",@"飞行信用",@"我的好友",@"我的行政秘书"];//@[@"个人信息",@"飞行信用",@"我的好友",@"我的行政秘书",@"我的优惠码"];
    self.icons = @[@"img_information",@"img_credit",@"img_friends",@"img_administration",@"矩形26拷贝3"];
  
    tableHead *head = [[tableHead alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 118*HEIGHTICON)];
    self.head = head;
    tableFoot *foot = [[tableFoot alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 30*HEIGHTICON+44)];
    foot.delegate = self;
    self.foot = foot;
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView = tableView;
    self.tableView.tableHeaderView = self.head;
    self.tableView.tableFooterView = self.foot;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    tableView.tableHeaderView.userInteractionEnabled = YES;
    tableView.tableFooterView.userInteractionEnabled = YES;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];

    self.data = [NSKeyedUnarchiver unarchiveObjectWithFile:GRXXDATA];
    if (self.data) {
        self.head.data = self.data;
        [self.tableView reloadData];
    } else {
        
    }
    [self mjreflushdata];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(returnMyContacts:)
                                                 name:NOTIFINAME_ADDSECRETARY
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(returnMyContacts:)
                                                 name:NOTIFINAME_ADDFRIENDS
                                               object:nil];
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//UIScrollView也适用
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] init];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.titles count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger tmp = 0;
    if (section == 0) {
        tmp = 4+2;
    } else if (section == 1){
        tmp =  1;
    } else if (section == 2){
        if (self.data.passengerInfos.count) {
            tmp = self.data.passengerInfos.count+2;
        }else{
            tmp = 1;
        }
    } else if (section == 3){
        if (self.data.secretaryInfos.count) {
            tmp = self.data.secretaryInfos.count;
        } else {
            tmp = 1;
        }
    } else if (section == 4){
        tmp = 0;
    }
    if ([self.arrySectionIsopen[section] boolValue]) {//判断是否展开
        tmp += 1;
    }
    NSLog(@"tmp=%ld",(long)tmp);
    return tmp;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0 || indexPath.row == 5) {
            return 10;
        } else {
            return 21;
        }
    } else if (indexPath.section == 1){
        return 129;
    } else if (indexPath.section == 2){
        if ([self.arrySectionIsopen[indexPath.section] boolValue]) {
            if (self.data.passengerInfos.count) {
                if (indexPath.row==0 || indexPath.row==self.data.passengerInfos.count+2) {
                    return 10;
                }else if (indexPath.row==self.data.passengerInfos.count+1){
                    CGFloat tmp = 300-42;
                    if (self.IsIDcard) {
                        tmp -= 42;
                    } else {
                        
                    }
                    return tmp;
                }else{
                    return 21;
                }
            } else {
                if (indexPath.row==0) {
                    return 21;
                } else if (indexPath.row==1){
                    CGFloat tmp = 300-42;
                    if (self.IsIDcard) {
                        tmp -= 42;
                    } else {
                        
                    }
                    return tmp;
                }
            }
        }else{
            if (self.data.passengerInfos.count) {
                if (indexPath.row==0 || indexPath.row==self.data.passengerInfos.count+1) {
                    return 10;
                }else{
                    return 21;
                }
            } else {
                return 21;
            }
        }
    } else if (indexPath.section == 3){
         if ([self.arrySectionIsopen[indexPath.section] boolValue]){
             if (self.data.secretaryInfos.count) {
                 if ((indexPath.row==self.data.secretaryInfos.count)) {
                     return 56;
                 } else {
                     return 21;
                 }
             } else{
                 if (indexPath.row==1) {
                     return 56;
                 } else {
                     return 21;
                 }
             }
         }else{
             return 21;
         }
    } else if (indexPath.section == 4){
        return 135;
    }
    return 44;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    headmyinfo *label = [[headmyinfo alloc]init];
    label.icon = self.icons[section];
    label.des = self.titles[section];
    label.index = section;
    label.delegate = self;
    label.value = self.arrySectionIsopen[section];
    if (section == 0) {
        label.btnImage = nil;
    } else if (section == 1){
        label.btnImage = nil;
    } else if (section == 2){
        label.btnImage = @"icon_add to";
    } else if (section == 3){
        label.btnImage = @"icon_add to";
    } else if (section == 4){
//        label.btnImage = @"jiahao";
        label.btnImage = nil;
    }
    
    label.delegate = self;
    return  label;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 26;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *celltmp;
    if (indexPath.section == 0) {
        if (indexPath.row == 0 || indexPath.row == 5) {
            nullcell *cell = [nullcell returnCellWith:tableView];
            celltmp = cell;
        } else {
            onemycell *cell = [onemycell returnCellWith:tableView];
            cell.index = indexPath.row;
            cell.delegate = self;
            NSString *name = nil;
            NSString *des = nil;
            BOOL tmp = NO;
            cell.registerType = self.data.registerType;
            cell.realnameStatus = self.data.realnameStatus;
            if (indexPath.row == 1){
                name = @"帐号：";
                des = self.data.userId;
                tmp = YES;
            } else if (indexPath.row == 2) {
                name = @"姓名：";
                des = self.data.userName;
                tmp = NO;
            } else if (indexPath.row == 3){
                name = @"身份证：";
                des = self.data.certNo;
                tmp = NO;
            } else if (indexPath.row == 4){
                name = @"手机号：";
                des = self.data.mobile;
                tmp = NO;
            }
            cell.name = name;
            cell.des = des;
            cell.isHiddenArrow = tmp;
            celltmp = cell;
        }
    } else if (indexPath.section == 1){
        twomycell *cell = [twomycell returnCellWith:tableView];
        cell.data = self.data.flyCreditInfo;

        celltmp = cell;
    } else if (indexPath.section == 2){
        if ([self.arrySectionIsopen[indexPath.section] boolValue]) {
            if (self.data.passengerInfos.count) {
                if (indexPath.row==0 || indexPath.row==self.data.passengerInfos.count+2) {
                    nullcell *cell = [nullcell returnCellWith:tableView];
                    celltmp = cell;
                }else if (indexPath.row==self.data.passengerInfos.count+1){
                    addhaoyou *cell = [addhaoyou returnCellWith:tableView];
                    cell.IsIDcard = self.IsIDcard;
                    cell.phoneTel = self.phoneTel;
                    cell.phoneName = self.phoneName;
                    cell.delegate = self;
                    celltmp = cell;
                }else{
                    fourmycell *cell = [fourmycell returnCellWith:tableView];
                    cell.index = indexPath;
                    cell.delegate = self;
                    cell.data = self.data.passengerInfos[indexPath.row-1];
                    celltmp = cell;
                }
            } else {
                if (indexPath.row==0) {
                    fourmycell *cell = [fourmycell returnCellWith:tableView];
                    cell.index = indexPath;
                    cell.msg = @"您还没有好友,赶快去添加吧";
                    celltmp = cell;
                } else if (indexPath.row==1){
                    addhaoyou *cell = [addhaoyou returnCellWith:tableView];
                    cell.IsIDcard = self.IsIDcard;
                    cell.delegate = self;
                    cell.phoneTel = self.phoneTel;
                    cell.phoneName = self.phoneName;
                    celltmp = cell;
                }
            }
        }else{
            if (self.data.passengerInfos.count) {
                if (indexPath.row==0 || indexPath.row==self.data.passengerInfos.count+1) {
                    nullcell *cell = [nullcell returnCellWith:tableView];
                    celltmp = cell;
                }else{
                    fourmycell *cell = [fourmycell returnCellWith:tableView];
                    cell.index = indexPath;
                    cell.delegate = self;
                    cell.data = self.data.passengerInfos[indexPath.row-1];
                    celltmp = cell;
                }
            } else {
                if (indexPath.row==0) {
                    fourmycell *cell = [fourmycell returnCellWith:tableView];
                    cell.index = indexPath;
                    cell.msg = @"您还没有好友,赶快去添加吧";
                    celltmp = cell;
                } else if (indexPath.row==1){
                    addhaoyou *cell = [addhaoyou returnCellWith:tableView];
                    cell.delegate = self;
                    cell.IsIDcard = self.IsIDcard;
                    cell.phoneTel = self.phoneTel;
                    cell.phoneName = self.phoneName;
                    celltmp = cell;
                }
            }
        }
    } else if (indexPath.section == 3){
        if ([self.arrySectionIsopen[indexPath.section] boolValue]){
            if (self.data.secretaryInfos.count) {
                if ((indexPath.row==self.data.secretaryInfos.count)) {
                    addmishu *cell = [addmishu returnCellWith:tableView];
                    cell.phone = self.phoneTelTwo;
                    cell.delegate = self;
                    celltmp = cell;
                } else {
                    fourmycell *cell = [fourmycell returnCellWith:tableView];
                    cell.index = indexPath;
                    cell.delegate = self;
                    cell.datatwo = self.data.secretaryInfos[indexPath.row];
                    celltmp = cell;
                }
            } else{
                if (indexPath.row==1) {
                    addmishu *cell = [addmishu returnCellWith:tableView];
                    cell.phone = self.phoneTelTwo;
                    cell.delegate = self;
                    celltmp = cell;
                } else {
                    fourmycell *cell = [fourmycell returnCellWith:tableView];
                    cell.index = indexPath;
                    cell.msg = @"您还没有秘书,赶快去添加吧";
                    celltmp = cell;
                }
            }
        }else{
            fourmycell *cell = [fourmycell returnCellWith:tableView];
            cell.index = indexPath;
            celltmp = cell;
            if (self.data.secretaryInfos.count) {
                cell.delegate = self;
                cell.datatwo = self.data.secretaryInfos[indexPath.row];
            } else{
                cell.msg = @"您还没有秘书,赶快去添加吧";
            }
        }
    }else if (indexPath.section == 4){
        youhuimaCell *cell = [youhuimaCell returnCellWith:tableView];
        cell.delegate = self;
        celltmp = cell;
    }
    return celltmp;
}
- (void)getMydataInfo{
    __weak typeof(self) weakSelf = self;
    [[TWClient sharedInstance]getMyInfosuccess:^(id dataDict, NSString *msg, NSInteger code) {
        NSLog(@"查询我的信息OK");
        weakSelf.tableView.tableHeaderView = weakSelf.head;
        weakSelf.tableView.tableFooterView = weakSelf.foot;
        weakSelf.tableView.delegate = weakSelf;
        weakSelf.tableView.dataSource = weakSelf;
        
        myinfoData *data =[MTLJSONAdapter modelOfClass:[myinfoData class] fromJSONDictionary:dataDict error:NULL];
        weakSelf.data = data;
        weakSelf.data.flyCreditInfo = [MTLJSONAdapter modelOfClass:[flyCreditInfoData class] fromJSONDictionary:dataDict[@"flyCreditInfo"] error:NULL];
        weakSelf.head.data = data;
        [NSKeyedArchiver archiveRootObject:data toFile:GRXXDATA];
        [weakSelf.tableView reloadData];
        
        if (weakSelf.tableView.mj_header ) {
            [weakSelf.tableView.mj_header endRefreshing];
            weakSelf.tableView.mj_header.hidden = YES;
        }
    } failure:^(NSInteger errorCode, NSString *msg) {
        [MBProgressHUD showError:msg toView:weakSelf.view];
        if (weakSelf.tableView.mj_header ) {
            [weakSelf.tableView.mj_header endRefreshing];
        }
    }];
}

- (void)mjreflushdata{
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getMydataInfo];
    }];

    [self.tableView.mj_header beginRefreshing];
}
- (void)mybtnClick:(NSInteger)index :(NSString *)msg{
    if (!msg || !msg.length) {
        [MBProgressHUD showError:@"信息不能为空"];
        [self.tableView reloadData];
        return;
    }
    NSString *str1 = nil;//self.data.userName;
    NSString *str2 = nil;//self.data.mobile;;
    NSString *str3 = nil;//self.data.certNo;;
    if (index == 2) {
        str1 = msg;
    } else if (index == 3){
        str3 = msg;
    } else if (index == 4){
        if ([NSString checkTelNumber:msg]) {
            str2 = msg;
        } else {
            [MBProgressHUD showError:@"请输入正确的手机号"];
            [self.tableView reloadData];
            return;
        }
    }
    __weak typeof(self) weakSelf = self;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[TWClient sharedInstance]MyInfoModifyWithuserName:str1 mobile:str2 certNo:str3 success:^(id dataDict, NSString *msg, NSInteger code) {
        [MBProgressHUD hideHUDForView:weakSelf.view  animated:YES];
        [MBProgressHUD showSuccess:@"修改成功"];
        [weakSelf getMydataInfo];
        if (index == 2){
            NSDictionary *dictTmp = @{@"msg":str1,};
            NSNotification *notification =[NSNotification notificationWithName:NAMEUploadSuccess object:nil userInfo:dictTmp];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
        }
    } failure:^(NSInteger errorCode, NSString *msg) {
        [MBProgressHUD hideHUDForView:weakSelf.view  animated:YES];
        [MBProgressHUD showError:msg];
        [weakSelf.tableView reloadData];
    }];
      NSLog(@"mybtnClick");
}
#pragma  fourmycellDelegate
- (void)fourmycellbtnnnClick:(NSIndexPath *)index{
    NSLog(@"fourmycellClick");
    [self getMydataInfo];
}


- (void)returnMyContacts:(NSNotification *)user{
    NSDictionary *dic = user.userInfo;
    NSString *tel = dic[@"tel"];
    NSString *name = dic[@"name"];
    [self.navigationController popToViewController:self animated:YES];

    if ([user.name isEqualToString:NOTIFINAME_ADDSECRETARY]) {
        self.phoneTelTwo = tel;
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:self.data.secretaryInfos.count inSection:3];
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        
        [self returnClickyyyaddmishu:tel];
    }else if([user.name isEqualToString:NOTIFINAME_ADDFRIENDS]){
        self.phoneTel = tel;
        self.phoneName = name;
        NSIndexSet *set = [NSIndexSet indexSetWithIndex:2];
        [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
    }
}

#pragma 增加秘书代理
- (void)returnClickyyyaddmishu:(NSString *)phone{
    NSLog(@"phone＝%@",phone);
    if (![NSString checkTelNumber:phone]) {
        [MBProgressHUD showError:@"请输入正确的手机号" toView:self.view];
    }else if([phone isEqualToString:self.data.mobile]){
        [MBProgressHUD showError:@"您不能添加自己为好友"];
    }else{
        __weak typeof(self) weakSelf = self;
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];

        [[TWClient sharedInstance]addContactWithcontactType:@"2"  mobile:phone name:nil surname:nil enName:nil sex:nil nationality:nil certType:nil certNo:nil birthday:nil expireDate:nil defaultFlag:nil friendFlag:@"0" success:^(id dataDict, NSString *msg, NSInteger code) {
            [MBProgressHUD hideHUDForView:weakSelf.view  animated:YES];
            [MBProgressHUD showSuccess:@"添加秘书成功" toView:self.view];

            [weakSelf.arrySectionIsopen replaceObjectAtIndex:3 withObject:@"0"];
            [weakSelf getMydataInfo];
            weakSelf.phoneTelTwo = nil;
        } failure:^(NSInteger errorCode, NSString *msg) {
            [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
            [MBProgressHUD showError:msg toView:self.view];
        }];
    }
}
#pragma  headmyinfoDelegate //头部视图代理
- (void)headClick:(NSInteger)index :(NSString *)des{
    if (index == 2) {
        kWeakSelf(self);
        addPassenger *vc = [addPassenger new];
        vc.type = GN_addPassenger_TYPE;
        vc.reload = ^(){
            weakself.tableView.mj_header.hidden = NO;
            [weakself.tableView.mj_header beginRefreshing];
        };
        [self.navigationController pushViewController:vc animated:YES];
        NSLog(@"去添加好友了啊");
    } else if (index == 3) {
        if ([des isEqualToString:@"0"]) {
            if (index == 2) {   //好友
                self.phoneTel = nil;
                self.phoneName = nil;
                self.IsIDcard = YES;
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFINAME_ADDFRIENDSSUCCES object:nil];
            } else if(index == 3){  //秘书
                self.phoneTelTwo = nil;
            }
        }
        [self.arrySectionIsopen replaceObjectAtIndex:index withObject:des];
        
        NSIndexSet *set = [NSIndexSet indexSetWithIndex:index];
        [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
    }
}
- (NSMutableArray *)arrySectionIsopen{
    if (!_arrySectionIsopen) {
        _arrySectionIsopen = [NSMutableArray array];
        [_arrySectionIsopen addObjectsFromArray:@[@"0",@"0",@"0",@"0",@"1"]];
    }
    return _arrySectionIsopen;
}


#pragma  尾部视图代理
- (void)clickLogout{
    __weak typeof(self) weakSelf = self;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[TWClient sharedInstance]logoutsuccess:^(id dataDict, NSString *msg, NSInteger code) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [[Ticket sharedInstance]updateLogininfo:ZEJIOUT];
        if ([msg isKindOfClass:[NSNull class]] || !msg ||!msg.length) {
            [MBProgressHUD showSuccess:@"退出成功"];
        }else{
           [MBProgressHUD showSuccess:msg];
        }

        [weakSelf popSelf];
    } failure:^(NSInteger errorCode, NSString *msg) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showError:msg];
    }];
}


//添加优惠券
//- (void)addyouhuiquanWithCode:(NSString *)code{
//    if (!code || !code.length) {
//        [MBProgressHUD showError:@"请输入有效的优惠券号" toView:self.view];
//    } else {
//        __weak typeof(self) weakSelf = self;
//        [[TWClient sharedInstance]couponCodeRechargeWithcouponCode:code success:^(id dataDict, NSString *msg, NSInteger code) {
////            tcoinCnt
//            if (![msg isKindOfClass:[NSNull class]] && msg && msg.length) {
//                [MBProgressHUD showSuccess:msg toView:weakSelf.view];
//            }
//        } failure:^(NSInteger errorCode, NSString *msg) {
//            [MBProgressHUD showError:msg toView:weakSelf.view];
//            
//        }];
//    }
//}
//增加好友代理
- (void)CloseAddFriends{
    self.phoneName = nil;
    self.phoneTel = nil;
    self.IsIDcard = YES;
    [self.arrySectionIsopen replaceObjectAtIndex:2 withObject:@"0"];
    [self.tableView reloadData];
}
- (void)Selectthetypeofdocument:(BOOL)IsIDcard{
    self.IsIDcard = IsIDcard;
    [self.tableView reloadData];
}
- (void)goToAddFriendsWithname:(NSString *)name tel:(NSString *)tel certType:(NSString *)certType certNo:(NSString *)certNo birthday:(NSString *)birthday{
    NSString *strMsg = nil;
    if (!birthday || birthday.length == 0) {
        strMsg = @"请选择出生日期";
    }
    if (!certNo || certNo.length == 0) {
        strMsg = @"请输入正确的证件号码";
    }
    if ([certType isEqualToString:@"身份证"] && [NSString  checkIdCardNumber:certNo] == NO) {
        strMsg = @"请输入正确的身份证号码";
    }
    if (!tel || [NSString  checkTelNumber:tel] == NO) {
        strMsg = @"请输入正确的手机号码";
    }
    if (!name || name.length == 0) {
        strMsg = @"请输入姓名";
    }
    if (strMsg) {
        [MBProgressHUD showError:strMsg toView:self.view];
    }else{
        NSString *typeCard = nil;
        if ([certType isEqualToString:@"身份证"]) {
            typeCard = @"NI";
        } else if ([certType isEqualToString:@"护照"]){
            typeCard = @"P";
        }else{
            typeCard = @"ID";
        }
        __weak typeof(self) weakSelf = self;
//        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        [[TWClient sharedInstance]addContactWithcontactType:@"1"  mobile:tel name:name  certType:typeCard certNo:certNo  birthday:birthday friendFlag:@"0" success:^(id dataDict, NSString *msg, NSInteger code) {
//            [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
//            [MBProgressHUD showSuccess:@"添加好友成功" toView:weakSelf.view];
//            
//            [weakSelf getMydataInfo];
//            weakSelf.IsIDcard = YES;
//            weakSelf.phoneTel = nil;
//            weakSelf.phoneName = nil;
//            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFINAME_ADDFRIENDSSUCCES object:nil];
//        } failure:^(NSInteger errorCode, NSString *msg) {
//            [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
//            [MBProgressHUD showError:msg toView:weakSelf.view];
//
//        }];
    }
}
#pragma onemycellDelegate  代理
- (void)showMSg:(NSString *)msg{
    [MBProgressHUD showError:msg toView:self.view];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    NSLog(@"个人信息示范");
}
@end
