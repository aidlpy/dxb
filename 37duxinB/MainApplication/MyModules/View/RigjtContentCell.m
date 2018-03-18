//
//  RigjtContentCell.m
//  37duxinB
//
//  Created by 37duxin on 09/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "RigjtContentCell.h"

@implementation RigjtContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(22, 0, 52, 20)];
        _titleLab.center = CGPointMake(_titleLab.center.x,26.5);
        _titleLab.font = FONT_13;
        _titleLab.textColor = Color_4B4B4B;
        [self addSubview:_titleLab];
        
        _requiredImagView = [[UIImageView alloc] initWithFrame:CGRectMake(left(_titleLab),_titleLab.frame.origin.x-2,8,8)];
        [_requiredImagView setImage:[UIImage imageNamed:Image(@"star")]];
        [self addSubview:_requiredImagView];
        
        
        _rightLab = [[UILabel alloc] initWithFrame:CGRectMake(left(_titleLab)+20,0,SIZE.width-left(_titleLab)-53,25)];
        _rightLab.center = CGPointMake(_rightLab.center.x, _titleLab.center.y);
        _rightLab.font = [UIFont systemFontOfSize:16.0f];
        _rightLab.textAlignment = NSTextAlignmentRight;
        _rightLab.textColor = Color_1F1F1F;
        [self addSubview:_rightLab];
        
        _rightArrow = [[UIImageView alloc] initWithFrame:CGRectMake(SIZE.width-23, 0, 8.5, 13.5)];
        _rightArrow.center = CGPointMake(_rightArrow.center.x, 25);
        [_rightArrow setImage:[UIImage imageNamed:Image(@"moreRightArrow")]];
        [self addSubview:_rightArrow];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(20, 52, SIZE.width-20, 1)];
        lineView.backgroundColor = Color_F1F1F1;
        [self addSubview:lineView];
        
    }
    return  self;
    
}

-(void)updateUI:(NSDictionary *)dic{
    
    _titleLab.text = [dic objectForKey:@"title"];
    CGSize size = [_titleLab boundingRectWithSize:CGSizeMake(0, 20)];
    
    [_titleLab setMj_w:size.width];
    [_requiredImagView setMj_x:left(_titleLab)];
    _requiredImagView.hidden = ![[dic objectForKey:@"required"] boolValue];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
