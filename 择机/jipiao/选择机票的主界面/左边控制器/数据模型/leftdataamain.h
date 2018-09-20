//
//  leftdataamain.h
//  jipiao
//
//  Created by Store on 16/8/12.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <Mantle/Mantle.h>


@interface dicmenuArray : MTLModel<MTLJSONSerializing>
@property (nonatomic,strong) NSString *customerServicePhone;//客服电话
@property (nonatomic,strong) NSMutableArray *menuArray;
@end

@interface GlobalParams : MTLModel<MTLJSONSerializing>
@property (nonatomic,strong) NSString *startPicture;//app启动时访问的图片url
@property (nonatomic,strong) NSString *twoMa;//二维码
@property (nonatomic,strong) NSString *iosAuditFlagQ;//IOS 用的按钮

@property (nonatomic,strong) NSString *clearCacheFlag;//清除缓存标志

//活动
@property (nonatomic,strong) NSString *activityImg;//活动图片
@property (nonatomic,strong) NSString *activityUrl;//活动地址
@property (nonatomic,strong) NSString *activityTitle;//活动标题
@end


@interface leftdataamain : MTLModel<MTLJSONSerializing>
@property (nonatomic,strong) NSString *must_login_flag;//
@property (nonatomic,strong) NSString *menuId;//index
@property (nonatomic,strong) NSString *menuName; //软件信息
@property (nonatomic,strong) NSString *menuLogo;//logo2
@property (nonatomic,strong) NSString *url;//跳转地址
@end
