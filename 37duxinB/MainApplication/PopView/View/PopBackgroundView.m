//
//  PopBackgroundView.m
//  37duxinB
//
//  Created by Zhang Xinrong on 15/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "PopBackgroundView.h"

@implementation PopBackgroundView

-(instancetype)initWithFrame:(CGRect)frame withPopView:(id)popView
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SIZE.width, SIZE.height)];
        button.backgroundColor = [UIColor blackColor];
        button.alpha = 0.6f;
        [button addTarget:self action:@selector(removeAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        UIView *customPopView = (UIView *)popView;
        customPopView.center = self.center;
        [self addSubview:customPopView];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeAction) name:CancelPopView object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(confirmReceived:) name:ConfrimPopView object:nil];
        
         [[[UIApplication sharedApplication].delegate window]  addSubview:self];

    }
    return self;
}

-(void)removeAction{
    
    [self removeFromSuperview];
    
}

-(void)confirmReceived:(NSNotification *)notification{
    
    NSDictionary *dic = [notification userInfo];
    _confrimBlock(dic);
    
}


@end
