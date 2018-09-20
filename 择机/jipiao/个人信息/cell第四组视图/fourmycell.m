//
//  fourmycell.m
//  jipiao
//
//  Created by Store on 16/8/18.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "fourmycell.h"
#import "HeaderTotal.h"
@interface fourmycell ()
@property (nonatomic,weak) UILabel *name;
@property (nonatomic,weak) UILabel *idcard;
@property (nonatomic,weak) UILabel *phone;
@property (nonatomic,weak) UIButton *btn;
@end


@implementation fourmycell
#define fourmycellIdentifier @"fourmycellIdentifier"
+ (instancetype)returnCellWith:(UITableView *)tableView
{
    fourmycell *cell = [tableView dequeueReusableCellWithIdentifier:fourmycellIdentifier];
    if (cell == nil) {
        cell = [[fourmycell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:fourmycellIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *name = [[UILabel alloc]init];
        self.name = name;
        [self.contentView addSubview:name];
        UILabel *idcard = [[UILabel alloc]init];
        self.idcard = idcard;
        [self.contentView addSubview:idcard];
        UILabel *phone = [[UILabel alloc]init];
        self.phone = phone;
        [self.contentView addSubview:phone];
        UIButton *btn = [[UIButton alloc]init];
        self.btn = btn;
        [self.contentView addSubview:btn];
        [btn setImage:[UIImage imageNamed:@"icon_delete"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnfourmy) forControlEvents:UIControlEventTouchUpInside];
        
        [name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(5);
             make.right.equalTo(idcard.mas_left).offset(-5);
             make.top.equalTo(self);
//            make.width.equalTo(@60);
             make.bottom.equalTo(self);
        }];
        [idcard mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(phone.mas_left).offset(-5);
            make.top.equalTo(name);
            make.bottom.equalTo(name);
        }];
        [phone mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(btn.mas_left).offset(-5);
            make.top.equalTo(name);
            make.bottom.equalTo(name);
        }];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-5);
            make.centerY.equalTo(self);
            make.height.equalTo(@15);
            make.width.equalTo(btn.mas_height);
        }];
//        name.backgroundColor = [UIColor redColor];
        name.font = [UIFont systemFontOfSize:13];
        idcard.font = [UIFont systemFontOfSize:13];
        phone.font = [UIFont systemFontOfSize:13];
        name.textColor = RGBColor(255, 255, 255);
        idcard.textColor = RGBColor(255, 255, 255);
        phone.textColor = RGBColor(255, 255, 255);
        name.textAlignment = NSTextAlignmentLeft;
        idcard.textAlignment = NSTextAlignmentCenter;
        phone.textAlignment = NSTextAlignmentRight;
        //test
//        name.text = @"名字我是";
//        idcard.text = @"4304**********4556";
//        phone.text = @"170****5055";
    }
    return self;
}
- (void)btnfourmy{
    NSString *typpe = (self.index.section==2)?@"1":@"2";
    NSString *contactIdStr = (self.index.section==2)?self.data.contactId:self.datatwo.contactId;
    NSNumber *contactId  = [[NSNumber alloc]initWithInt:[contactIdStr intValue]];
    __weak typeof(self) weakSelf = self;
    [MBProgressHUD showMessage:nil];
    [[TWClient sharedInstance]deleteContactWithcontactType:typpe contactId:contactId success:^(id dataDict, NSString *msg, NSInteger code) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showSuccess:msg];
        if ([weakSelf.delegate respondsToSelector:@selector(fourmycellbtnnnClick:)]) {
            [weakSelf.delegate fourmycellbtnnnClick:weakSelf.index];
        }
    } failure:^(NSInteger errorCode, NSString *msg) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:msg];
    }];
}
- (void)setData:(contactinformation *)data{
    _data = data;
    self.btn.hidden = NO;
    self.name.font = [UIFont systemFontOfSize:13];
    self.name.text = data.userName;

        if (data.certNo.length >12) {
            self.idcard.text = [data.certNo stringByReplacingCharactersInRange:NSMakeRange(data.certNo.length-12, 8) withString:@"********"];
        }else{
           self.idcard.text = data.certNo;
        }

        if (data.mobile.length >8) {
            self.phone.text = [data.mobile stringByReplacingCharactersInRange:NSMakeRange(data.mobile.length-8, 4) withString:@"****"];
        }else{
            self.phone.text = data.mobile;  
        }
    
}
- (void)setDatatwo:(contactinformationTwo *)datatwo{
    _datatwo = datatwo;
    self.btn.hidden = NO;
    self.name.font = [UIFont systemFontOfSize:13];
    if (datatwo.mobile.length >8) {
        self.phone.text = [datatwo.mobile stringByReplacingCharactersInRange:NSMakeRange(datatwo.mobile.length-8, 4) withString:@"****"];
    }
    
//    self.phone.text = datatwo.mobile;
    if (datatwo.userName) {
        self.name.text = datatwo.userName;
    }else{
        if (datatwo.mobile.length>8) {
            NSString *tmp = [datatwo.mobile stringByReplacingCharactersInRange:NSMakeRange(0, 8) withString:@""];
            self.name.text = [@"秘书-" stringByAppendingString:tmp];
        }
    }
    self.idcard.text = @"";
}
- (void)setIndex:(NSIndexPath *)index{
    _index = index;
    if (index.section == 2) {
        self.backgroundColor = [UIColor clearColor];
    } else if (index.section == 3){
        self.backgroundColor = RGBColor(3, 13, 29);
    }
}
- (void)setMsg:(NSString *)msg{
    self.name.text = msg;
    self.name.font = [UIFont systemFontOfSize:10];
    self.phone.text = @"";
    self.idcard.text = @"";
    self.btn.hidden = YES;
}
@end
