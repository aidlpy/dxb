//
//  PopTagSelectView.m
//  37duxinB
//
//  Created by Zhang Xinrong on 22/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "PopTagSelectView.h"

@implementation PopTagSelectView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        _tagsArray = @[@"恋爱婚姻",@"职业发展",@"亲子教育",@"性心理",@"人际关系",@"个人成长",@"情绪压力",@"解梦",@"星座占卜"];
        _statusArray= [[NSMutableArray alloc] initWithObjects:@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0", nil];

        [self.layer setCornerRadius:6.0f];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, 32,frame.size.width, 16)];
        titleLabel.text = @"请选择咨询类别(可多选)";
        titleLabel.textColor = Color_1F1F1F;
        titleLabel.font = [UIFont systemFontOfSize:16.0f];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:titleLabel];
        
        UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(12.5,bottom(titleLabel)+19,w(self)-25.0f,150.0f)];
        baseView.backgroundColor = [UIColor whiteColor];
        [baseView.layer setCornerRadius:3.0f];
        [baseView.layer setBorderColor:Color_DCDCDC.CGColor];
        [baseView.layer setBorderWidth:0.5f];
        [self addSubview:baseView];
        
        
        UIButton *btn4 = [self tagStytle:_tagsArray[4] withFrame:CGRectMake(0, 0,70,25)];
        btn4.tag = 4;
        [btn4 addTarget:self action:@selector(btnSelected:) forControlEvents:UIControlEventTouchUpInside];
        btn4.center = CGPointMake(w(baseView)/2,h(baseView)/2);
        [baseView addSubview:btn4];
        
        UIButton *btn5= [self tagStytle:_tagsArray[5] withFrame:CGRectMake(left(btn4)+15, 0,70,25)];
        btn5.tag = 5;
        [btn5 addTarget:self action:@selector(btnSelected:) forControlEvents:UIControlEventTouchUpInside];
        btn5.center = CGPointMake(btn5.center.x,btn4.center.y);
        [baseView addSubview:btn5];
        
        UIButton *btn3 = [self tagStytle:_tagsArray[3] withFrame:CGRectMake(x(btn4)-85, 0,70,25)];
        btn3.tag = 3;
        [btn3 addTarget:self action:@selector(btnSelected:) forControlEvents:UIControlEventTouchUpInside];
        btn3.center = CGPointMake(btn3.center.x,btn4.center.y);
        [baseView addSubview:btn3];
        
        UIButton *btn1 = [self tagStytle:_tagsArray[1] withFrame:CGRectMake(x(btn4),y(btn4)-45,70,25)];
        btn1.tag = 1;
        [btn1 addTarget:self action:@selector(btnSelected:) forControlEvents:UIControlEventTouchUpInside];
        [baseView addSubview:btn1];
        
        UIButton *btn0 = [self tagStytle:_tagsArray[0] withFrame:CGRectMake(x(btn3),y(btn1),70,25)];
        btn0.tag = 0;
        [btn0 addTarget:self action:@selector(btnSelected:) forControlEvents:UIControlEventTouchUpInside];
        [baseView addSubview:btn0];
        
        UIButton *btn2 = [self tagStytle:_tagsArray[2] withFrame:CGRectMake(left(btn1)+15,y(btn1),70,25)];
        btn2.tag = 2;
        [btn2 addTarget:self action:@selector(btnSelected:) forControlEvents:UIControlEventTouchUpInside];
        [baseView addSubview:btn2];
        
        UIButton *btn7 = [self tagStytle:_tagsArray[7] withFrame:CGRectMake(x(btn4),y(btn4)+45,70,25)];
        btn7.tag = 7;
        [btn7 addTarget:self action:@selector(btnSelected:) forControlEvents:UIControlEventTouchUpInside];
        [baseView addSubview:btn7];
        
        UIButton *btn6 = [self tagStytle:_tagsArray[6] withFrame:CGRectMake(x(btn0),y(btn7),70,25)];
        btn6.tag = 6;
        [btn6 addTarget:self action:@selector(btnSelected:) forControlEvents:UIControlEventTouchUpInside];
        [baseView addSubview:btn6];
        
        UIButton *btn8 = [self tagStytle:_tagsArray[8] withFrame:CGRectMake(left(btn7)+15,y(btn7),70,25)];
        btn8.tag = 8;
        [btn8 addTarget:self action:@selector(btnSelected:) forControlEvents:UIControlEventTouchUpInside];
        [baseView addSubview:btn8];

        _btnArray = @[btn0,btn1,btn2,btn3,btn4,btn5,btn6,btn7,btn8];
        
        UIButton *confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,bottom(baseView)+20,w(self),50)];
        confirmBtn.center = CGPointMake(w(self)/2,confirmBtn.center.y);
        [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [confirmBtn setTitleColor:Color_57CAF7 forState:UIControlStateNormal];
        [confirmBtn addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:confirmBtn];
        
        
    }
    return self;
}

