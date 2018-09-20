/************************************************************
 *  * Hyphenate CONFIDENTIAL
 * __________________
 * Copyright (C) 2016 Hyphenate Inc. All rights reserved.
 *
 * NOTICE: All information contained herein is, and remains
 * the property of Hyphenate Inc.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from Hyphenate Inc.
 */

#import "ConversationListController.h"
#import "NSString+add.h"
#import "ChatViewController.h"


#import "GlobalObject.h"
#import "ChatDemoHelper.h"
#import "HeaderTotal.h"

@interface ConversationListController ()<EaseConversationListViewControllerDelegate, EaseConversationListViewControllerDataSource>
@property (nonatomic,weak) UIImageView *image1;
@property (nonatomic,weak) UIImageView *image2;
@property (nonatomic,weak) UILabel *nomsg;
@end

@implementation ConversationListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的消息";
    // Do any additional setup after loading the view.
    self.showRefreshHeader = YES;
    self.delegate = self;
    self.dataSource = self;
    self.tableView.backgroundColor = ColorBigBack;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self tableViewDidTriggerHeaderRefresh];
    
    self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);

    [self removeEmptyConversationsFromDB];
    [self _setupBarButtonItem];
    [self customBackButton];
}

#pragma mark - setup subviews

- (void)_setupBarButtonItem
{
    NSString *str = @"清除所有";
    CGFloat tmpWidth = [NSString returnSizeWidthWithString:str font:12];
    UIButton *clearButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, tmpWidth, 44)];
    [clearButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [clearButton setTitle:str forState:UIControlStateNormal];
    clearButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [clearButton addTarget:self action:@selector(deleteAllLISTMessages:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:clearButton];
}
- (void)deleteAllLISTMessages:(UIButton *)btn{
//    for (EaseConversationModel *model in self.dataArray) {
//        [[EMClient sharedClient].chatManager deleteConversation:model.conversation.conversationId deleteMessages:YES];
//        [self.dataArray removeObject:model];
//    }
//    [self refresh];
    
    NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];
    if (conversations.count) {
        NSMutableArray *needRemoveConversations;
        for (EMConversation *conversation in conversations) {
            if (conversation.type == EMConversationTypeChat) {
                if (!needRemoveConversations) {
                    needRemoveConversations = [[NSMutableArray alloc] initWithCapacity:0];
                }
                [needRemoveConversations addObject:conversation];
            }
        }
        if (needRemoveConversations && needRemoveConversations.count > 0) {
            [[EMClient sharedClient].chatManager deleteConversations:needRemoveConversations deleteMessages:YES];
            [self refreshDataSource];
            [MBProgressHUD showSuccess:@"清除成功" toView:self.view];
        }
        self.image1.hidden = YES;
        self.image2.hidden = YES;
        self.nomsg.hidden = YES;
        [self.image1 removeFromSuperview];
        [self.image2 removeFromSuperview];
        [self.nomsg removeFromSuperview];
    }else{
//        [MBProgressHUD showError:@"您当前没有会话" toView:self.view];
        self.image1.hidden = NO;
        self.image2.hidden = NO;
        self.nomsg.hidden = NO;
    }
}
- (void)viewWillAppear:(BOOL)animated
{
    NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];
    if (!conversations.count) {
        self.image1.hidden = NO;
        self.image2.hidden = NO;
        self.nomsg.hidden = NO;
//        [MBProgressHUD showError:@"您当前没有会话" toView:self.view];
    }else{
        self.image1.hidden = YES;
        self.image2.hidden = YES;
        self.nomsg.hidden = YES;
        [self.image1 removeFromSuperview];
        [self.image2 removeFromSuperview];
        [self.nomsg removeFromSuperview];
    }
    [super viewWillAppear:animated];
    [self refresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)removeEmptyConversationsFromDB
{
    NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];
    NSMutableArray *needRemoveConversations;
    for (EMConversation *conversation in conversations) {
        if (!conversation.latestMessage || (conversation.type == EMConversationTypeChatRoom)) {
            if (!needRemoveConversations) {
                needRemoveConversations = [[NSMutableArray alloc] initWithCapacity:0];
            }
            
            [needRemoveConversations addObject:conversation];
        }
    }
    
    if (needRemoveConversations && needRemoveConversations.count > 0) {
        [[EMClient sharedClient].chatManager deleteConversations:needRemoveConversations deleteMessages:YES];
    }
}



#pragma mark - EaseConversationListViewControllerDelegate

