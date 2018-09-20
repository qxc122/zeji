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

#import "ChatViewController.h"
#import "EMTextMessageBody.h"
#import "EMMessageBody.h"
#import "toMishu.h"
#import "leftdataamain.h"
#import "CustomMessageCellThree.h"
//#import "UserProfileViewController.h"


#import "ChatDemoHelper.h"

#import "CustomMessageCellOne.h"
#import "EaseCustomMessageCell.h"
#import "CustomMessageCellTwo.h"
#import "HeaderTotal.h"
#import "CusThree.h"
#import "CusXTOne.h"
#import "CusXTTWo.h"
#import "fourKefu.h"
@interface ChatViewController ()<UIAlertViewDelegate,EMClientDelegate>
{
    UIMenuItem *_copyMenuItem;
    UIMenuItem *_deleteMenuItem;
}

@property (nonatomic) BOOL isPlayingAudio;

@property (nonatomic) NSMutableDictionary *emotionDic;
@property (nonatomic, copy) EaseSelectAtTargetCallback selectedCallback;


@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = ColorBigBack;
    self.tableView.backgroundColor = [UIColor clearColor];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ReceivecustomerservicSelector:) name:Receivecustomerserviceordernumber object:nil];
    
    // Do any additional setup after loading the view.
    [[EaseBaseMessageCell appearance] setSendBubbleBackgroundImage:[[UIImage imageNamed:@"sendd"] stretchableImageWithLeftCapWidth:0 topCapHeight:0]];
    [[EaseBaseMessageCell appearance] setRecvBubbleBackgroundImage:[[UIImage imageNamed:@"recevv"] stretchableImageWithLeftCapWidth:0 topCapHeight:0]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(CallPhoneSeclect:)
                                                 name:CallPhone
                                               object:nil];
    self.showRefreshHeader = YES;
    self.delegate = self;
    self.dataSource = self;
    
    [self.chatBarMoreView removeItematIndex:4];
    [self.chatBarMoreView removeItematIndex:3];
    [self.chatBarMoreView removeItematIndex:1];
    
    [self _setupBarButtonItem];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteAllMessages:) name:KNOTIFICATIONNAME_DELETEALLMESSAGE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(exitGroup) name:@"ExitGroup" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(insertCallMessage:) name:@"insertCallMessage" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleCallNotification:) name:@"callOutWithChatter" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleCallNotification:) name:@"callControllerClose" object:nil];
    
    [self customBackButton];
    [self useinfo]; //发送消息给客服或者秘书
    [self setEathNameAndIcon]; //获取对方头像和名字
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    if (self.conversation.type == EMConversationTypeChatRoom)
    {
        //退出聊天室，删除会话
        if (self.isJoinedChatroom) {
            NSString *chatter = [self.conversation.conversationId copy];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                EMError *error = nil;
                [[EMClient sharedClient].roomManager leaveChatroom:chatter error:&error];
                if (error !=nil) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"Leave chatroom '%@' failed [%@]", chatter, error.errorDescription] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                        [alertView show];
                    });
                }
            });
        }
        else {
            [[EMClient sharedClient].chatManager deleteConversation:self.conversation.conversationId deleteMessages:YES];
        }
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[EMClient sharedClient] removeDelegate:self];
    NSLog(@"%s",__func__);
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnable:YES];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[IQKeyboardManager sharedManager] setEnable:NO];
    if (self.conversation.type == EMConversationTypeGroupChat) {
        NSDictionary *ext = self.conversation.ext;
        if ([[ext objectForKey:@"subject"] length])
        {
            self.title = [ext objectForKey:@"subject"];
        }
        
        if (ext && ext[kHaveUnreadAtMessage] != nil)
        {
            NSMutableDictionary *newExt = [ext mutableCopy];
            [newExt removeObjectForKey:kHaveUnreadAtMessage];
            self.conversation.ext = newExt;
        }
    }
//    [self useinfo]; //发送消息给客服或者秘书
//    [self setEathNameAndIcon]; //获取对方头像和名字
    
//    [self gujixiaoxi:@"sdf"];
//    [self tishixiaoxiOne];
//    [self tishixiaoxiTwo];
//    [self tomishuInfo];
}

