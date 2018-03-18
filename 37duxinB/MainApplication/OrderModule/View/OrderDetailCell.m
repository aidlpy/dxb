//
//  OrderDetailCell.m
//  37duxinB
//
//  Created by Zhang Xinrong on 13/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "OrderDetailCell.h"

@implementation OrderDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0,100,15)];
        _titleLabel.textColor = Color_1F1F1F;
        _titleLabel.font = FONT_15;
        _titleLabel.center = CGPointMake(_titleLabel.center.x,25);
        [self addSubview:_titleLabel];
        
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(115,0,SIZE.width-125,15)];
        _detailLabel.center = CGPointMake(_detailLabel.center.x, _titleLabel.center.y);
        _detailLabel.textColor = Color_BABABA;
        _detailLabel.font = FONT_15;
        _detailLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_detailLabel];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 49, SIZE.width, 1)];
        lineView.backgroundColor = Color_F1F1F1;
        [self addSubview:lineView];
        
    }
    return self;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
