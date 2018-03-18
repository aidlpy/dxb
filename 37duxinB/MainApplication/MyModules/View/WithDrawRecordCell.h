//
//  WithDrawRecordCell.h
//  37duxinB
//
//  Created by 37duxin on 11/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WithdrawRecordModel.h"

@interface WithDrawRecordCell : UITableViewCell
@property(nonatomic,retain)UILabel *titleLabel;
@property(nonatomic,retain)UILabel *timeLabel;
@property(nonatomic,retain)UILabel *moneyLabel;

-(void)updateUI:(WithdrawRecordModel *)model;
@end
