//
//  OrderRecordCell.m
//  37duxinB
//
//  Created by Zhang Xinrong on 15/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "OrderRecordCell.h"

@implementation OrderRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _recordTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 25, 40, 25)];
        _recordTimeLabel.backgroundColor = Color_5ECAF7;
        _recordTimeLabel.textColor = [UIColor whiteColor];
        [self addSubview:_recordTimeLabel];
        
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(left(_recordTimeLabel)+8,0, 130, 18)];
        _timeLabel.center = CGPointMake(_timeLabel.center.x,_recordTimeLabel.center.y);
        _timeLabel.text = @"2015-10-10 16:00";
        _timeLabel.textColor = Color_1F1F1F;
        _timeLabel.font = FONT_11;
        [self addSubview:_timeLabel];
        
        _customComment = [[UIButton alloc] initWithFrame:CGRectMake(x(_timeLabel),bottom(_timeLabel)+20,70, 24)];
        [_customComment.layer setBorderColor:Color_F1F1F1.CGColor];
        [_customComment.layer setBorderWidth:1.0f];
        [_customComment.layer setCornerRadius:2.0f];
        [_customComment setTitle:@"用户评价" forState:UIControlStateNormal];
        [_customComment setTitleColor:Color_1F1F1F  forState:UIControlStateNormal];
        _customComment.titleLabel.font =[UIFont systemFontOfSize:13.0f];
        [self addSubview:_customComment];
        
        _consultingRecord = [[UIButton alloc] initWithFrame:CGRectMake(left(_customComment)+13,bottom(_timeLabel)+20,70, 24)];
        [_consultingRecord.layer setBorderColor:Color_F1F1F1.CGColor];
        [_consultingRecord.layer setBorderWidth:1.0f];
        [_consultingRecord.layer setCornerRadius:2.0f];
        [_consultingRecord setTitle:@"咨询记录" forState:UIControlStateNormal];
        [_consultingRecord setTitleColor:Color_1F1F1F forState:UIControlStateNormal];
         _consultingRecord.titleLabel.font =[UIFont systemFontOfSize:13.0f];
        [self addSubview:_consultingRecord];

    }
    return self;
    
}

-(void)updateUI:(id)model{
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
