//
//  LoginView.h
//  duxin
//
//  Created by 37duxin on 20/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"
#import "JKCountDownButton.h"

typedef void(^fetchCodeBlock)(JKCountDownButton *sender);//发送验证码回调
@interface LoginView : UIView
@property(nonatomic,retain)UIImageView *logoImageView;
@property(nonatomic,retain)UITextField *textField;
@property(nonatomic,retain)JKCountDownButton *codeBtn;
@property(nonatomic,retain)UIButton *passwordBtn;
@property(nonatomic,retain)UIView *lineView;
@property(nonatomic,copy)fetchCodeBlock codeBlock;
@property(nonatomic,assign)BOOL isHide;


-(void)setLogoImageView:(NSString *)imageStr setPlaceHolder:(NSString *)placeHolder;

@end
