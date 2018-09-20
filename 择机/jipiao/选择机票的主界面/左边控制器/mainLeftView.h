//
//  mainLeftView.h
//  jipiao
//
//  Created by Store on 16/10/20.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderTotal.h"


@protocol leftmainDelegate <NSObject>
- (void)returnGJorGNBtn:(AIRLINETICKETTYPE)num;
@end


@interface mainLeftView : UIView
@property (nonatomic,weak)id<leftmainDelegate>delegate;
@property (nonatomic,strong) dicmenuArray *arrryDes; //存数据
@property (nonatomic,strong) NSString *nameStr; //名字
@property (nonatomic,strong) NSString *iconStr; //头像
@property (nonatomic,strong) NSString *numWeidu;  //未读消息数量
@end
