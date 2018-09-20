//
//  ChooseNationality.m
//  jipiao
//
//  Created by Store on 2017/5/16.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "ChooseNationality.h"
#import "ChooseNationalityCell.h"
#import "ChooseNationalityHead.h"
@interface ChooseNationality ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (nonatomic,weak) UITableView *tableView;
//@property (nonatomic,assign) NSInteger PageNumber;
//@property (nonatomic,assign) NSInteger PageSize;
//@property (nonatomic,strong) orderlistS *datess;
//
@property (nonatomic,strong) NSArray *dataArray;
@end

@implementation ChooseNationality

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择国籍";
    // Do any additional setup after loading the view.
    [self setUI];
    
    kWeakSelf(self);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"guojia" ofType:@"json"]];
        
        NSArray *dataArray = [NSJSONSerialization JSONObjectWithData:JSONData options:0 error:nil];
        weakself.dataArray = dataArray;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakself.tableView reloadData];
        });
    });
}
- (void)needRefremydingdangFunc:(NSNotification *)user{
    self.tableView.mj_header.hidden = NO;
    [self.tableView.mj_header beginRefreshing];
}
- (void)setUI{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    //tableView.bounces = NO;
    //    tableView.tableHeaderView = cycleScrollView3;
//    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view);
        make.left.equalTo(self.view);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(0);
    }];
    
    [tableView registerClass:[ChooseNationalityCell class] forCellReuseIdentifier:NSStringFromClass([ChooseNationalityCell class])];
    
    if ([self.tableView respondsToSelector:@selector(setSectionIndexColor:)]) {
        /** 背景色 */
        self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
        /** 字体颜色 */
        self.tableView.sectionIndexColor = ColorWithHex(0xFFFFFF, 0.3);
    }
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//UIScrollView也适用
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
//    [self MJRefreshHead];
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] init];
}


//#pragma -mark<MJ_head加载数据  头部>
//- (void)MJRefreshHead{
//    __weak typeof(self) weakSelf = self;
//    //下拉刷新
//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        
//    }];
//    [self.tableView.mj_header beginRefreshing];
//}

#pragma --mark< UITableViewDelegate 高>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    kWeakSelf(self);
    return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([ChooseNationalityCell class]) configuration:^(ChooseNationalityCell *cell) {
        [weakself configureChooseNationalityCell:cell atIndexPath:indexPath];
    }];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    ChooseNationalityHead *head = [ChooseNationalityHead new];
    NSDictionary *tmp = self.dataArray[section];
    NSArray *tmpTwo = [tmp allKeys];
    head.headStr = [tmpTwo firstObject];
    head.headStr = [head.headStr uppercaseString];
    return head;
}
#pragma --mark<配置cell>
- (void)configureChooseNationalityCell:(ChooseNationalityCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *tmp = self.dataArray[indexPath.section];
    NSArray *tmpTwo = [tmp allValues];
    NSArray *tmpThree = [tmpTwo firstObject];
    if (tmpTwo.count) {
        NSDictionary *ttt= tmpThree[indexPath.row];
//        countryCode = TR;
//        countryName = "\U571f\U8033\U5176";
        cell.headStr = ttt[@"countryName"];
    }
}
#pragma mark 右侧索引
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *tmp = [NSMutableArray array];
    for (NSDictionary *dic in self.dataArray) {
        NSArray *tmpTwo = [dic allKeys];
        [tmp addObjectsFromArray:tmpTwo];
    }
    return tmp;
}

//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
//    // In IOS 7 all index of the items are clumped together in the middle,
//    // making the items difficult to tap.
//    // As workaround we added "fake" sections index
//    // reference: http://stackoverflow.com/questions/18923729/uitableview-section-index-spacing-on-ios-7
//    if ([title isEqualToString:@" "]){
//        return -1;
//    }
//    return index;
//}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 31;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
#pragma -mark<UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSDictionary *tmp = self.dataArray[section];
    NSArray *tmpTwo = [tmp allValues];
    NSInteger cout=0;
    for (NSArray *ttt in tmpTwo) {
        cout += ttt.count;
    }
    return cout;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
#pragma --mark< 点击了  cell >
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.ChoseOK) {
        NSDictionary *tmp = self.dataArray[indexPath.section];
        NSArray *tmpTwo = [tmp allValues];
        NSArray *tmpThree = [tmpTwo firstObject];
        if (tmpTwo.count) {
            NSDictionary *ttt= tmpThree[indexPath.row];
            self.ChoseOK(ttt);
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}
#pragma --mark< 创建cell >
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChooseNationalityCell *cell = [ChooseNationalityCell returnCellWith:tableView];
    [self configureChooseNationalityCell:cell atIndexPath:indexPath];
    return  cell;
}

#pragma --<空白页处理>
//- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView{
//    UIView *tmp = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth)];
//    tmp.backgroundColor = [UIColor redColor];
//    [scrollView addSubview:tmp];
//    [tmp mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.tableView);
//        make.right.equalTo(self.tableView);
//        make.top.equalTo(self.tableView);
//        make.bottom.equalTo(self.tableView);
//    }];
//    return tmp;
//}


- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    if (self.empty_type == fail_empty_num) {
        return [UIImage imageNamed:@""]; //加载失败图片
    }
    return nil;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    if (self.empty_type == fail_empty_num) {
        NSString *text = @"服务器开小差了，刷新一下吧";
        
        NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:14.0f],
                                     NSForegroundColorAttributeName: [UIColor darkGrayColor]};
        
        return [[NSAttributedString alloc] initWithString:text attributes:attributes];
    }
    return nil;
}


- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text;
    NSDictionary *attributes;
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;

        text = @"点击重新加载";
        attributes = @{NSFontAttributeName: PingFangSC_Regular(17),
                       NSForegroundColorAttributeName: ColorWithHex(0x779CF4, 1.0),
                       NSParagraphStyleAttributeName: paragraph};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

//按钮文本或者背景样式

//- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
//    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:17.0f]};
//
//    return [[NSAttributedString alloc] initWithString:@"Continue 点击继续" attributes:attributes];
//}
//
//- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
//    return [UIImage imageNamed:@"123"];
//}

//空白页的背景色

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIColor clearColor];
}

//是否显示空白页，默认YES
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return YES;
}

//空白页点击事件
- (void)emptyDataSetDidTapView:(UIScrollView *)scrollView {
    if (self.empty_type == fail_empty_num) {
        self.tableView.mj_header.hidden = NO;
        [self.tableView.mj_header beginRefreshing];
    }
}


//- (CGPoint)offsetForEmptyDataSet:(UIScrollView *)scrollView{
//    return CGPointMake(300, 10);
//}
//- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
//    return -100;
//}

//- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView{
//    return 15;
//}

@end
