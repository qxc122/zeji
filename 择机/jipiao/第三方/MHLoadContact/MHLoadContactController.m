//
//  MHLoadContactController.m
//  读取通讯录
//
//  Created by LMH on 16/2/23.
//  Copyright © 2016年 LMH. All rights reserved.
//

#import "MHLoadContactController.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "MHContactCell.h"
#import "MHContactModel.h"
#import "pinyin.h"
#import "subContactTableViewController.h"
#import "XAlertView.h"


@interface MHLoadContactController ()
/** 所有联系人 */
@property (strong, nonatomic) NSMutableArray *dataSource;
/** 排序后所有联系人 */
@property (strong, nonatomic) NSMutableArray *userSource;

@property (strong, nonatomic) NSMutableArray *numArray;
@property (strong, nonatomic) NSMutableDictionary *dict;

@property (nonatomic,assign) UIWebView *callWebView;
@end

@implementation MHLoadContactController
- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray new];
    }
    return _dataSource;
}

- (NSMutableArray *)userSource
{
    if (!_userSource) {
        _userSource = [NSMutableArray new];
    }
    return _userSource;
}

- (NSMutableArray *)numArray
{
    if (!_numArray) {
        _numArray = [NSMutableArray new];
    }
    return _numArray;
}

- (NSMutableDictionary *)dict
{
    if (!_dict) {
        _dict = [NSMutableDictionary new];
    }
    return _dict;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"通讯录";
    [self customNavigationBar];
    [self customBackButton];
    self.tableView.bounces = NO;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"img_home_base"]];
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    //更改索引的背景颜色:
    self.tableView.sectionIndexColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    ABAuthorizationStatus status = ABAddressBookGetAuthorizationStatus();
    //判断授权状态
    
    if (status == kABAuthorizationStatusNotDetermined) {
        
        ABAddressBookRef book = ABAddressBookCreateWithOptions(NULL, NULL);
        
        ABAddressBookRequestAccessWithCompletion(book, ^(bool granted, CFErrorRef error) {
            
            if (granted) {
                //查找所有联系人
                [self address];
                
            }else
            {
                NSLog(@"授权失败");
                [self noJurisdictionDoingWithTitle:@"授权失败" message:@"去设置"];
            }
        });
    }else if (status == kABAuthorizationStatusAuthorized)
    {
        //已授权
        [self address];
    }else{
        [self noJurisdictionDoingWithTitle:@"没有打开通讯录的权限" message:@"去设置"];
    }
}
- (void)noJurisdictionDoingWithTitle:(NSString *)title message:(NSString *)message{
//    XAlertView *tmp = [[XAlertView alloc]initWithTitle:title message:message clickedBlock:^(XAlertView *alertView, BOOL canceled, NSInteger clickedIndex) {
//        if (canceled) {
//            [self popSelf];
//        }else{
//            NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
//            if([[UIApplication sharedApplication] canOpenURL:url]) {
//                [[UIApplication sharedApplication] openURL:url];
//            }
//        }
//    } cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//    [tmp show];
    
    kWeakSelf(self);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [weakself popSelf];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}
//UITableView数据源和代理方法
#pragma mark - 设置section的行数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.userSource.count;
}
#pragma mark - 设置section的头部高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
#pragma mark - 设置cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
#pragma mark - 设置section显示的内容
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSDictionary *dic = [self.userSource objectAtIndex:section];
    NSNumber *num = [[dic allKeys] lastObject];
    char *a = (char *)malloc(2);
    sprintf(a, "%c", [num charValue]);
    NSString *str = [[NSString alloc] initWithUTF8String:a];

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 30)];
    //label.textColor = [UIColor whiteColor];
    label.text = [@"    " stringByAppendingString:str];
    label.textAlignment = NSTextAlignmentLeft;
    //label.backgroundColor = [UIColor groupTableViewBackgroundColor];
    label.backgroundColor = [UIColor whiteColor];
    //label.backgroundColor = [UIColor colorWithRed:64/225.0 green:68/225.0 blue:83/255.0 alpha:1];
    return label;
}
#pragma mark - 设置每个section里的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *dic = [self.userSource objectAtIndex:section];
    NSArray *array = [[dic allValues] firstObject];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MHContactCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHContactCell class])];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([MHContactCell class]) owner:self options:nil].lastObject;;
    }
    NSDictionary *dic = [self.userSource objectAtIndex:indexPath.section];
    NSArray *array = [[dic allValues] lastObject];
    MHContactModel *model = [array objectAtIndex:indexPath.row];

    NSString *name = model.name;
    NSString *tel = model.telArray.firstObject;

    cell.nameLabel.text = name.length == 0 ?@"无":name;
    cell.numLabel.text = tel.length == 0 ?@"无":tel;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 选中后立即取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSDictionary *dict = [self.userSource objectAtIndex:indexPath.section];
    NSArray *array = [[dict allValues] lastObject];
    MHContactModel *model = [array objectAtIndex:indexPath.row];

    if (model.telArray.count>1) {
        subContactTableViewController *Vc = [[subContactTableViewController alloc]init];
        Vc.model = model;
        Vc.NotificationName = self.NotificationName;
        [self.navigationController pushViewController:Vc animated:YES];
    }else{
        NSString *name = model.name;
        NSString *tel = model.telArray.firstObject;//暂时取第一个号码
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
}

