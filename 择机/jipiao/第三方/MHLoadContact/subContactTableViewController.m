//
//  subContactTableViewController.m
//  读取通讯录
//
//  Created by Store on 16/10/24.
//  Copyright © 2016年 hcl. All rights reserved.
//

#import "subContactTableViewController.h"
#import "MHContactCell.h"
//#import "DefineUI.h"


@interface subContactTableViewController ()

@end

@implementation subContactTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.bounces = NO;
    self.tableView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"img_home_base"]];
    //self.tableView.backgroundColor = [UIColor clearColor];
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    
    [self.tableView setTableFooterView:view];
    [self customNavigationBar];
    [self customBackButton];
    self.title = self.model.name;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.model.telArray.count;
}
#pragma mark - 设置cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MHContactCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHContactCell class])];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([MHContactCell class]) owner:self options:nil].lastObject;;
    }

    
    NSString *name = self.model.name;
    NSString *tel = self.model.telArray[indexPath.row];
    
    cell.nameLabel.text = name.length == 0 ?@"无":name;
    cell.numLabel.text = tel.length == 0 ?@"无":tel;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 选中后立即取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

    NSString *name = self.model.name;
    NSString *tel = self.model.telArray[indexPath.row];//暂时取第一个号码
    name = name.length == 0 ?@"无":name;
    tel = tel.length == 0?@"无":tel;
    
    tel = [tel stringByReplacingOccurrencesOfString:@" " withString:@""];
    tel = [tel stringByReplacingOccurrencesOfString:@"(" withString:@""];
    tel = [tel stringByReplacingOccurrencesOfString:@")" withString:@""];
    tel = [tel stringByReplacingOccurrencesOfString:@"-" withString:@""];
    tel = [tel stringByReplacingOccurrencesOfString:@"+" withString:@""];
    if ([tel hasPrefix:@"86"]) {
        tel = [tel substringFromIndex:2];
    }
    
    NSDictionary *dictTmp = @{@"name":name,@"tel":tel,};
    NSNotification *notification =[NSNotification notificationWithName:self.NotificationName object:nil userInfo:dictTmp];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}
- (void)customNavigationBar
{
    self.navigationController.navigationBar.shadowImage=[UIImage new];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"hanbanchaxun"] forBarMetrics:UIBarMetricsDefault];
    // 1.2设置所有导航条的标题颜色
    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setTintColor:[UIColor whiteColor]];
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    md[NSFontAttributeName] = [UIFont systemFontOfSize:17];
    md[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [navBar setTitleTextAttributes:md];
    
}

- (void)customBackButton
{
    UIImage* image = [[UIImage imageNamed:@"btnpre"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem* leftBarutton = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(popSelf)];
    self.navigationItem.leftBarButtonItem = leftBarutton;
}

- (void)popSelf
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
