//
//  addmishu.m
//  jipiao
//
//  Created by Store on 16/8/19.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "addmishu.h"
#import "HeaderTotal.h"
#import "myinfo.h"
#import "MHLoadContactController.h"
@interface addmishu ()<UITextFieldDelegate>
@property (nonatomic,weak) UITextField *label1;
@end

@implementation addmishu
#define addmishuIdentifier @"addmishuIdentifier"
+ (instancetype)returnCellWith:(UITableView *)tableView
{
    addmishu *cell = [tableView dequeueReusableCellWithIdentifier:addmishuIdentifier];
    if (cell == nil) {
        cell = [[addmishu alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:addmishuIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = RGBColor(3, 13, 29);
//        self.backgroundColor = RGBColor(255, 255, 255);
        UILabel *label = [[UILabel alloc]init];
        [self.contentView addSubview:label];
        
        UITextField *label1 = [[UITextField alloc]init];
        label1.delegate = self;
        self.label1 = label1;
        [self.contentView addSubview:label1];
        
        UIView *view = [[UIView alloc]init];
        [self.contentView addSubview:view];
        
        UIButton *label2 = [[UIButton alloc]init];
        [self.contentView addSubview:label2];
        
        UIButton *label3 = [[UIButton alloc]init];
        [self.contentView addSubview:label3];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(40);
            make.right.equalTo(label1.mas_left).offset(-7);
            make.centerY.equalTo(self);
        }];
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(label2.mas_left);
            make.top.equalTo(label);
            make.width.equalTo(@(125*WIDTHICON));
            make.bottom.equalTo(label);
        }];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(label.mas_right);
            make.right.equalTo(label1);
            make.top.equalTo(label1.mas_bottom).offset(2);
            make.height.equalTo(@1);
        }];
        [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(label3.mas_left).offset(-9);
            make.centerY.equalTo(self);
            make.width.equalTo(@21);
            make.height.equalTo(@21);
        }];
        
        [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@50);
            make.top.equalTo(label2);
            make.bottom.equalTo(label2);
        }];
        view.backgroundColor = RGBColor(136, 136, 136);
        [label2 setImage:[UIImage imageNamed:@"icon_mail list_01"] forState:UIControlStateNormal];
        
        label.textColor = RGBColor(173, 173, 173);
        label1.placeholder = @"请输入手机号";
        label1.keyboardType = UIKeyboardTypeNumberPad;
        [label1 setValue:RGBColor(107, 107, 107) forKeyPath:@"_placeholderLabel.textColor"];
        label1.textColor = RGBColor(255, 255, 255);
        [label3 setTitleColor:RGBColor(23, 204, 39) forState:UIControlStateNormal];
        label3.layer.borderWidth = 1.0;
        label3.layer.borderColor = RGBColor(23, 242, 33).CGColor;
        label.font = [UIFont systemFontOfSize:14];
        label1.font = [UIFont systemFontOfSize:14];
        label3.titleLabel.font = [UIFont systemFontOfSize:14];
        label.text = @"手机号";
        
        [label3 setImage:[UIImage imageNamed:@"icon_add to_01"] forState:UIControlStateNormal];
//        [label3 setTitle:@"+ 添加" forState:UIControlStateNormal];
        [label2 addTarget:self action:@selector(label2Click:) forControlEvents:UIControlEventTouchUpInside];
        [label3 addTarget:self action:@selector(label3Click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)label2Click:(UIButton *)btn{
    NSLog(@"label2Click");
    if (self.label1.isFirstResponder) {
        [self.label1 resignFirstResponder];
    }
    MHLoadContactController *vc = [[MHLoadContactController alloc]init];
    vc.NotificationName = NOTIFINAME_ADDSECRETARY;
    [NaVc pushViewController:vc animated:YES];
}
- (void)label3Click:(UIButton *)btn{
    if (self.label1.isFirstResponder) {
        [self.label1 resignFirstResponder];
    }else{
        [self gotoDoingADDFriends];
    }
}
- (void)gotoDoingADDFriends{
    if (self.label1.isFirstResponder) {
        [self.label1 resignFirstResponder];
    }
    if ([self.delegate respondsToSelector:@selector(returnClickyyyaddmishu:)]) {
        [self.delegate returnClickyyyaddmishu:self.label1.text];
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self gotoDoingADDFriends];
}
- (void)setPhone:(NSString *)phone{
    _phone = phone;
    self.label1.text = phone;
}
@end
