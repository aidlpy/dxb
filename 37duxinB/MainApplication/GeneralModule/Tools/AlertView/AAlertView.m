//
//  AAlertView.m
//  duxin
//
//  Created by 37duxin on 27/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "AAlertView.h"

@implementation AAlertView

+(void)alert:(id)controller message:(NSString *)message confirm:(void (^) (void))resultBlock completion:( void (^) (void))completionBlock{
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        nil;
    }];
    
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        resultBlock();
    }];
    
    [alertVc addAction:cancle];
    [alertVc addAction:confirm];
    
    [controller presentViewController:alertVc animated:YES completion:^{
        completionBlock();
    }];
    

}

+(void)alertWithTitle:(NSString *)title controller:(id)controller message:(NSString *)message confirm:(void (^) (void))resultBlock completion:( void (^) (void))completionBlock{
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    //如果你的系统大于等于7.0
    
    UIView *subView1 = alertVc.view.subviews[0];
    
    UIView *subView2 = subView1.subviews[0];
    
    UIView *subView3 = subView2.subviews[0];
    
    UIView *subView4 = subView3.subviews[0];
    
    UIView *subView5 = subView4.subviews[0];
    
    UILabel * messageLabel = subView5.subviews[1];
    
    messageLabel.textAlignment=NSTextAlignmentLeft;
    
    messageLabel.text=message;
    messageLabel.textColor = Color_4C4C4C;
    messageLabel.font = [UIFont systemFontOfSize:12.0f];
    
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        resultBlock();
    }];
    
     [alertVc addAction:confirm];
    
    [controller presentViewController:alertVc animated:YES completion:^{
        completionBlock();
    }];
   
    
}

@end
