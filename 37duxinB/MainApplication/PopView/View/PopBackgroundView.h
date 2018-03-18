//
//  PopBackgroundView.h
//  37duxinB
//
//  Created by Zhang Xinrong on 15/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopBackgroundView : UIView
@property(nonatomic,assign)CGFloat cellHight;
@property(nonatomic,copy)void(^confrimBlock)(NSDictionary *dic);
-(instancetype)initWithFrame:(CGRect)frame withPopView:(id)popView;
@end
