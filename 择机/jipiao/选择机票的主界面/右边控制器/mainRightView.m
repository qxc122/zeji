//
//  mainRightView.m
//  jipiao
//
//  Created by Store on 16/10/20.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "mainRightView.h"
#import "noRecord.h"
#import "rightmainCell.h"
#import "rithtFlirhtdata.h"
#import "NSString+add.h"
#define returnnum  10   //每页返回10条数据

@interface mainRightView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,strong) NSString *pageNo;
@property (nonatomic,strong) rithtFlirhtdata *dataall;
@property (nonatomic,weak) noRecord *noecord;
@end

@implementation mainRightView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.pageNo = @"1";
        self.alpha = 0.95;
        self.backgroundColor = RGBColor(23, 36,52);
        
        UITableView *tableView = [[UITableView alloc]init];
        self.tableView = tableView;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.backgroundColor = RGBColor(38, 48, 64);
        [self addSubview:tableView];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        UIButton *btnleft = [[UIButton alloc]init];
        [btnleft setImage:[UIImage imageNamed:@"icon_stop"] forState:UIControlStateNormal];
        [self addSubview:btnleft];
        [btnleft addTarget:self action:@selector(btnCloseSelf) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *btnright = [[UIButton alloc]init];
        btnright.titleLabel.font = [UIFont systemFontOfSize:12];
        [btnright setTitle:@"清除所有" forState:UIControlStateNormal];
        [self addSubview:btnright];
        [btnright addTarget:self action:@selector(btnrightClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [btnleft mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.top.equalTo(self).offset(20);
            make.height.equalTo(@40);
            make.width.equalTo(@40);
        }];
        
        [btnright mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-10);
            make.bottom.equalTo(btnleft);
            make.top.equalTo(btnleft);
        }];
        
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.bottom.equalTo(self);
            make.top.equalTo(self).offset(64);
        }];
        
        [self mjreflushdata];

        UISwipeGestureRecognizer *rswip = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(btnCloseSelf)];
        rswip.direction=UISwipeGestureRecognizerDirectionRight;
        [self addGestureRecognizer:rswip];
    }
    return self;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataall.historyInfo.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    rithtFlirhtdataone *data = self.dataall.historyInfo[indexPath.row];
    NSString *tmp;
    if (data.backDate && data.backDate.length) {
        tmp = [NSString stringWithFormat:@"%@/%@",data.depDate,data.backDate];
    } else {
        tmp = data.depDate;
    }
    CGFloat height = [NSString HeightForText:tmp withFont:[UIFont systemFontOfSize:11] withTextWidth:(screenWidth/4*3-15-5-5-28-5-5)];
    return 10+14+5+height+14+1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    rithtFlirhtdataone *data = self.dataall.historyInfo[indexPath.row];
//    NSMutableDictionary *mudic = [[NSMutableDictionary alloc]init];
//    if (data.depDate) {
//        [mudic setValue:data.depDate forKey:@"depDate"];
//    }
//    if (data.depCityCode) {
//        [mudic setValue:data.depCityCode forKey:@"depCityCode"];
//    }
//    if (data.depCityName) {
//        [mudic setValue:data.depCityName forKey:@"depCityName"];
//    }
//    if (data.arrCityCode) {
//        [mudic setValue:data.arrCityCode forKey:@"arrCityCode"];
//    }
//    if (data.arrCityName) {
//        [mudic setValue:data.arrCityName forKey:@"arrCityName"];
//    }
//    if (data.depDate) {
//        [mudic setValue:data.depDate forKey:@"depDate"];
//    }
    NSDictionary *mudic = [data dictionaryValue];
    NSNotification *notification =[NSNotification notificationWithName:RIRHTEXECUTIVEHOMEPAGE object:nil userInfo:mudic];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    rightmainCell *cell = [rightmainCell returnCellWith:tableView];
    cell.data = self.dataall.historyInfo[indexPath.row];
    return  cell;
}