- (void)setEathNameAndIcon{
    if ([self.conversation.conversationId isEqualToString:@"kefu"]) {    //如果是客服
//        kefuInfo *datawa  = [NSKeyedUnarchiver unarchiveObjectWithFile:ZEJIKEFUInfoPATH];
//        if (datawa.avatar ) {
//            datawa.avatar = [@"http:" stringByAppendingString:datawa.avatar];
//            datawa.avatar = [datawa.avatar stringByReplacingOccurrencesOfString:@"|300h_300w|" withString:@""];
//        }
//        self.EachOtherName = datawa.userNickname;
//        self.HeadOfTheOtherSide = datawa.avatar;
//        if (self.EachOtherName) {
//            self.title = self.EachOtherName;
//        }
        self.EachOtherName = @"在线客服";
//        self.HeadOfTheOtherSide = datawa.avatar;
        self.headImage = [UIImage imageNamed:@"客服头像"];
//        model.title = @"客服";
//        model.avatarImage = [UIImage imageNamed:@"客服头像"];

        dicmenuArray *dataaaleft = [NSKeyedUnarchiver unarchiveObjectWithFile:LEFTDATA];
        self.mobie = dataaaleft.customerServicePhone;
        self.title = self.EachOtherName;
    }else{
//        contactsArry *haoyouArry = [NSKeyedUnarchiver unarchiveObjectWithFile:ZEJIKEMISHUPATH];
//        for (TakeAndContact *dataa in haoyouArry.contacts) {
//            if ([dataa.easemobId isEqualToString:self.conversation.conversationId]) {
//                
//                self.EachOtherName = dataa.name;
//                self.HeadOfTheOtherSide = dataa.avatar;
//                self.title = self.EachOtherName;
//                self.mobie = dataa.mobile;
//            }
//        }
//        if (!self.EachOtherName || !self.HeadOfTheOtherSide) {
//            NSDictionary *dic = self.conversation.latestMessageFromOthers.ext[@"weichat"][@"visitor"];
//            if ([dic isKindOfClass:[NSDictionary class]]) {
//                self.EachOtherName = dic[@"userNickname"];
//                self.mobie = dic[@"phone"];
//                self.HeadOfTheOtherSide = dic[HXAVATAR];
//                if (!self.title) {
//                    self.title = self.EachOtherName;
//                }
//            }
//        }
        
        if (!self.EachOtherName || !self.HeadOfTheOtherSide) {
            NSLog(@"model.conversation.conversationId=%@",self.conversation.conversationId);
            [[TWClient sharedInstance]REQUESTURLgetEasemobInfoWitheasemobId:self.conversation.conversationId success:^(id dataDict, NSString *msg, NSInteger code) {
                EasemobInfo *info = [MTLJSONAdapter modelOfClass:[EasemobInfo class] fromJSONDictionary:dataDict error:nil];
                self.EachOtherName = info.nikename;
                self.HeadOfTheOtherSide = info.avatar;
                if (!self.title) {
                    self.title = self.EachOtherName;
                }
                self.mobie = info.mobile;
                NSLog(@"OK");
            } failure:^(NSInteger errorCode, NSString *msg) {
                NSLog(@"Fail");
            }];
        }
    }
}
- (void)useinfo{
    if (self.info) {
        if ([[self.info allKeys] containsObject:H5MSGMAINqueryHint]){//H5通知首页打电话了 (queryHint=航班信息)
            NSString *mmsg = self.info[H5MSGMAINqueryHint];
         //TODO
//            NSTimeInterval hhh = [[NSString returntimestampChuo]longLongValue];
//            NSArray *tmp = [self.conversation loadMoreMessagesFrom:(hhh-longafteryoucancontactcustomerservice)*1000 to:hhh*1000 maxCount:-1];
//            
//            for (EMMessage *dataMsg in tmp) {
//                EMMessageBody *msgBody = dataMsg.body;
//                EMTextMessageBody *textBody = (EMTextMessageBody *)msgBody;
//                if ([textBody.text rangeOfString:mmsg].location != NSNotFound) {
//                    return;
//                }
//            }
            mmsg = [NSString stringWithFormat:@"我正在查询 %@ 的航班",mmsg];
            [self sendTextMessage:mmsg];
            self.info = nil;
        }else if ([[self.info allKeys] containsObject:H5MSGMAINjsonSt]){//联系客服（带票） jsonSt
            NSString *Jsonstr = self.info[H5MSGMAINjsonSt];
//            NSDictionary *dddic = [NSString dictionaryWithJsonString:Jsonstr];
            
//           NSString * mmsg = [NSString stringWithFormat:@"我正在看 %@到%@ 的航班",dddic[@"depCityName"],dddic[@"arrCityName"]];
//            [self sendTextMessage:mmsg];
//            self.info = nil;
            
            [self gujixiaoxi:Jsonstr];
            
//            NSString *msg2 = ddic[H5MSGMAINeasemoqueryHint];
//            msg2 = [NSString stringWithFormat:@"我正在查询 %@ 的航班",msg2];
//            [self sendTextMessage:msg2];
//            self.info = nil;
        }else if ([[self.info allKeys] containsObject:H5MSGMAINeasemo]){//H5(easemobId=秘书id,queryHint=航班信息)
            NSDictionary *ddic = self.info[H5MSGMAINeasemo];
            NSString *msg2 = ddic[H5MSGMAINeasemoqueryHint];
            msg2 = [NSString stringWithFormat:@"我正在查询 %@ 的航班",msg2];
            [self sendTextMessage:msg2];
            self.info = nil;
        }
    }
}

