//
//  DeepConsultingCell.h
//  37duxinB
//
//  Created by 37duxin on 11/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConsultingOrderModel.h"

@interface DeepConsultingCell : UITableViewCell
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
@property(nonatomic,retain)UILabel *usedPageDeatils;
-(void)updateUI:(ConsultingOrderModel *)model;
@end
