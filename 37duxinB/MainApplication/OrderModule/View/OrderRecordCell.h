//
//  OrderRecordCell.h
//  37duxinB
//
//  Created by Zhang Xinrong on 15/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderRecordCell : UITableViewCell
@property(nonatomic,retain)UILabel *recordTimeLabel;
@property(nonatomic,retain)UILabel *timeLabel;
@property(nonatomic,retain)UIButton *customComment;
@property(nonatomic,retain)UIButton *consultingRecord;
@property(nonatomic,retain)UILabel *orderStatusLabel;

-(void)updateUI:(id)model;
@end
