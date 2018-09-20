//
//  QCarouselData.h
//  jipiao
//
//  Created by Store on 16/8/11.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface QCarouselDataArry : MTLModel<MTLJSONSerializing>
@property (nonatomic,strong) NSMutableArray *appArray;
@end

@interface QCarouselData : MTLModel<MTLJSONSerializing>
@property (nonatomic,strong) NSString *addLogo;
@property (nonatomic,strong) NSString *appName;
@property (nonatomic,strong) NSString *openMode;
@property (nonatomic,strong) NSString *url;
@property (nonatomic,strong) NSString *param;
@end