-(void)btnSelected:(UIButton *)sender{
    
    __block NSInteger selectedCount = 0;
    [_statusArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *string =(NSString *)obj;
        if ([string integerValue] ==1) {
            selectedCount++;
        }
    }];
    
    if (selectedCount >= _limitTags) {
     
        NSString *string = _statusArray[sender.tag];
        UIButton *btn = _btnArray[sender.tag];
        if ([string integerValue] == 0) {
            NSString *warningInfo = [NSString stringWithFormat:@"标签不可以超过%ld个",(long)_limitTags];
            [SVHUD showErrorWithDelay:warningInfo time:0.8f];
            
        }
        else
        {
            [btn setTitleColor:Color_4C4C4C forState:UIControlStateNormal];
            [btn setBackgroundColor:[UIColor whiteColor]];
            [_statusArray replaceObjectAtIndex:sender.tag withObject:@"0"];
        }
        
    }
    else
    {
        NSString *string = _statusArray[sender.tag];
        UIButton *btn = _btnArray[sender.tag];
        if ([string integerValue] == 0) {
            
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn setBackgroundColor:Color_57CAF7];
            [_statusArray replaceObjectAtIndex:sender.tag withObject:@"1"];
            
        }
        else
        {
            [btn setTitleColor:Color_4C4C4C forState:UIControlStateNormal];
            [btn setBackgroundColor:[UIColor whiteColor]];
            [_statusArray replaceObjectAtIndex:sender.tag withObject:@"0"];
        }
        
    }
}

-(UIButton *)tagStytle:(NSString *)title withFrame:(CGRect)frame{
    
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];
    [btn.layer setBorderWidth:0.5f];
    [btn.layer setCornerRadius:h(btn)/2];
    [btn.layer setBorderColor:Color_DCDCDC.CGColor];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:Color_4C4C4C forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    return btn;
    
}

-(void)confirmAction:(UIButton *)sender{
    
    NSLog(@"_statusArray==>%@",_statusArray);
    __block NSString *tagsString = @"";
    __block NSInteger count = 0;
    [_statusArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *status = (NSString *)obj;
        if ([status integerValue] == 1) {
            count++;
            if (tagsString.length == 0) {
                tagsString = [NSString stringWithFormat:@"%@%ld",tagsString,(long)idx+1];
            }
            else
            {
                tagsString = [NSString stringWithFormat:@"%@,%ld",tagsString,(long)idx+1];
            }
        }
    }];
    if (count <= 3) {
        _rowHeight = 53.0f;
    }
    else if(count>=3 && count <= 6)
    {
        _rowHeight = 80.0f;
    }
    else{
        
        _rowHeight = 105.0f;
    }
    
    NSString *rowHeight = [NSString stringWithFormat:@"%ld",(long)_rowHeight];
    NSDictionary *dic = @{@"tags":tagsString,@"rowHeight":rowHeight};
    NSNotification *notifyEMLogin =[NSNotification notificationWithName:ConfrimPopView object:nil userInfo:dic];
    [[NSNotificationCenter defaultCenter] postNotification:notifyEMLogin];
    
}

-(void)dealloc{
    
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ConfrimPopView object:nil];
    
    
    
}


@end
