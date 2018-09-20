//
//  noRecord.m
//  jipiao
//
//  Created by Store on 16/10/20.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "noRecord.h"
#import "Masonry.h"


@interface noRecord ()
@property (nonatomic,weak) UILabel *nomsg;
@end

@implementation noRecord

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        UIImageView *image = [[UIImageView alloc]init];
        image.image = [UIImage imageNamed:@"niao"];
        [self addSubview:image];

        UIImageView *image2 = [[UIImageView alloc]init];
        image2.image = [UIImage imageNamed:@"wu"];
        [self addSubview:image2];

        UILabel *image3 = [[UILabel alloc]init];
        self.nomsg = image3;
        [self addSubview:image3];
        image3.textColor = [UIColor blackColor];
        image3.font = [UIFont systemFontOfSize:14];
        image3.textAlignment = NSTextAlignmentCenter;

        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.centerX.equalTo(self);
            make.width.equalTo(image.mas_height);
            make.bottom.equalTo(image2.mas_top);
        }];
        
        [image2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@40);
            make.bottom.equalTo(self);
            make.left.equalTo(self);
            make.right.equalTo(self);
        }];
        
        [image3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(image2).offset(5);
            make.bottom.equalTo(image2).offset(-5);
            make.left.equalTo(image2).offset(5);
            make.right.equalTo(image2).offset(-5);
        }];
    }
    return self;
}
- (void)setPromptMsg:(NSString *)promptMsg{
    _promptMsg = promptMsg;
    self.nomsg.text = promptMsg;
}
@end
