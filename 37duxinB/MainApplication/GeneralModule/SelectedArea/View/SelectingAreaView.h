//
//  SelectingAreaView.h
//  37duxinB
//
//  Created by Zhang Xinrong on 01/03/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectingAreaView : UIView
@property(nonatomic,copy)void (^fetchAreaBlock) (NSString *string);
@end