- (void)conversationListViewController:(EaseConversationListViewController *)conversationListViewController
            didSelectConversationModel:(id<IConversationModel>)conversationModel
{
    if (conversationModel) {
        EMConversation *conversation = conversationModel.conversation;
        if (conversation) {
            ChatViewController *chatController = [[ChatViewController
                                                   alloc]
                                                      initWithConversationChatter:conversation.conversationId conversationType:conversation.type];
                chatController.title = conversationModel.title;
            EaseConversationModel *tmp = (EaseConversationModel *)conversationModel;
            
            chatController.EachOtherName = tmp.title;
            chatController.headImage = tmp.avatarImage;
            chatController.HeadOfTheOtherSide = tmp.avatarURLPath;
            chatController.mobie = tmp.moblie;
            [self.navigationController pushViewController:chatController animated:YES];
            
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"setupUnreadMessageCount" object:nil];
        [self.tableView reloadData];
    }
}

#pragma mark - EaseConversationListViewControllerDataSource

- (id<IConversationModel>)conversationListViewController:(EaseConversationListViewController *)conversationListViewController
                                    modelForConversation:(EMConversation *)conversation
{
    EaseConversationModel *model = [[EaseConversationModel alloc] initWithConversation:conversation];
//    if (model.conversation.type == EMConversationTypeChat) {
//
//
//        
//    }
    if (![model.conversation.conversationId isEqualToString:@"kefu"]) {
//        contactsArry *haoyouArry = [NSKeyedUnarchiver unarchiveObjectWithFile:ZEJIKEMISHUPATH];
//        for (TakeAndContact *dataa in haoyouArry.contacts) {
//            if ([dataa.easemobId isEqualToString:model.conversation.conversationId]) {
//                model.title = dataa.name;
//                model.avatarURLPath = dataa.avatar;
//            }
//        }
//        if (!model.avatarURLPath || !model.title) {
//            NSDictionary *dic = model.conversation.latestMessageFromOthers.ext[@"weichat"][@"visitor"];
//            if (dic) {
//                model.title = dic[@"userNickname"];
//                model.avatarURLPath = dic[HXAVATAR];
//                model.moblie = dic[@"phone"];
//            }
//        }
        
        if (!model.avatarURLPath || !model.title) {
            NSLog(@"model.conversation.conversationId=%@",model.conversation.conversationId);
            [[TWClient sharedInstance]REQUESTURLgetEasemobInfoWitheasemobId:model.conversation.conversationId success:^(id dataDict, NSString *msg, NSInteger code) {
                EasemobInfo *info = [MTLJSONAdapter modelOfClass:[EasemobInfo class] fromJSONDictionary:dataDict error:nil];
                
                model.title = info.nikename;
                model.moblie = info.mobile;
                if (!info.avatar) {
                    model.avatarImage = [UIImage imageNamed:@"chatListCellHead"];
                } else {
                    model.avatarURLPath = info.avatar;
                }
                NSLog(@"OK");
                [self.tableView reloadData];
            } failure:^(NSInteger errorCode, NSString *msg) {
                NSLog(@"Fail");
            }];
        }
    } else {
//        kefuInfo *datawa  = [NSKeyedUnarchiver unarchiveObjectWithFile:ZEJIKEFUInfoPATH];
//        if (datawa.avatar ) {
//            datawa.avatar = [@"http:" stringByAppendingString:datawa.avatar];
//            datawa.avatar = [datawa.avatar stringByReplacingOccurrencesOfString:@"|300h_300w|" withString:@""];
//        }
//        model.title = datawa.userNickname;
//        model.avatarURLPath = datawa.avatar;
        model.title = @"在线客服";
        model.avatarImage = [UIImage imageNamed:@"客服头像"];
        dicmenuArray *dataaaleft = [NSKeyedUnarchiver unarchiveObjectWithFile:LEFTDATA];
        model.moblie = dataaaleft.customerServicePhone;
        
//        [[TWClient sharedInstance]qryContactWitheasemobId:@"2cbf2bfabf6d46ab93ab108acda21289" success:^(id dataDict, NSString *msg, NSInteger code) {
//            NSString *name = dataDict[@"name"];
//            if ([name isKindOfClass:[NSNull class]] || !name || !name.length) {
//                name = dataDict[@"mobile"];
//            }
//            model.title = name;
//            
//            NSString *avatar = dataDict[@"avatar"];
//            if ([avatar isKindOfClass:[NSNull class]] || !avatar || !avatar.length) {
//                model.avatarImage = [UIImage imageNamed:@"chatListCellHead"];
//            } else {
//                model.avatarURLPath = avatar;
//            }
//            NSLog(@"OK");
//        } failure:^(NSInteger errorCode, NSString *msg) {
//            NSLog(@"Fail");
//        }];
    }

    return model;
}

