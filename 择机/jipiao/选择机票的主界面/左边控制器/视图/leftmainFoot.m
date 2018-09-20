//
//  leftmainFoot.m
//  jipiao
//
//  Created by Store on 16/8/10.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "leftmainFoot.h"
#import "shareMyapp.h"
#import "zejiMain.h"


@interface leftmainFoot ()
@property (nonatomic,weak) UILabel *labelFoot;
@end

@implementation leftmainFoot
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *view1 = [[UIButton alloc]init];
        view1.layer.borderWidth = 1.0;
        view1.layer.borderColor = Colorlines.CGColor;
        [self addSubview:view1];
        
        UIButton *view2 = [[UIButton alloc]init];
        view2.layer.borderWidth = 1.0;
        view2.layer.borderColor = Colorlines.CGColor;
        [self addSubview:view2];
        
        UILabel *labelFoot = [[UILabel alloc]init];
        labelFoot.textColor = [UIColor whiteColor];
        labelFoot.font = [UIFont systemFontOfSize:11];
        [self addSubview:labelFoot];
        labelFoot.textAlignment = NSTextAlignmentCenter;
        self.labelFoot = labelFoot;
        
        view1.titleLabel.font = [UIFont systemFontOfSize:14];
        view2.titleLabel.font = [UIFont systemFontOfSize:14];
        [view1 setTitle:@"分享app" forState:UIControlStateNormal];
        [view1 setImage:[UIImage imageNamed:@"icon_share"] forState:UIControlStateNormal];
        [view2 setTitle:@"关于我们" forState:UIControlStateNormal];
        [view2 setImage:[UIImage imageNamed:@"icon_about"] forState:UIControlStateNormal];
        [view1 addTarget:self action:@selector(view1Click:) forControlEvents:UIControlEventTouchUpInside];
        [view2 addTarget:self action:@selector(view2Click:) forControlEvents:UIControlEventTouchUpInside];
        
        [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(view2.mas_left).offset(-10*WIDTHICON);
            make.left.equalTo(self).offset(17*WIDTHICON);
            make.height.equalTo(@(35*HEIGHTICON));
            make.height.equalTo(@[view2]);
            make.width.equalTo(@[view2]);
            make.centerY.equalTo(self).offset(-15);
        }];
        
        [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-17*WIDTHICON);
            make.bottom.equalTo(view1);
            make.top.equalTo(view1);
        }];
        [labelFoot mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.bottom.equalTo(self);
            make.top.equalTo(view1.mas_bottom);
        }];
        
        labelFoot.text = VERNUM;
//        labelFoot.text = [@"V " stringByAppendingString:app_Version];
    }
    return self;
}

- (void)view1Click:(UIButton *)btn{
    NSLog(@"view1Click");
    shareMyapp *vc = [[shareMyapp alloc]init];
    [NaVc pushViewController:vc animated:YES];
//    for (UIView* next = [self superview]; next; next = next.superview) {
//        UIResponder* nextResponder = [next nextResponder];
//        if ([nextResponder isKindOfClass:[zejiMain  class]]) {
//            UIViewController *Vc =  (UIViewController*)nextResponder;
//            [Vc.navigationController pushViewController:vc animated:YES];
//        }
//    }
}
- (void)view2Click:(UIButton *)btn{
    NSLog(@"view2Click");
        baseWeb *vc = [[baseWeb alloc]init];
        vc.title = @"关于我们";
        vc.url = aboutZEJI;
        vc.isRefeth = NO;
        [NaVc pushViewController:vc animated:YES];

}
@end
