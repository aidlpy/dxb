//
//  PopRecordView.m
//  37duxinB
//
//  Created by Zhang Xinrong on 15/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "PopRecordView.h"


@implementation PopRecordView


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self.layer setCornerRadius:6.0f];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 32,frame.size.width, 16)];
        titleLabel.text = @"订单记录";
        titleLabel.textColor = Color_1F1F1F;
        titleLabel.font = [UIFont systemFontOfSize:17.0f];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLabel];
        
        UILabel *typelabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 80,60,18)];
        typelabel.text = @"客户类型";
        typelabel.textColor = Color_1F1F1F;
        typelabel.font = [UIFont systemFontOfSize:14.0f];
        typelabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:typelabel];
        
        UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(left(typelabel)+11,0,70, 25)];
        leftBtn.center = CGPointMake(leftBtn.center.x,typelabel.center.y);
        [leftBtn.layer setBorderColor:Color_DCDCDC.CGColor];
        [leftBtn.layer setBorderWidth:1.0f];
        [leftBtn.layer setCornerRadius:2.0f];
        [leftBtn setTitle:@"意向客户" forState:UIControlStateNormal];
        [leftBtn setTitleColor:Color_4C4C4C forState:UIControlStateNormal];
        leftBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        [self addSubview:leftBtn];
        
        UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(left(leftBtn)+11,0,70, 25)];
        rightBtn.center = CGPointMake(rightBtn.center.x,typelabel.center.y);
        [rightBtn.layer setBorderColor:Color_DCDCDC.CGColor];
        [rightBtn.layer setBorderWidth:1.0f];
        [rightBtn.layer setCornerRadius:2.0f];
        [rightBtn setBackgroundColor:Color_EB7580];
        [rightBtn setTitle:@"非意向客户" forState:UIControlStateNormal];
        [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        rightBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        [self addSubview:rightBtn];
        
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(14,bottom(typelabel)+14,self.frame.size.width-28, 179)];
        [_textView.layer setCornerRadius:4.0f];
        [_textView.layer setBorderColor:Color_DCDCDC.CGColor];
        [_textView.layer setBorderWidth:1.0f];
        [self addSubview:_textView];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0,bottom(_textView)+15,w(self),1)];
        lineView.backgroundColor = Color_F1F1F1;
        [self addSubview:lineView];
        
        UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, bottom(lineView),w(self)/2,50)];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:Color_FE6C7E forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelBtn];
        
        UIButton *confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(left(cancelBtn), bottom(lineView),w(self)/2,50)];
        [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [confirmBtn setTitleColor:Color_57CAE7 forState:UIControlStateNormal];
        [confirmBtn addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:confirmBtn];

        
    }
    return self;
}

-(void)cancelAction:(UIButton *)sender{
    
    NSNotification *notifyEMLogin =[NSNotification notificationWithName:CancelPopView object:nil userInfo:nil];
    [[NSNotificationCenter defaultCenter] postNotification:notifyEMLogin];
    
}

-(void)confirmAction:(UIButton *)sender{
    
    
    NSDictionary *dic = @{@"record":_textView.text,@"type":@"1"};
    NSNotification *notifyEMLogin =[NSNotification notificationWithName:ConfrimPopView object:nil userInfo:dic];
    [[NSNotificationCenter defaultCenter] postNotification:notifyEMLogin];
    
}

-(void)dealloc{

        //移除登录更新通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CancelPopView object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ConfrimPopView object:nil];
        

    
}

@end
