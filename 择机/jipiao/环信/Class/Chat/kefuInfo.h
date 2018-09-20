//
//  kefuInfo.h
//  jipiao
//
//  Created by Store on 16/8/26.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "HeaderTotal.h"

@interface kefuInfo : MTLModel<MTLJSONSerializing>
@property (nonatomic,strong) NSString *avatar;
@property (nonatomic,strong) NSString *userNickname;
@end