- (void)tomishuInfo{
    NSDictionary *ddd = @{
                          @"12d1" :@"我正在查询2016年9月1日上海到昆明的航班",
                          @"12d2" :@"20:05~23:50",
                          @"12d3" :@"MU9868（大）",
                          @"12d4" :@"深圳宝安T2 上海浦东T1",
                          @"12d5" :@"20:15~22:50",
                          @"12d6" :@"MU9868（小）",
                          @"12d7" :@"深圳宝安T1 上海浦东T2",
                          };
    NSDictionary *dtmp = @{
                           OrderForMishu:ddd,
                           };
    [self sendTextMessage:@"我正在查询2016年9月1日上海到昆明的航班" withExt:dtmp];
}
- (void)gujixiaoxi:(NSString *)strs{
    NSDictionary *ddic = [NSString dictionaryWithJsonString:strs];
    NSDictionary *extDic = nil;
    NSString *titleMy = nil;
    if ([self.conversation.conversationId isEqualToString:HXkefuID]) {  //客服
        //    NSDictionary *info = @{
        //                           @"title":@"我在看",
        //                           @"desc":@"描叙",
        //                           @"price":@"999¥",
        //                           @"img_url":@"https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=3105518379,1723849651&fm=58",
        //                           @"item_url":@"https://www.baidu.com/",
        //                           @"track":@"track",
        //                           };
        //
        //    NSString *title = [info objectForKey:@"title"];
        //    NSString *desc = [info objectForKey:@"desc"];
        //    NSString *price = [info objectForKey:@"price"];
        //    NSString *imageUrl = [info objectForKey:@"img_url"];
        //    NSString *itemUrl = [info objectForKey:@"item_url"];
        //    NSString *type = [info objectForKey:@"track"];
        
        NSString *str = ddic[@"arrCityName"];
        NSString *str2 = ddic[@"depCityName"];
        if (!str.length && !str2.length) {
            return; //空的返回
        }
        //TODO 要删除  qxc
        //    NSDictionary *ddic = @{
        //        @"airLogo" :@"https://tpurse.tempus.cn/zeji-front/photos/zeji/airline/3U.png",
        //        @"airName": @"东方",
        //        @"arrCityName" : @"衡阳",
        //        @"arrTime" : @"23:40",
        //
        //        @"date" : @"2016-09-14 ",
        //        @"depCityName" : @"深圳",
        //        @"depTime" : @"21:00",
        //        @"flightNo" : @"3500",
        //        @"stopCityName" : @"是对方",
        //        @"track" : @"track",
        //    };
        NSString *title = [NSString stringWithFormat:@"我在看%@ %@到%@ 的航班",ddic[@"depDate"],ddic[@"depCityName"],ddic[@"arrCityName"]];
        NSString *desc = [NSString stringWithFormat:@"%@:%@ %@-%@",ddic[@"airName"],ddic[@"flightNo"],ddic[@"depTime"],ddic[@"arrTime"]];
        NSString *imageUrl = [ddic objectForKey:@"airLogo"];
        NSString *type = @"track";
        
        NSMutableDictionary *itemDic = [NSMutableDictionary dictionary];
        [itemDic setObject:strs forKey:@"titl1e"];
        if (title) {
            [itemDic setObject:title forKey:@"title"];
        }
        if (desc) {
            [itemDic setObject:desc forKey:@"desc"];
        }
        if (imageUrl) {
            [itemDic setObject:imageUrl forKey:@"img_url"];
        }
        
        extDic = @{TSZFTSZF:@{type:itemDic}};
        titleMy = title;
    } else {
        NSDictionary *tmp = @{Myorder:ddic};
//        NSDictionary *tmp = @{Myorder:ddic,@"tesqwet":strs};
//        extDic = ddic;
        extDic = @{@"msgtype":tmp};
        
        titleMy = [NSString stringWithFormat:@"我正在看 %@%@到%@ 的航班",ddic[@"depDate"]?ddic[@"depDate"]:@"",ddic[@"depCityName"],ddic[@"arrCityName"]];
        NSLog(@"sdf");
    }

    EMMessage *message = [EaseSDKHelper sendTextMessage:titleMy
                                                     to:self.conversation.conversationId
                                            messageType:EMChatTypeChat
                                             messageExt:extDic];
    message.chatType = EMChatTypeChat;
    
    
    //    EMTextMessageBody *body = [[EMTextMessageBody alloc] initWithText:@"要发送的消息"];
    //    NSString *from = [[EMClient sharedClient] currentUsername];
    
    //生成Message
    //    EMMessage *message = [[EMMessage alloc] initWithConversationID:@"6001" from:from to:@"6001" body:body ext:extDic];
    //    message.chatType = EMChatTypeChat;// 设置为单聊消息
    
    [self addMessageToDataSource:message
                        progress:nil];
    
    __weak typeof(self) weakself = self;
    [[EMClient sharedClient].chatManager asyncSendMessage:message progress:nil completion:^(EMMessage *aMessage, EMError *aError) {
        if (!aError) {
            weakself.info = nil;
//            [self addMessageToDataSource:message
//                                progress:nil];
        }
        else {
            NSLog(@"失败 %@",aError.errorDescription);
            NSLog(@"失败 %@",aError.errorDescription);
        }
    }];
}
- (void)tishixiaoxiOne{
    
    NSMutableDictionary *itemDic = [NSMutableDictionary dictionary];
    [itemDic setObject:@"titl1etitl1e" forKey:@"titl1e"];
    [itemDic setObject:@"titl2etitl2etitl2e" forKey:@"titl2e"];
    
    NSDictionary *extDic = @{TSMSGTITLE:@{TSMSGONE:itemDic}};
    EMMessage *message = [EaseSDKHelper sendTextMessage:TSMSGTITLE
                                                     to:self.conversation.conversationId
                                            messageType:EMChatTypeChat
                                             messageExt:extDic];
    message.chatType = EMChatTypeChat;
    [self addMessageToDataSource:message progress:nil];
}
- (void)tishixiaoxiTwo{
    
    NSMutableDictionary *itemDic = [NSMutableDictionary dictionary];
    [itemDic setObject:@"titl1etitl1e" forKey:@"titl1e"];
    [itemDic setObject:@"titl2etitl2etitl2e" forKey:@"titl2e"];
    
    NSDictionary *extDic = @{TSMSGTITLE:@{TSMSGTWO:itemDic}};
    EMMessage *message = [EaseSDKHelper sendTextMessage:TSMSGTITLE
                                                     to:self.conversation.conversationId
                                            messageType:EMChatTypeChat
                                             messageExt:extDic];
    message.chatType = EMChatTypeChat;
    [self addMessageToDataSource:message progress:nil];
}
#pragma mark - setup subviews