- (NSAttributedString *)conversationListViewController:(EaseConversationListViewController *)conversationListViewController
      latestMessageTitleForConversationModel:(id<IConversationModel>)conversationModel
{
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:@""];
    EMMessage *lastMessage = [conversationModel.conversation latestMessage];
    if (lastMessage) {
        NSString *latestMessageTitle = @"";
        EMMessageBody *messageBody = lastMessage.body;
        switch (messageBody.type) {
            case EMMessageBodyTypeImage:{
                latestMessageTitle = NSLocalizedString(@"message.image1", @"[image]");
            } break;
            case EMMessageBodyTypeText:{
                // 表情映射。
                NSString *didReceiveText = [EaseConvertToCommonEmoticonsHelper
                                            convertToSystemEmoticons:((EMTextMessageBody *)messageBody).text];
                latestMessageTitle = didReceiveText;
                if ([lastMessage.ext objectForKey:MESSAGE_ATTR_IS_BIG_EXPRESSION]) {
                    latestMessageTitle = @"[动画表情]";
                }
            } break;
            case EMMessageBodyTypeVoice:{
                latestMessageTitle = NSLocalizedString(@"message.voice1", @"[voice]");
            } break;
            case EMMessageBodyTypeLocation: {
                latestMessageTitle = NSLocalizedString(@"message.location1", @"[location]");
            } break;
            case EMMessageBodyTypeVideo: {
                latestMessageTitle = NSLocalizedString(@"message.video1", @"[video]");
            } break;
            case EMMessageBodyTypeFile: {
                latestMessageTitle = NSLocalizedString(@"message.file1", @"[file]");
            } break;
            default: {
            } break;
        }
        
        if (lastMessage.direction == EMMessageDirectionReceive) {
//            NSString *from = lastMessage.from;
//
//            latestMessageTitle = [NSString stringWithFormat:@"%@: %@", from, latestMessageTitle];
        }
        
        NSDictionary *ext = conversationModel.conversation.ext;
        if (ext && [ext[kHaveUnreadAtMessage] intValue] == kAtAllMessage) {
            latestMessageTitle = [NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"group.atAll", nil), latestMessageTitle];
            attributedStr = [[NSMutableAttributedString alloc] initWithString:latestMessageTitle];
            [attributedStr setAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:1.0 green:.0 blue:.0 alpha:0.5]} range:NSMakeRange(0, NSLocalizedString(@"group.atAll", nil).length)];
            
        }
        else if (ext && [ext[kHaveUnreadAtMessage] intValue] == kAtYouMessage) {
            latestMessageTitle = [NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"group.atMe", @"[Somebody @ me]"), latestMessageTitle];
            attributedStr = [[NSMutableAttributedString alloc] initWithString:latestMessageTitle];
            [attributedStr setAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:1.0 green:.0 blue:.0 alpha:0.5]} range:NSMakeRange(0, NSLocalizedString(@"group.atMe", @"[Somebody @ me]").length)];
        }
        else {
            if ([GlobalObject attributedStringWithTextYE:latestMessageTitle]) {
                attributedStr = [[GlobalObject attributedStringWithText:latestMessageTitle]mutableCopy];
            } else {
                attributedStr = [[NSMutableAttributedString alloc] initWithString:latestMessageTitle];
            }
        }
    }
    return attributedStr;
}

- (NSString *)conversationListViewController:(EaseConversationListViewController *)conversationListViewController
       latestMessageTimeForConversationModel:(id<IConversationModel>)conversationModel
{
    NSString *latestMessageTime = @"";
    EMMessage *lastMessage = [conversationModel.conversation latestMessage];;
    if (lastMessage) {
        latestMessageTime = [NSDate formattedTimeFromTimeInterval:lastMessage.timestamp];
    }

    
    return latestMessageTime;
}

#pragma mark - UISearchBarDelegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
    
    return YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{

}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.text = @"";

    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
}

#pragma mark - public

-(void)refresh
{
    [self refreshAndSortView];
}

-(void)refreshDataSource
{
    [self tableViewDidTriggerHeaderRefresh];
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
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

    [self.tableView reloadData];
}
- (UIImageView *)image1{
    if (!_image1) {
        UIImageView *image = [[UIImageView alloc]init];
        image.image = [UIImage imageNamed:@"niao"];
        [self.view addSubview:image];
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.bottom.equalTo(self.view.mas_centerY);
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
        image.text = @"没有消息哦";
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

- (void)dealloc{
    NSLog(@"%s",__func__);
}
@end
