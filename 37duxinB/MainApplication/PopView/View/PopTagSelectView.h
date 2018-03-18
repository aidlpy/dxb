//
//  PopTagSelectView.h
//  37duxinB
//
//  Created by Zhang Xinrong on 22/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopTagSelectView : UIView{
    
    NSMutableArray *_statusArray;
    NSArray *_tagsArray;
    
}
@property(nonatomic,assign)CGFloat rowHeight;
@property(nonatomic,retain)NSArray *btnArray;
@property(nonatomic,assign)NSInteger limitTags;

@end
