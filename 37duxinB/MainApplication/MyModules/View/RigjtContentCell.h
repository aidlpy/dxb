//
//  RigjtContentCell.h
//  37duxinB
//
//  Created by 37duxin on 09/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RigjtContentCell : UITableViewCell
@property(nonatomic,retain)UILabel *titleLab;
@property(nonatomic,retain)UIImageView *requiredImagView;
@property(nonatomic,retain)UILabel *rightLab;
@property(nonatomic,retain)UIImageView *rightArrow;
-(void)updateUI:(NSDictionary *)dic;
@end
