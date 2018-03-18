//
//  WithDrawRecordCell.m
//  37duxinB
//
//  Created by 37duxin on 11/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "WithDrawRecordCell.h"

@implementation WithDrawRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, 100,13.5)];
        _titleLabel.text = @"提现";
        _titleLabel.font = FONT_15;
        _titleLabel.textColor = Color_1F1F1F;
        [self addSubview:_titleLabel];
        
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15,bottom(_titleLabel)+12,150,10)];
        _timeLabel.font = FONT_10;
        _timeLabel.textColor = Color_BABABA;
        _timeLabel.text=@"2018-01-01 12:00:00";
        [self addSubview:_timeLabel];
        
        
        _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(SIZE.width/2,0,SIZE.width/2-15,15)];
        _moneyLabel.center = CGPointMake(_moneyLabel.center.x,35);
        _moneyLabel.textColor = Color_1F1F1F;
        _moneyLabel.text = @"-200.00";
        _moneyLabel.textAlignment = NSTextAlignmentRight;
        _moneyLabel.font = FONT_15;
        [self addSubview:_moneyLabel];
        
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 69, SIZE.width, 1)];
        lineView.backgroundColor = Color_F1F1F1;
        [self addSubview:lineView];
        
    }
    
    return self;
}

-(void)updateUI:(WithdrawRecordModel *)model
{
    _moneyLabel.text = [NSString stringWithFormat:@"%@%@",@"-",model.withDrawMoney];
    _timeLabel.text = model.withDrawDate;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
