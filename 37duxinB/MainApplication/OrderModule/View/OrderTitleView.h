//
//  OrderTitleView.h
//  duxin
//
//  Created by 37duxin on 24/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^IndxBlock)(NSInteger index) ;

@interface OrderTitleView : UIView
{
  
    UIView *_linebackView;
    UIView *_SlideView;
}
@property(nonatomic,copy)IndxBlock indexBlock;
@property(nonatomic,retain)NSMutableArray *btnArray;
-(instancetype)initWithFrame:(CGRect)frame withArray:(NSArray *)array;

@end
