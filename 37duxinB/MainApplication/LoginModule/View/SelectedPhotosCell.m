//
//  SelectedPhotosCell.m
//  37duxinB
//
//  Created by 37duxin on 05/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "SelectedPhotosCell.h"

@implementation SelectedPhotosCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(22, 15, 52, 20)];
        _titleLab.font = FONT_13;
        _titleLab.textColor = Color_4B4B4B;
        [self addSubview:_titleLab];
        
        _requiredImagView = [[UIImageView alloc] initWithFrame:CGRectMake(left(_titleLab),_titleLab.frame.origin.x-2,8, 8)];
        [_requiredImagView setImage:[UIImage imageNamed:Image(@"star")]];
        [self addSubview:_requiredImagView];
        
        _leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(left(_titleLab)+40, 0, 90, 60)];
        [_leftBtn setBackgroundImage:[UIImage imageNamed:Image(@"icside")] forState:UIControlStateNormal];
        _leftBtn.center = CGPointMake(_leftBtn.center.x,37.5);
        [_leftBtn addTarget:self action:@selector(leftBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_leftBtn];
        
        _rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(left(_leftBtn)+25, 0, 90, 60)];
        [_rightBtn setBackgroundImage:[UIImage imageNamed:Image(@"icotherside")] forState:UIControlStateNormal];
        _rightBtn.center = CGPointMake(_rightBtn.center.x,37.5);
        [_rightBtn addTarget:self action:@selector(rightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_rightBtn];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(20, 74, SIZE.width-20, 1)];
        lineView.backgroundColor = Color_F1F1F1;
        [self addSubview:lineView];
        
    }
    
    return self;
}

-(void)leftBtnAction:(UIButton *)sender{
    
    if (_photoSelectionBlock) {
        _photoSelectionBlock(YES,self.tag);
    }
    
}

-(void)rightBtnAction:(UIButton *)sender{
    
    if (_photoSelectionBlock) {
        _photoSelectionBlock(NO,self.tag);
    }
    
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
