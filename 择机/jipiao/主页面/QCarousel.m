//
//  QCarousel.m
//  jipiao
//
//  Created by Store on 16/8/8.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "QCarousel.h"
#import "HeaderTotal.h"

#define DEFAULTTIME 5
#define HORMARGIN 10
#define VERMARGIN 5
#define DES_LABEL_H 20

#define NUMTOTAL 5   //显示多少个图标

@interface QCarousel ()<UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView *scrollView;
@end
@implementation QCarousel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _scrollView = [[UIScrollView alloc]init];
        
        //开启滚动分页功能，如果不需要这个功能关闭即可
//        [_scrollView setPagingEnabled:YES];
        
        //隐藏横向与纵向的滚动条
        [_scrollView setShowsVerticalScrollIndicator:NO];
        [_scrollView setShowsHorizontalScrollIndicator:NO];
        
        //整体再将ScrollerView显示在窗口中
        [self addSubview:_scrollView];
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.top.equalTo(self);
            make.bottom.equalTo(self);
        }];
//        _scrollView.backgroundColor = [UIColor orangeColor];
    }
    return self;
}
- (void)setImageArray:(QCarouselDataArry *)imageArray{
    _imageArray = imageArray;
    
    NSUInteger tmp = 0;
    CGFloat ttttmp = 0;
    CGFloat tmpWidth = 52*WIDTHICON;
    
    for (UIView *tmp in self.scrollView.subviews) {
        [tmp removeFromSuperview];
    }
    
    for (QCarouselData *str in imageArray.appArray) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.tag = tmp;
        [_scrollView addSubview:imageView];
        
        UILabel *label = [[UILabel alloc]init];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:11];
        label.textColor = [UIColor whiteColor];
        [_scrollView addSubview:label];
        
//        UIButton *btn = [[UIButton alloc]init];
////        btn.backgroundColor = [UIColor redColor];
//        btn.tag = tmp;
//        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:btn];
        
        if (tmp == 0) {
            if ((tmpWidth*imageArray.appArray.count + 30*WIDTHICON + (NUMTOTAL-1)*20*WIDTHICON)>=screenWidth) {
                ttttmp = 15*WIDTHICON;
            } else {
                ttttmp = (screenWidth-(tmpWidth+20*WIDTHICON)*imageArray.appArray.count+20*WIDTHICON)/2.0;
            }
        } else {
            ttttmp += tmpWidth+20*WIDTHICON;
        }
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_scrollView).offset(ttttmp);
            make.top.equalTo(_scrollView).offset(10*HEIGHTICON);
            make.width.equalTo(@(tmpWidth));
            make.height.equalTo(@(tmpWidth));
        }];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(imageView);
//            make.left.equalTo(imageView);
//            make.right.equalTo(imageView);
            make.bottom.equalTo(self.mas_bottom);
            make.top.equalTo(imageView.mas_bottom);
        }];
//        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(imageView);
//            make.right.equalTo(imageView);
//            make.bottom.equalTo(label);
//            make.top.equalTo(imageView);
//        }];
        [imageView sd_setImageWithURL:[NSURL URLWithString:str.addLogo] placeholderImage:[UIImage imageNamed:@"icon_other_bqy"]];
        label.text = str.appName;
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewClick:)];
        [imageView addGestureRecognizer:tapGes];
        
        tmp++;
    }
    [_scrollView setContentSize:CGSizeMake(ttttmp+tmpWidth+15*WIDTHICON, 0)];
}
- (void)imageViewClick:(UITapGestureRecognizer *)sender{
    UIView *btn = sender.view;
    NSLog(@"imageViewClick %ld",(long)btn.tag);
//    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
//    NSDictionary *data = @{
//                           @"pase1":@"data1",
//                           @"pase2":@"data2",
//                           @"pase3":@"data3",
//                           };
//    [pasteboard setData:[NSDictionary returnDataWithDictionary:data] forPasteboardType:@"data"];
//    
    QCarouselData *datad = self.imageArray.appArray[btn.tag];
    //    datad.url = @"testwallet://";
    //    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:datad.url]]){
    //        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:datad.url]];
    //    }
//    datad.url = @"testwal|https://itunes.apple.com/cn/app/t-qian-bao/id1061514008?mt=8";
    
//    ViewController *vc = [[ViewController alloc]init];
//    vc.title = datad.appName;
//    vc.url = @"https://www.baidu.com/s?wd=u4e00%20u9fa5%20%E5%AF%B9%E7%85%A7%E8%A1%A8&rsv_spt=1&rsv_iqid=0x938717590001f7ad&issp=1&f=3&rsv_bp=0&rsv_idx=2&ie=utf-8&tn=baiduhome_pg&rsv_enter=1&rsv_sug3=2&rsv_sug1=1&rsv_sug7=100&rsv_sug2=1&prefixsug=u4e00&rsp=0&inputT=1509&rsv_sug4=1558";
//    [NaVc pushViewController:vc animated:YES];
//    return;
    
    if ([datad.openMode isEqualToString:@"1"]) { //打开app
        
        
        if (![datad.param isKindOfClass:[NSNull class]] || !datad.param|| !datad.param.length) {
            NSRange tmp = [datad.param rangeOfString:@"|"];
            if (tmp.location == NSNotFound) {
                return;
            }
            NSString *str = [datad.param substringWithRange:NSMakeRange(0,tmp.location)];
            if (![str hasSuffix:@"://"]) {
                str = [str stringByAppendingString:@"://"];
            }

            if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:str]]) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            }else{
                GlobalParams *arrryDes = [NSKeyedUnarchiver unarchiveObjectWithFile:ALLHDATA];
                if (arrryDes) {
//                    if (!arrryDes.iosAuditFlagQ || [arrryDes.iosAuditFlagQ isEqualToString:@"0"]) {
//
//                    }else{
                        str = [datad.param substringWithRange:NSMakeRange(tmp.location+1,datad.param.length-1-tmp.location)];
                        if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:str]]) {
                            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
                        }
//                    }
                }
                
            }
        }
    }else if ([datad.openMode isEqualToString:@"2"]){
        if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:datad.url]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:datad.url]];
        }
    }else if([datad.openMode isEqualToString:@"3"]){ //打开url
        baseWeb *vc = [[baseWeb alloc]init];
        vc.title = datad.appName;
        vc.url = datad.url;
        vc.isRefeth = NO;
        [NaVc pushViewController:vc animated:YES];
    }
}
@end