- (void)_setupBarButtonItem
{
    //单聊
    if (self.conversation.type == EMConversationTypeChat) {
        UIButton *clearButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        [clearButton setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        [clearButton addTarget:self action:@selector(deleteAllMessages:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:clearButton];
    }
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.cancelButtonIndex != buttonIndex) {
        self.messageTimeIntervalTag = -1;
        [self.conversation deleteAllMessages];
        [self.dataArray removeAllObjects];
        [self.messsagesSource removeAllObjects];
        
        [self.tableView reloadData];
    }
}

#pragma mark - EaseMessageViewControllerDelegate

- (BOOL)messageViewController:(EaseMessageViewController *)viewController
   canLongPressRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (BOOL)messageViewController:(EaseMessageViewController *)viewController
   didLongPressRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;//取消长安
    id object = [self.dataArray objectAtIndex:indexPath.row];
    if (![object isKindOfClass:[NSString class]]) {
        EaseMessageCell *cell = (EaseMessageCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        [cell becomeFirstResponder];
        self.menuIndexPath = indexPath;
        [self showMenuViewController:cell.bubbleView andIndexPath:indexPath messageType:cell.model.bodyType];
    }
    return YES;
}

- (void)messageViewController:(EaseMessageViewController *)viewController
   didSelectAvatarMessageModel:(id<IMessageModel>)messageModel
{
//    UserProfileViewController *userprofile = [[UserProfileViewController alloc] initWithUsername:messageModel.message.from];
//    [self.navigationController pushViewController:userprofile animated:YES];
}

- (void)messageViewController:(EaseMessageViewController *)viewController
               selectAtTarget:(EaseSelectAtTargetCallback)selectedCallback
{
    _selectedCallback = selectedCallback;
    EMGroup *chatGroup = nil;
    NSArray *groupArray = [[EMClient sharedClient].groupManager getAllGroups];
    for (EMGroup *group in groupArray) {
        if ([group.groupId isEqualToString:self.conversation.conversationId]) {
            chatGroup = group;
            break;
        }
    }
    
    if (chatGroup == nil) {
        chatGroup = [EMGroup groupWithId:self.conversation.conversationId];
    }
    
    if (chatGroup) {
        if (!chatGroup.occupants) {
            __weak ChatViewController* weakSelf = self;
            [self showHudInView:self.view hint:@"Fetching group members..."];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                EMError *error = nil;
                EMGroup *group = [[EMClient sharedClient].groupManager fetchGroupInfo:chatGroup.groupId includeMembersList:YES error:&error];
                dispatch_async(dispatch_get_main_queue(), ^{
                    __strong ChatViewController *strongSelf = weakSelf;
                    if (strongSelf) {
                        [strongSelf hideHud];
                        if (error) {
                            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"Fetching group members failed [%@]", error.errorDescription] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                            [alertView show];
                        }
                        else {
                            NSMutableArray *members = [group.occupants mutableCopy];
                            NSString *loginUser = [EMClient sharedClient].currentUsername;
                            if (loginUser) {
                                [members removeObject:loginUser];
                            }
                            if (![members count]) {
                                if (strongSelf.selectedCallback) {
                                    strongSelf.selectedCallback(nil);
                                }
                                return;
                            }

                        }
                    }
                });
            });
        }
        else {
            NSMutableArray *members = [chatGroup.occupants mutableCopy];
            NSString *loginUser = [EMClient sharedClient].currentUsername;
            if (loginUser) {
                [members removeObject:loginUser];
            }
            if (![members count]) {
                if (_selectedCallback) {
                    _selectedCallback(nil);
                }
                return;
            }
        }
    }
}

