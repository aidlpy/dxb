//
//  OrderTagsCell.m
//  37duxinB
//
//  Created by Zhang Xinrong on 13/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "OrderTagsCell.h"

@implementation OrderTagsCell

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
        
        
        
    }
    return self;
    
}

-(void)setTags:(NSArray *)array{
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
