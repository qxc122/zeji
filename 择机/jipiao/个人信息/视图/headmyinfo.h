//
//  headmyinfo.h
//  jipiao
//
//  Created by Store on 16/8/17.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol headmyinfoDelegate <NSObject>
- (void)headClick:(NSInteger)index :(NSString *)des;
@end

@interface headmyinfo : UIView
@property (nonatomic,assign)NSInteger index;
@property (nonatomic,weak)id<headmyinfoDelegate>delegate;
@property (nonatomic,strong)NSString *icon;
@property (nonatomic,strong)NSString *des;
//@property (nonatomic,strong)NSString *isHiden;
@property (nonatomic,strong)NSString *value;
@property (nonatomic,strong)NSString *btnImage;
@end
