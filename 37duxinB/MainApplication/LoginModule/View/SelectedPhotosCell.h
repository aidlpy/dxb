//
//  SelectedPhotosCell.h
//  37duxinB
//
//  Created by 37duxin on 05/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^photoSelectionBlock)(BOOL isLeft,NSInteger tag);
@interface SelectedPhotosCell : UITableViewCell
@property(nonatomic,retain)UILabel *titleLab;
@property(nonatomic,retain)UIImageView *requiredImagView;
@property(nonatomic,retain)UIButton *leftBtn;
@property(nonatomic,retain)UIButton *rightBtn;
@property(nonatomic,retain)UIView *lineView;
@property(nonatomic,copy)photoSelectionBlock photoSelectionBlock;
-(void)updateUI:(NSDictionary *)dic;
@end