- (void)btnCloseSelf{
    [[NSNotificationCenter defaultCenter] postNotificationName:Closetherightinterface object:nil];
}

- (void)btnrightClick:(UIButton *)btn{
    NSLog(@"btnrightClick");
    if (self.dataall.historyInfo.count) {
        __weak typeof(self) weakSelf = self;
        [[TWClient sharedInstance]CleanFlightQuerysuccess:^(id dataDict, NSString *msg, NSInteger code) {
            [MBProgressHUD showSuccess:@"删除成功" toView:weakSelf];
            weakSelf.dataall = nil;
            weakSelf.tableView.mj_footer.hidden = YES;
            [weakSelf.tableView reloadData];
            weakSelf.noecord.hidden = NO;
            weakSelf.noecord.promptMsg = @"暂无搜索记录";
        } failure:^(NSInteger errorCode, NSString *msg) {
            [MBProgressHUD showError:msg toView:weakSelf];
        }];
    }else{
        [MBProgressHUD showSuccess:@"暂无搜索记录" toView:self];
    }
}
- (void)mjreflushdata{
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf shuxingshujudata:YES];
    }];
    [self.tableView.mj_header beginRefreshing];
    
    // 上拉刷新
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 增加10条数据
        [weakSelf shuxingshujudata:NO];
    }];
    // 默认先隐藏footer
    self.tableView.mj_footer.hidden = YES;
}
- (void)shuxingshujudata:(BOOL)isfreshing{
    if (isfreshing) {
        self.pageNo = @"1";
    }
    __weak typeof(self) weakSelf = self;
    [[TWClient sharedInstance]FlightQueryHistoryWithpageNo:weakSelf.pageNo success:^(id dataDict, NSString *msg, NSInteger code) {
        NSInteger tmp = [weakSelf.pageNo integerValue];
        weakSelf.pageNo = [NSString stringWithFormat:@"%ld",(long)++tmp];
        
        if (isfreshing) {   //是刷新
            weakSelf.dataall = [MTLJSONAdapter modelOfClass:[rithtFlirhtdata class] fromJSONDictionary:dataDict error:nil];
        } else {
            rithtFlirhtdata *data = [MTLJSONAdapter modelOfClass:[rithtFlirhtdata class] fromJSONDictionary:dataDict error:nil];
            [weakSelf.dataall.historyInfo addObjectsFromArray:data.historyInfo];
            weakSelf.dataall.hasMore = data.hasMore;
        }

        if (weakSelf.tableView.mj_footer.isRefreshing) {
            [weakSelf.tableView.mj_footer endRefreshing];
        }
        if (weakSelf.tableView.mj_header.isRefreshing) {
            [weakSelf.tableView.mj_header endRefreshing];
        }

        if (!weakSelf.dataall.historyInfo.count) {  //无数据
            weakSelf.noecord.hidden = NO;
            weakSelf.noecord.promptMsg = @"暂无搜索记录";
            weakSelf.tableView.mj_footer.hidden = YES;
        }else{
            [weakSelf.tableView reloadData];
            weakSelf.tableView.mj_footer.hidden = NO;
            if ([weakSelf.dataall.hasMore isEqualToString:@"0"]) {
                [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
            } else {
                [weakSelf.tableView.mj_footer  resetNoMoreData];
            }
        }
    } failure:^(NSInteger errorCode, NSString *msg) {
        [weakSelf.tableView.mj_header endRefreshing];
        [MBProgressHUD showError:msg toView:weakSelf];
    }];
}
- (noRecord *)noecord{
    if (!_noecord) {
        noRecord *tmp = [[noRecord alloc]init];
        [self addSubview:tmp];
        [tmp mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@100);
            make.height.equalTo(@90);
            make.centerX.equalTo(self);
            make.centerY.equalTo(self);
        }];
        tmp.hidden = YES;
        _noecord = tmp;
    }
    return _noecord;
}
@end
