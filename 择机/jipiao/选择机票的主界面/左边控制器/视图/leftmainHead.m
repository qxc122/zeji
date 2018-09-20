//
//  leftmainHead.m
//  jipiao
//
//  Created by Store on 16/8/10.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "leftmainHead.h"

@interface leftmainHead()
@property (nonatomic,weak) UIButton *domesticImage;
#ifdef guoji_tiket
@property (nonatomic,weak) UIButton *internationalImage;
#endif
@end

@implementation leftmainHead
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIButton *domesticImage = [[UIButton alloc]init];
        self.domesticImage = domesticImage;
        [self.domesticImage setImage:[UIImage imageNamed:@"icon_domestic"] forState:UIControlStateNormal];
        [self.domesticImage setImage:[UIImage imageNamed:@"icon_domestic_press"] forState:UIControlStateHighlighted];
        [self.domesticImage setImage:[UIImage imageNamed:@"icon_domestic_press"] forState:UIControlStateSelected];
        [self addSubview:domesticImage];
#ifdef guoji_tiket
        UIButton *internationalImage = [[UIButton alloc]init];
        self.internationalImage = internationalImage;
        [self.internationalImage setImage:[UIImage imageNamed:@"icon_international"] forState:UIControlStateNormal];
        [self.internationalImage setImage:[UIImage imageNamed:@"icon_international_press"] forState:UIControlStateHighlighted];
        [self.internationalImage setImage:[UIImage imageNamed:@"icon_domestic_press"] forState:UIControlStateSelected];
        
        [self addSubview:internationalImage];
        
        [self.internationalImage addTarget:self action:@selector(clickinternationalImageHead:) forControlEvents:UIControlEventTouchUpInside];
#endif
        [self.domesticImage addTarget:self action:@selector(clickdomesticImageHead:) forControlEvents:UIControlEventTouchUpInside];
        
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = Colorlines;
        [self addSubview:view];
        
        
        [self.domesticImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
#ifdef guoji_tiket
            make.left.equalTo(self).offset(31*WIDTHICON);
            make.right.equalTo(self.internationalImage.mas_left).offset(-33*WIDTHICON);
            make.width.equalTo(@[self.internationalImage]);
            make.height.equalTo(@[self.internationalImage]);
            make.height.mas_equalTo(domesticImage.mas_width);
#else
            make.centerX.equalTo(self);
            make.width.equalTo(@(82*WIDTHICON));
            make.height.equalTo(@(82*WIDTHICON));
#endif
        }];
#ifdef guoji_tiket
        [self.internationalImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.domesticImage);
            make.bottom.equalTo(self.domesticImage);
            make.right.equalTo(self).offset(-31*WIDTHICON);
        }];
#endif
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@1);
            make.bottom.equalTo(self);
            make.right.equalTo(self);
            make.left.equalTo(self);
        }];
    }
    return self;
}
- (void)clickdomesticImageHead:(UIGestureRecognizer *)gestureRecognizer{
    NSLog(@"clickdomesticImageHead");
    if ([self.delegate respondsToSelector:@selector(returnGJorGNBtn:)]) {
        [self.delegate returnGJorGNBtn:DOMESTICAIRTICKETS];
    }
//    NSDictionary *dictTmp = @{@"isDomestic":@1,};
//    NSNotification *notification =[NSNotification notificationWithName:Domesticairtickets object:nil userInfo:dictTmp];
//    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
//    [[NSNotificationCenter defaultCenter]
//     postNotificationName:Domesticairtickets object:@{@"isDomestic":@1,}];
}
- (void)clickinternationalImageHead:(UIGestureRecognizer *)gestureRecognizer{
    if ([self.delegate respondsToSelector:@selector(returnGJorGNBtn:)]) {
        [self.delegate returnGJorGNBtn:INTETNATIONALAIRTICKETS];
    }
    
//    NSDictionary *dictTmp = @{@"isDomestic":@0,};
//    NSNotification *notification =[NSNotification notificationWithName:Domesticairtickets object:nil userInfo:dictTmp];
//    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
//    if (!arrryDes.iosAuditFlagQ || [arrryDes.iosAuditFlagQ isEqualToString:@"0"]) {
//        if ([self.delegate respondsToSelector:@selector(returnGJorGNBtn:)]) {
//            [self.delegate returnGJorGNBtn:INTETNATIONALAIRTICKETS];
//        }
//    } else {
//        [MBProgressHUD showError:@"功能待完善,敬请期待\
         function improving and coming soon"];
//        MBProgressHUD * HUD = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
//        HUD.mode = MBProgressHUDModeText;
//        
//        HUD.removeFromSuperViewOnHide = YES;
//
//        HUD.label.text = @"功能待完善,敬请期待"; //把这一行
//        HUD.detailsLabel.text = @"Function improving and coming soon";  //换成这一行就 可以
//        [HUD hideAnimated:YES afterDelay:1.0];
//    }
}
@end
