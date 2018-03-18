//
//  PopRecordView.h
//  37duxinB
//
//  Created by Zhang Xinrong on 15/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopRecordView : UIView{
    
    UITextView *_textView;
    
}
@property(nonatomic,copy)void(^cancelBlock)(void);
@property(nonatomic,copy)void(^confirmBlock)(NSMutableDictionary *dic);
@end
