//
//  DeepWatingForConsultingCell.h
//  37duxinB
//
//  Created by Zhang Xinrong on 12/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConsultingSubOrderModel.h"

@interface DeepWatingForConsultingCell : UITableViewCell
@property(nonatomic,retain)UILabel *userLabel;
@property(nonatomic,retain)UIButton *btnAction;
@property(nonatomic,retain)UIView *lineView;
@property(nonatomic,retain)UIImageView *typeImageView;
@property(nonatomic,retain)UILabel *packageLabel;
@property(nonatomic,retain)UIImageView *arrowImageView;
@property(nonatomic,retain)UILabel *currentPriceLabel;
@property(nonatomic,retain)UILabel *oldPriceLabel;
@property(nonatomic,retain)UILabel *questionDetailLabel;
@property(nonatomic,retain)UILabel *packageTimes;

-(void)updateUI:(ConsultingSubOrderModel *)model;
@end
