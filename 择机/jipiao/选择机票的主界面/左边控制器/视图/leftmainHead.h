//
//  leftmainHead.h
//  jipiao
//
//  Created by Store on 16/8/10.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderTotal.h"

@protocol leftmainHeadDelegate <NSObject>
- (void)returnGJorGNBtn:(AIRLINETICKETTYPE)num;
@end

@interface leftmainHead : UIView
@property (nonatomic,weak)id<leftmainHeadDelegate>delegate;
@end
