//
//  tableHead.m
//  jipiao
//
//  Created by Store on 16/8/17.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "tableHead.h"
#import "HeaderTotal.h"
#import "headImage.h"
#import "myinfo.h"

@interface tableHead ()
@property (nonatomic,weak)UIImageView *imageView;
@property (nonatomic,weak)UILabel *name;
@property (nonatomic,weak)UILabel *vipstr;

@end


@implementation tableHead
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc]init];
        [self addSubview:imageView];
        self.imageView = imageView;
        
        UILabel *name = [[UILabel alloc]init];
        [self addSubview:name];
        self.name = name;
        
        UILabel *vipstr = [[UILabel alloc]init];
        [self addSubview:vipstr];
        self.vipstr = vipstr;
        vipstr.hidden = YES;
        
        name.font = [UIFont systemFontOfSize:14];
        vipstr.font = [UIFont systemFontOfSize:10];
        name.textColor = [UIColor whiteColor];
        vipstr.textColor = [UIColor whiteColor];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(15*HEIGHTICON);
            make.centerX.equalTo(self);
            make.width.equalTo(@(54*HEIGHTICON));
            make.height.equalTo(imageView.mas_width);
        }];
        
        [name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imageView.mas_bottom).offset(13*HEIGHTICON);
            make.centerX.equalTo(self);
            make.height.equalTo(@15);
        }];
        
        [vipstr mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(name.mas_bottom).offset(4*HEIGHTICON);
            make.centerX.equalTo(self);
            make.height.equalTo(@10);
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewClick)];
        [imageView addGestureRecognizer:tap];
        imageView.userInteractionEnabled = YES;
        
        imageView.layer.cornerRadius = 54*HEIGHTICON/2.0;
        imageView.layer.masksToBounds = YES;
        //test
        imageView.image = [UIImage imageNamed:@"img_head portrait"];
        name.text = @"择机用户";
//        vipstr.text = @"vips";
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ZEJILoginsuccessSelectoheadrmainLeft)name:AvatarUploadSuccess object:nil];
    }
    return self;
}
- (void)ZEJILoginsuccessSelectoheadrmainLeft{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:[Ticket sharedInstance].userinfo.avatar] placeholderImage:[UIImage imageNamed:@"img_head portrait"]];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)setData:(myinfoData *)data{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:data.avatar] placeholderImage:[UIImage imageNamed:@"img_head portrait"]];
    if (data.userName) {
        self.name.text = data.userName;
    } else {
        self.name.text = data.mobile;
    }
    self.vipstr.text = data.userId;
//    self.vipstr.text = [@"vip" stringByAppendingString:data.flyCreditInfo.flylevel];
}

- (void)imageViewClick{
    NSLog(@"imageViewClick");
    headImage *vc = [[headImage alloc]init];
    vc.image = self.imageView.image;
    [NaVc pushViewController:vc animated:YES];
}
@end