#pragma mark - EaseMessageViewControllerDataSource

- (id<IMessageModel>)messageViewController:(EaseMessageViewController *)viewController
                           modelForMessage:(EMMessage *)message
{
    id<IMessageModel> model = nil;
    model = [[EaseMessageModel alloc] initWithMessage:message];
    model.avatarImage = [UIImage imageNamed:@"EaseUIResource.bundle/user"];

    model.failImageName = @"imageDownloadFail";
    return model;
}

- (NSArray*)emotionFormessageViewController:(EaseMessageViewController *)viewController
{
    NSMutableArray *emotions = [NSMutableArray array];
    for (NSString *name in [EaseEmoji allEmoji]) {
        EaseEmotion *emotion = [[EaseEmotion alloc] initWithName:@"" emotionId:name emotionThumbnail:name emotionOriginal:name emotionOriginalURL:@"" emotionType:EMEmotionDefault];
        [emotions addObject:emotion];
    }
    EaseEmotion *temp = [emotions objectAtIndex:0];
    EaseEmotionManager *managerDefault = [[EaseEmotionManager alloc] initWithType:EMEmotionDefault emotionRow:3 emotionCol:7 emotions:emotions tagImage:[UIImage imageNamed:temp.emotionId]];
    
    
    NSMutableArray *emotions2 = [NSMutableArray array];
    for (NSString *name in [EaseEmoji allEmojiTWO]) {
        EaseEmotion *emotion = [[EaseEmotion alloc] initWithName:@"" emotionId:name emotionThumbnail:name emotionOriginal:name emotionOriginalURL:@"" emotionType:EMEmotionDefault];
        [emotions2 addObject:emotion];
    }
    EaseEmotion *temp2 = [emotions objectAtIndex:0];
    EaseEmotionManager *managerDefault2 = [[EaseEmotionManager alloc] initWithType:EMEmotionDefault emotionRow:3 emotionCol:7 emotions:emotions2 tagImage:[UIImage imageNamed:temp2.emotionId]];
    
//    NSMutableArray *emotionGifs = [NSMutableArray array];
//    _emotionDic = [NSMutableDictionary dictionary];
//    NSArray *names = @[@"aa_1",@"aa_2",@"aa_3",@"aa_4",@"aa_5",@"aa_6",@"aa_7",@"aa_8",@"aa_9",@"aa_10",@"aa_11",@"aa_12",@"aa_13",@"aa_14",@"aa_15",@"aa_16",@"aa_17",@"aa_18",@"aa_19",@"aa_20",@"aa_21",@"aa_22",@"aa_23"];
//    NSArray *names2 = @[@"[(-Q)]",@"[(-W)]",@"[(-E)]",@"[(-R)]",@"[(-T)]",@"[(-Y]",@"[(-U)]",@"[(-I)]",@"[(-O)]",@"[(-P)]",@"[(-A)]",@"[(-S)]",@"[(-D)]",@"[(-F)]",@"[(-G)]",@"[(-H)]",@"[(-J)]",@"[(-K)]",@"[(-L)]",@"[(-Z)]",@"[(-X)]",@"[(-C)]",@"[(-V)]"];
//    int index = 0;
//    for (NSString *name in names) {
//        index++;
//        //        EaseEmotion *emotion = [[EaseEmotion alloc] initWithName:@"" emotionId:name emotionThumbnail:name emotionOriginal:name emotionOriginalURL:@"" emotionType:EMEmotionDefault];
//        
//        
//        EaseEmotion *emotion = [[EaseEmotion alloc] initWithName:name emotionId:names2[index] emotionThumbnail:name emotionOriginal:name emotionOriginalURL:@"" emotionType:EMEmotionPng];
//        [emotionGifs addObject:emotion];
//    }
//    EaseEmotionManager *managerGif= [[EaseEmotionManager alloc] initWithType:EMEmotionPng emotionRow:2 emotionCol:4 emotions:emotionGifs tagImage:[UIImage imageNamed:names[0]]];
    
    return @[managerDefault,managerDefault2];
}

- (BOOL)isEmotionMessageFormessageViewController:(EaseMessageViewController *)viewController
                                    messageModel:(id<IMessageModel>)messageModel
{
    BOOL flag = NO;
    if ([messageModel.message.ext objectForKey:MESSAGE_ATTR_IS_BIG_EXPRESSION]) {
        return YES;
    }
    return flag;
}

- (EaseEmotion*)emotionURLFormessageViewController:(EaseMessageViewController *)viewController
                                      messageModel:(id<IMessageModel>)messageModel
{
    NSString *emotionId = [messageModel.message.ext objectForKey:MESSAGE_ATTR_EXPRESSION_ID];
    EaseEmotion *emotion = [_emotionDic objectForKey:emotionId];
    if (emotion == nil) {
        emotion = [[EaseEmotion alloc] initWithName:@"" emotionId:emotionId emotionThumbnail:@"" emotionOriginal:@"" emotionOriginalURL:@"" emotionType:EMEmotionGif];
    }
    return emotion;
}