#pragma mark - 获取通讯录里联系人姓名和手机号
- (void)address
{
    //新建一个通讯录类
    ABAddressBookRef addressBooks = nil;
    
    addressBooks =  ABAddressBookCreateWithOptions(NULL, NULL);
    //获取通讯录权限
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    
    ABAddressBookRequestAccessWithCompletion(addressBooks, ^(bool granted, CFErrorRef error){
        dispatch_semaphore_signal(sema);
    });
    
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    
    if (ABAddressBookGetAuthorizationStatus() != kABAuthorizationStatusAuthorized) {
        return;
    }
    
    //获取通讯录中的所有人
    CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBooks);
    //通讯录中人数
    CFIndex nPeople = ABAddressBookGetPersonCount(addressBooks);
    
    //循环，获取每个人的个人信息
    for (NSInteger i = 0; i < nPeople; i++) {
        
        //新建一个addressBook model类
        MHContactModel *addressBook = [[MHContactModel alloc] init];
        addressBook.telArray = [NSMutableArray new];
        //获取个人
        ABRecordRef person = CFArrayGetValueAtIndex(allPeople, i);
        //获取个人名字
        CFTypeRef abName = ABRecordCopyValue(person, kABPersonFirstNameProperty);
        CFTypeRef abLastName = ABRecordCopyValue(person, kABPersonLastNameProperty);
        CFStringRef abFullName = ABRecordCopyCompositeName(person);
        NSString *nameString = (__bridge NSString *)abName;
        NSString *lastNameString = (__bridge NSString *)abLastName;
        
        if ((__bridge id)abFullName != nil) {
            nameString = (__bridge NSString *)abFullName;
        }
        else {
            if ((__bridge id)abLastName != nil) {
                nameString = [NSString stringWithFormat:@"%@ %@", nameString, lastNameString];
            }
        }
        addressBook.name = nameString;
        
        ABPropertyID multiProperties[] = {
            kABPersonPhoneProperty,
            kABPersonEmailProperty
        };
        NSInteger multiPropertiesTotal = sizeof(multiProperties) / sizeof(ABPropertyID);
        for (NSInteger j = 0; j < multiPropertiesTotal; j++) {
            ABPropertyID property = multiProperties[j];
            ABMultiValueRef valuesRef = ABRecordCopyValue(person, property);
            NSInteger valuesCount = 0;
            if (valuesRef != nil) valuesCount = ABMultiValueGetCount(valuesRef);
            
            if (valuesCount == 0) {
                CFRelease(valuesRef);
                continue;
            }
            //获取电话号码和email
            for (NSInteger k = 0; k < valuesCount; k++) {
                CFTypeRef value = ABMultiValueCopyValueAtIndex(valuesRef, k);
                switch (j) {
                    case 0: {// Phone number
                        NSString *tel = (__bridge NSString*)value;
                        
                        //以下5行请勿删除,请勿修改,隐形代码,删改后果自负
                        tel = [tel stringByReplacingOccurrencesOfString:@"(" withString:@""];
                        tel = [tel stringByReplacingOccurrencesOfString:@")" withString:@""];
                        tel = [tel stringByReplacingOccurrencesOfString:@"-" withString:@""];
                        tel = [tel stringByReplacingOccurrencesOfString:@" " withString:@""];
                        tel = [tel stringByReplacingOccurrencesOfString:@" " withString:@""];
                        
                        [addressBook.telArray addObject:tel];
                        break;
                    }
                }
                CFRelease(value);
            }
            CFRelease(valuesRef);
        }
        //将个人信息添加到数组中，循环完成后addressBookTemp中包含所有联系人的信息
        [self.dataSource addObject:addressBook];
        
        if (abName) CFRelease(abName);
        if (abLastName) CFRelease(abLastName);
        if (abFullName) CFRelease(abFullName);
    }
    
    //整理数据
    [self sortDatas];
}

