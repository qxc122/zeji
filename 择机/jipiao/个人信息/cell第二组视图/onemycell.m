//
//  onemycell.m
//  jipiao
//
//  Created by Store on 16/8/18.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "onemycell.h"
#import "HeaderTotal.h"

@interface onemycell ()<UIAlertViewDelegate>
@property (nonatomic,weak) UILabel *namestr;
@property (nonatomic,weak) UILabel *desstr;
@property (nonatomic,weak) UIButton *btn;
@property (nonatomic,weak) UIImageView *hiouha;
@end

@implementation onemycell
#define onemycellIdentifier @"onemycellIdentifier"
+ (instancetype)returnCellWith:(UITableView *)tableView
{
    onemycell *cell = [tableView dequeueReusableCellWithIdentifier:onemycellIdentifier];
    if (cell == nil) {
        cell = [[onemycell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:onemycellIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UILabel *namestr =[[UILabel alloc]init];
        self.namestr = namestr;
        [self.contentView addSubview:namestr];
        
        UILabel *desstr =[[UILabel alloc]init];
        self.desstr = desstr;
        [self.contentView addSubview:desstr];
        
        UIImageView *hiouha = [[UIImageView alloc]init];
        self.hiouha = hiouha;
        [self.contentView addSubview:hiouha];
        
        UIButton *btn = [[UIButton alloc]init];
        self.btn = btn;
        [self.contentView addSubview:btn];
        [btn addTarget:self action:@selector(btnClickmy) forControlEvents:UIControlEventTouchUpInside];
        
        namestr.textAlignment = NSTextAlignmentRight;
        namestr.textColor = RGBColor(173, 173, 173);
        namestr.font = [UIFont systemFontOfSize:14];
        desstr.textColor = RGBColor(255, 255, 255);
        desstr.font = [UIFont systemFontOfSize:14];
        
        [namestr mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.top.equalTo(self).offset(5);
            make.width.equalTo(@(80));
            make.bottom.equalTo(self).offset(-5);
        }];
        [desstr mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(namestr.mas_right);
            make.top.equalTo(namestr);
            make.right.equalTo(hiouha.mas_left);
            make.bottom.equalTo(namestr);
        }];
        [hiouha mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(namestr);
            make.right.equalTo(self).offset(-17);
            make.width.equalTo(hiouha.mas_height);
            make.bottom.equalTo(namestr);
        }];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.right.equalTo(self);
            make.width.equalTo(self);
            make.bottom.equalTo(self);
        }];
        hiouha.image = [UIImage imageNamed:@"icon_modify"];
        btn.backgroundColor = [UIColor clearColor];
    }
    return self;
}
- (void)btnClickmy{
    if ([self.realnameStatus  isEqualToString:@"1"]) {
        if ([self.delegate respondsToSelector:@selector(showMSg:)]) {
            [self.delegate showMSg:@"您是实名用户,不可修改"];
        }
    }else{
        if ([self.registerType isEqualToString:@"01"]) { //微信注册

        }else{  //手机注册
            if (self.index == 4) {
                if ([self.delegate respondsToSelector:@selector(showMSg:)]) {
                    [self.delegate showMSg:@"不可修改手机号"];
                }
                return;
            }
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"修改%@",self.namestr.text] delegate:self cancelButtonTitle:NSLocalizedString(@"cancel", @"Cancel") otherButtonTitles:NSLocalizedString(@"ok", @"OK"), nil];
        [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
        if (self.index == 4) {
            //设置输入框的键盘类型
            UITextField *tf = [alert textFieldAtIndex:0];
            tf.keyboardType = UIKeyboardTypePhonePad;
        }
        [alert show];
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex != 0) {
        UITextField *input = [alertView textFieldAtIndex:0];
        self.desstr.text = input.text;
        if ([self.delegate respondsToSelector:@selector(mybtnClick::)]) {
            [self.delegate mybtnClick:self.index :input.text];
        }

    }
}
- (void)setIsHiddenArrow:(BOOL)isHiddenArrow{
    _isHiddenArrow = isHiddenArrow;
    self.btn.hidden = isHiddenArrow;
    self.hiouha.hidden = isHiddenArrow;
}
- (void)setName:(NSString *)name{
    _name = name;
    self.namestr.text = name;
//            self.namestr.text = @"名字：";
//            self.desstr.text = @"里王";
}
- (void)setDes:(NSString *)des{
    _des = des;

    if (self.index == 2) {
        if (des.length >1) {
            des = [des stringByReplacingCharactersInRange:NSMakeRange(des.length-1, 1) withString:@"*"];
            self.desstr.textColor = RGBColor(255, 255, 255);
        }else{
            des = @"请输入姓名";
            self.desstr.textColor = RGBColor(82, 82, 82);
        }
    } else if (self.index == 3){
        if (des.length >12) {
            des = [des stringByReplacingCharactersInRange:NSMakeRange(des.length-12, 8) withString:@"********"];
            self.desstr.textColor = RGBColor(255, 255, 255);
        }else{
            des = @"请输入身份证";
            self.desstr.textColor = RGBColor(82, 82, 82);
        }
    } else if (self.index == 4){
        if (des.length >8) {
            des = [des stringByReplacingCharactersInRange:NSMakeRange(des.length-8, 4) withString:@"****"];
            self.desstr.textColor = RGBColor(255, 255, 255);
        }else{
            des = @"请输入手机号码";
            self.desstr.textColor = RGBColor(82, 82, 82);
        }
    }
    self.desstr.text = des;
//            self.namestr.text = @"名字：";
//            self.desstr.text = @"里王";
}
@end