- (NSDictionary*)emotionExtFormessageViewController:(EaseMessageViewController *)viewController
                                        easeEmotion:(EaseEmotion*)easeEmotion
{
    return @{MESSAGE_ATTR_EXPRESSION_ID:easeEmotion.emotionId,MESSAGE_ATTR_IS_BIG_EXPRESSION:@(YES)};
}

#pragma mark - EaseMob

#pragma mark - EMClientDelegate

- (void)didLoginFromOtherDevice
{
    if ([self.imagePicker.mediaTypes count] > 0 && [[self.imagePicker.mediaTypes objectAtIndex:0] isEqualToString:(NSString *)kUTTypeMovie]) {
        [self.imagePicker stopVideoCapture];
    }
}

- (void)didRemovedFromServer
{
    if ([self.imagePicker.mediaTypes count] > 0 && [[self.imagePicker.mediaTypes objectAtIndex:0] isEqualToString:(NSString *)kUTTypeMovie]) {
        [self.imagePicker stopVideoCapture];
    }
}

#pragma mark - action

- (void)backAction
{
    [[EMClient sharedClient].chatManager removeDelegate:self];
    [[EMClient sharedClient].roomManager removeDelegate:self];
    [[ChatDemoHelper shareHelper] setChatVC:nil];
    
    if (self.deleteConversationIfNull) {
        //判断当前会话是否为空，若符合则删除该会话
        EMMessage *message = [self.conversation latestMessage];
        if (message == nil) {
            [[EMClient sharedClient].chatManager deleteConversation:self.conversation.conversationId deleteMessages:NO];
        }
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)showGroupDetailAction
{
    [self.view endEditing:YES];

}

- (void)deleteAllMessages:(id)sender
{
    if (self.dataArray.count == 0) {
        [self showHint:NSLocalizedString(@"message.noMessage", @"no messages")];
        return;
    }
    
    if ([sender isKindOfClass:[NSNotification class]]) {
        NSString *groupId = (NSString *)[(NSNotification *)sender object];
        BOOL isDelete = [groupId isEqualToString:self.conversation.conversationId];
        if (self.conversation.type != EMConversationTypeChat && isDelete) {
            self.messageTimeIntervalTag = -1;
            [self.conversation deleteAllMessages];
            [self.messsagesSource removeAllObjects];
            [self.dataArray removeAllObjects];
            
            [self.tableView reloadData];
            [self showHint:NSLocalizedString(@"message.noMessage", @"no messages")];
        }
    }
    else if ([sender isKindOfClass:[UIButton class]]){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"prompt", @"Prompt") message:NSLocalizedString(@"sureToDelete", @"please make sure to delete") delegate:self cancelButtonTitle:NSLocalizedString(@"cancel", @"Cancel") otherButtonTitles:NSLocalizedString(@"ok", @"OK"), nil];
        [alertView show];
    }
}

- (void)transpondMenuAction:(id)sender
{
    if (self.menuIndexPath && self.menuIndexPath.row > 0) {
        id<IMessageModel> model = [self.dataArray objectAtIndex:self.menuIndexPath.row];
        
    }
    self.menuIndexPath = nil;
}

- (void)copyMenuAction:(id)sender
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    if (self.menuIndexPath && self.menuIndexPath.row > 0) {
        id<IMessageModel> model = [self.dataArray objectAtIndex:self.menuIndexPath.row];
        pasteboard.string = model.text;
    }
    
    self.menuIndexPath = nil;
}

- (void)deleteMenuAction:(id)sender
{
    if (self.menuIndexPath && self.menuIndexPath.row > 0) {
        id<IMessageModel> model = [self.dataArray objectAtIndex:self.menuIndexPath.row];
        NSMutableIndexSet *indexs = [NSMutableIndexSet indexSetWithIndex:self.menuIndexPath.row];
        NSMutableArray *indexPaths = [NSMutableArray arrayWithObjects:self.menuIndexPath, nil];
        
        [self.conversation deleteMessageWithId:model.message.messageId];
        [self.messsagesSource removeObject:model.message];
        
        if (self.menuIndexPath.row - 1 >= 0) {
            id nextMessage = nil;
            id prevMessage = [self.dataArray objectAtIndex:(self.menuIndexPath.row - 1)];
            if (self.menuIndexPath.row + 1 < [self.dataArray count]) {
                nextMessage = [self.dataArray objectAtIndex:(self.menuIndexPath.row + 1)];
            }
            if ((!nextMessage || [nextMessage isKindOfClass:[NSString class]]) && [prevMessage isKindOfClass:[NSString class]]) {
                [indexs addIndex:self.menuIndexPath.row - 1];
                [indexPaths addObject:[NSIndexPath indexPathForRow:(self.menuIndexPath.row - 1) inSection:0]];
            }
        }
        
        [self.dataArray removeObjectsAtIndexes:indexs];
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
        
        if ([self.dataArray count] == 0) {
            self.messageTimeIntervalTag = -1;
        }
    }
    
    self.menuIndexPath = nil;
}