#pragma mark - 把联系人按字母排序整理
- (void)sortDatas
{
    //处理(中文姓名 或 字母开头姓名)的联系人
    for (char i = 'A'; i<='Z'; i++) {
        
        NSMutableArray *numArray = [[NSMutableArray alloc] init];
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        
        for (int j = 0; j < self.dataSource.count; j++) {
            MHContactModel *model = [self.dataSource objectAtIndex:j];

            //获取姓名首位
            NSString *string = [model.name substringWithRange:NSMakeRange(0, 1)];
            //将姓名首位转换成NSData类型
            NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
            //data的长度大于等于3说明姓名首位是汉字
            if (data.length >= 3)
            {
                //将汉字首字母拿出
                char a = pinyinFirstLetter([model.name characterAtIndex:0]);
                
                //将小写字母转成大写字母
                char b = a - 32;
                
                if (b == i) {
                    [numArray addObject:model];
                    [dict setObject:numArray forKey:[NSNumber numberWithChar:i]];
                }
            }
            else {
                //data的长度等于1说明姓名首位是字母或者数字
                if (data.length == 1) {
                    //判断姓名首位是否位小写字母
                    NSString * regex = @"^[a-z]$";
                    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
                    BOOL isMatch = [pred evaluateWithObject:string];
                    if (isMatch == YES) {
                        //NSLog(@"这是小写字母");
                        
                        //把大写字母转换成小写字母
                        char j = i+32;
                        //数据封装成NSNumber类型
                        NSNumber *num = [NSNumber numberWithChar:j];
                        //给a开空间，并且强转成char类型
                        char *a = (char *)malloc(2);
                        //将num里面的数据取出放进a里面
                        sprintf(a, "%c", [num charValue]);
                        //把c的字符串转换成oc字符串类型
                        NSString *str = [[NSString alloc]initWithUTF8String:a];
                        
                        if ([string isEqualToString:str]) {
                            [numArray addObject:model];
                            [dict setObject:numArray forKey:[NSNumber numberWithChar:i]];
                        }
                        
                    }
                    else {
                        //判断姓名首位是否为大写字母
                        NSString * regexA = @"^[A-Z]$";
                        NSPredicate *predA = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexA];
                        BOOL isMatchA = [predA evaluateWithObject:string];
                        
                        if (isMatchA == YES) {
                            //NSLog(@"这是大写字母");
                            
                            NSNumber *num = [NSNumber numberWithChar:i];
                            //给a开空间，并且强转成char类型
                            char *a = (char *)malloc(2);
                            //将num里面的数据取出放进a里面
                            sprintf(a, "%c", [num charValue]);
                            //把c的字符串转换成oc字符串类型
                            NSString *str = [[NSString alloc]initWithUTF8String:a];
                            
                            if ([string isEqualToString:str]) {
                                [numArray addObject:model];
                                [dict setObject:numArray forKey:[NSNumber numberWithChar:i]];
                            }
                        }
                    }
                }
            }
        }
        
        if (dict.count != 0) {
            [self.userSource addObject:dict];
        }
    }
    
    //处理(无姓名 或 数字开头姓名)的联系人
    char n = '#';
    int cont = 0;
    for (int j = 0; j< self.dataSource.count; j++) {
        
        MHContactModel *model = [self.dataSource objectAtIndex:j];
        //获取姓名的首位
        NSString *string = [model.name substringWithRange:NSMakeRange(0, 1)];
        //将姓名首位转化成NSData类型
        NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
        
        //判断data的长度是否小于3
        if (data.length < 3) {
            if (cont == 0) {
                cont++;
            }
            if (data.length == 1) {
                //判断首位是否为数字
                NSString * regexs = @"^[0-9]$";
                NSPredicate *preds = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexs];
                BOOL isMatch = [preds evaluateWithObject:string];
                if (isMatch == YES) {
                    //如果姓名为数字
                    [self.numArray addObject:model];
                    [self.dict setObject:self.numArray forKey:[NSNumber numberWithChar:n]];
                }
            }
            else {
                //如果姓名为空
                model.name = @"无";
                if (model.telArray.count != 0) {
                    [self.numArray addObject:model];
                    [self.dict setObject:self.numArray forKey:[NSNumber numberWithChar:n]];
                }
            }
        }
    }
    if (self.dict.count != 0) {
        [self.userSource addObject:self.dict];
    }
    
    //主线程刷新UI
    [self performSelectorOnMainThread:@selector(updateUI) withObject:nil waitUntilDone:NO];
}

#pragma mark - 刷新UI
- (void)updateUI
{
    [self.tableView reloadData];
}

#pragma mark - 索引
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    //便立构造器
    for (NSDictionary *dict in self.userSource) {
        //将取出来的数据封装成NSNumber类型
        NSNumber *num = [[dict allKeys] lastObject];
        //给a开空间，并且强转成char类型
        char *a = (char *)malloc(2);
        //将num里面的数据取出放进a里面
        sprintf(a, "%c", [num charValue]);
        //把c的字符串转换成oc字符串类型
        NSString *str = [[NSString alloc]initWithUTF8String:a];
        [array addObject:str];
    }
    
    return array;
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    NSLog(@"%@释放",self);
}
@end
