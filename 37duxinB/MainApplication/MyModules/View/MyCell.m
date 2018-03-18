    //
//  MyCell.m
//  37duxinB
//
//  Created by 37duxin on 06/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "MyCell.h"

@implementation MyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        

        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0,49,SIZE.width, 1)];
        lineView.backgroundColor = Color_F1F1F1;
        [self addSubview:lineView];
        
    }
    return  self;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