#pragma mark - notification
- (void)exitGroup
{
    [self.navigationController popToViewController:self animated:NO];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)insertCallMessage:(NSNotification *)notification
{
    id object = notification.object;
    if (object) {
        EMMessage *message = (EMMessage *)object;
        
        EMMessageBody *msgBody = message.body;
        if (msgBody.type == EMMessageBodyTypeText) {
            // 收到的文字消息
            EMTextMessageBody *textBody = (EMTextMessageBody *)msgBody;
            NSString *txt = textBody.text;
            if ([txt hasPrefix:OrderNumber]) {//判断是客服  而且 是订单号码
                NSString *tmp = [txt returnNum:txt];
                NSLog(@"收到的文字是 tmp -- %@",tmp);
                return;
            }
        }
        
        [self addMessageToDataSource:message progress:nil];
        
        [[EMClient sharedClient].chatManager importMessages:@[message]];
    }
}

- (void)handleCallNotification:(NSNotification *)notification
{
    id object = notification.object;
    if ([object isKindOfClass:[NSDictionary class]]) {
        //开始call
        self.isViewDidAppear = NO;
    } else {
        //结束call
        self.isViewDidAppear = YES;
    }
}

#pragma mark - private

- (void)showMenuViewController:(UIView *)showInView
                   andIndexPath:(NSIndexPath *)indexPath
                    messageType:(EMMessageBodyType)messageType
{
    if (self.menuController == nil) {
        self.menuController = [UIMenuController sharedMenuController];
    }
    
    if (_deleteMenuItem == nil) {
        _deleteMenuItem = [[UIMenuItem alloc] initWithTitle:NSLocalizedString(@"delete", @"Delete") action:@selector(deleteMenuAction:)];
    }
    
    if (_copyMenuItem == nil) {
        _copyMenuItem = [[UIMenuItem alloc] initWithTitle:NSLocalizedString(@"copy", @"Copy") action:@selector(copyMenuAction:)];
    }
    
    if (messageType == EMMessageBodyTypeText) {
        [self.menuController setMenuItems:@[_copyMenuItem, _deleteMenuItem]];
    } else if (messageType == EMMessageBodyTypeImage){
//        [self.menuController setMenuItems:@[_deleteMenuItem,_transpondMenuItem]];
        [self.menuController setMenuItems:@[_deleteMenuItem]];
    } else {
        [self.menuController setMenuItems:@[_deleteMenuItem]];
    }
    [self.menuController setTargetRect:showInView.frame inView:showInView.superview];
    [self.menuController setMenuVisible:YES animated:YES];
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

//具体创建自定义Cell的样例：
- (UITableViewCell *)messageViewController:(UITableView *)tableView cellForMessageModel:(id<IMessageModel>)model
{
    //样例为如果消息是文本消息显示用户自定义cell
    NSDictionary *dic = model.message.ext;
 
    if (model.isSender) {
        if ([[Ticket sharedInstance]judgeIsLOgin]) {
            model.avatarURLPath = [Ticket sharedInstance].userinfo.avatar;
        }else{
            model.avatarImage = [UIImage imageNamed:@"chatListCellHead"];
        }
    } else{//weichat  userNickname  visitor
//        if ([model.nickname isEqualToString:@"kefu"]) {    //如果是客服
//            
////                    EMMessageBody *msgBody = model.message.body;
////                    if (msgBody.type == EMMessageBodyTypeText) {
////                        // 收到的文字消息
////                        EMTextMessageBody *textBody = (EMTextMessageBody *)msgBody;
////                        NSString *txt = textBody.text;
////                        if ([txt hasPrefix:OrderNumber]) {//判断是客服  而且 是订单号码
////                            NSString *tmp = [txt returnNum:txt];
////                            NSLog(@"收到的文字是 tmp -- %@",tmp);
////                            
////                        }
////                    }
//            
//            kefuInfo *datawa  = [NSKeyedUnarchiver unarchiveObjectWithFile:ZEJIKEFUInfoPATH];
//            if (datawa.avatar ) {
//                datawa.avatar = [@"http:" stringByAppendingString:datawa.avatar];
//                datawa.avatar = [datawa.avatar stringByReplacingOccurrencesOfString:@"|300h_300w|" withString:@""];
//            }
//            model.avatarURLPath = datawa.avatar;
//            self.title = datawa.userNickname;
//        }else{
        if (self.HeadOfTheOtherSide) {
            model.avatarURLPath = self.HeadOfTheOtherSide;
        } else {
           model.avatarImage = self.headImage;
        }
//        self.title = self.EachOtherName;
    }
    if (model.bodyType == EMMessageBodyTypeText) {
        NSDictionary *mishu = dic[TSZFTSZF];
        if ([[dic allKeys] containsObject:TSZFTSZF] && ![[mishu allKeys] containsObject:Myorder]) {
            CusThree *cell = [CusThree returnCellWith:tableView];
            NSDictionary *tmp = dic[TSZFTSZF];
            tmp = tmp[@"track"];
            NSString *strr = tmp[@"titl1e"];
            NSDictionary *dddic = [NSString dictionaryWithJsonString:strr];
            cell.dataDic = dddic;
            return cell;
        }else if ([[dic allKeys] containsObject:TSZFTSZF]  && [[mishu allKeys] containsObject:Myorder]) {

            NSString *CellIdentifier = @"CellIdentifierCustomMessdfageCellThrxcvee";
            //            CustomMessageCellThree *cell = (CustomMessageCellThree *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            //            if (cell == nil) {
            //
            //                cell = [[CustomMessageCellThree alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier model:model];
            //                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            //            }
            
            
            CustomMessageCellThree *cell = [[CustomMessageCellThree alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier model:model];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = model;
            return cell;
        }else if ([dic objectForKey:TSMSGTITLE]) {
            NSDictionary *dicc = dic[TSMSGTITLE];
            if ([dicc objectForKey:TSMSGONE]) {
                CusXTOne *cell = [CusXTOne returnCellWith:tableView];
                
                return cell;
            } else if ([dicc objectForKey:TSMSGTWO]){
                CusXTTWo *cell = [CusXTTWo returnCellWith:tableView];
                
                return cell;
            }
            
        }else if ([dic objectForKey:@"orderInfo"]) {
            NSString *CellIdentifier = @"asdfadfadfaorderInfo";
            //CustomMessageCell为用户自定义cell,继承了EaseBaseMessageCell
            fourKefu *cell = (fourKefu *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//            cell.delegateTwo = self;
            if (cell == nil) {
                cell = [[fourKefu alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier model:model];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.model = model;
            return cell;
        }else if ([dic objectForKey:OrderForMishu]) {
            NSString *CellIdentifier = @"asdfadfadfaOrderForMishu";
            //CustomMessageCell为用户自定义cell,继承了EaseBaseMessageCell
            toMishu *cell = (toMishu *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[toMishu alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier model:model];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.model = model;
            return cell;
        }  else {
            NSString *CellIdentifier = [CustomMessageCellOne cellIdentifierWithModel:model];
            //CustomMessageCell为用户自定义cell,继承了EaseBaseMessageCell
            CustomMessageCellOne *cell = (CustomMessageCellOne *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[CustomMessageCellOne alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier model:model];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.model = model;
            return cell;
        }
    }
    else if (model.bodyType == EMMessageBodyTypeImage) {
        NSString *CellIdentifier = [CustomMessageCellTwo cellIdentifierWithModel:model];
        //CustomMessageCell为用户自定义cell,继承了EaseBaseMessageCell
        CustomMessageCellTwo *cell = (CustomMessageCellTwo *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[CustomMessageCellTwo alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier model:model];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.model = model;
        return cell;
    }
    return nil;
}

- (CGFloat)messageViewController:(EaseMessageViewController *)viewController
           heightForMessageModel:(id<IMessageModel>)messageModel
                   withCellWidth:(CGFloat)cellWidth
{
    //样例为如果消息是文本消息使用用户自定义cell的高度
    if (messageModel.bodyType == EMMessageBodyTypeText) {
        //CustomMessageCell为用户自定义cell,继承了EaseBaseMessageCell
        NSDictionary *dic = messageModel.message.ext;
        NSLog(@"sdfsdfsdfdic=%@",dic);
        if ([dic objectForKey:TSZFTSZF]) {
            return 125;
        }
//        else if ([[dic allKeys] containsObject:@"msgtype"]) {
//            return 125;
//        }
        else if ([dic objectForKey:TSMSGTITLE]) {
            NSDictionary *dicc = dic[TSMSGTITLE];
            if ([dicc objectForKey:TSMSGONE]) {
                return 36;
            } else if ([dicc objectForKey:TSMSGTWO]){
                return 60;
            }
        }else if ([dic objectForKey:@"orderInfo"]) {    //客服发来的订单消息
            orderInfo *data = [MTLJSONAdapter modelOfClass:[orderInfo class] fromJSONDictionary:dic error:nil];
            NSInteger tmp = data.psgInfo.count;
            if (tmp >1) {
                tmp = 20*tmp - 20;
            }
            return 206 + tmp;
        }else if ([dic objectForKey:OrderForMishu]) { //秘书发来的订单消息
            return 136;
        } else {
            return [CustomMessageCellOne cellHeightWithModel:messageModel];
        }
    }else if (messageModel.bodyType == EMMessageBodyTypeImage) {
        //CustomMessageCell为用户自定义cell,继承了EaseBaseMessageCell
        return [CustomMessageCellTwo cellHeightWithModel:messageModel];
    }
    return 0.f;
}

- (void)CallPhoneSeclect:(NSNotification *)user{
//    NSDictionary *dic = user.userInfo;
    //    NSString *messge = dic[MBmessage];
    NSLog(@"打电话了");
//qxc
    if (self == self.navigationController.topViewController) {
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",self.mobie];
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:str]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }else{
            [MBProgressHUD showError:@"无效的电话"];
        }
    }
}
@end
