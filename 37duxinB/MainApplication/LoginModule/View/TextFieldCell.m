//
//  TextFieldCell.m
//  37duxinB
//
//  Created by 37duxin on 05/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "TextFieldCell.h"

@implementation TextFieldCell

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
        
        _requiredImagView = [[UIImageView alloc] initWithFrame:CGRectMake(left(_titleLab),_titleLab.frame.origin.x-2,8, 8)];
        [_requiredImagView setImage:[UIImage imageNamed:Image(@"star")]];
        [self addSubview:_requiredImagView];
        
        _textFild = [[UITextField alloc] initWithFrame:CGRectMake(90,0,SIZE.width-55-w(_titleLab),20)];
        _textFild.center = CGPointMake(_textFild.center.x, _titleLab.center.y);
        _textFild.delegate = self;
        _textFild.tag = self.tag;
        _textFild.textColor = Color_4B4B4B;
        _textFild.font = FONT_12;
        [_textFild addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
        [self addSubview:_textFild];
        
        _rightArrow = [[UIImageView alloc] initWithFrame:CGRectMake(SIZE.width-23,0,7, 15)];
        _rightArrow.center = CGPointMake(_rightArrow.center.x,_titleLab.center.y);
        [_rightArrow setImage:[UIImage imageNamed:Image(@"grayRightArrow")]];
        [self addSubview:_rightArrow];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(20, 52, SIZE.width-20, 1)];
        lineView.backgroundColor = Color_F1F1F1;
        [self addSubview:lineView];
        
    }
    
    return self;
}

-(void)textChange:(UITextField *)textField{
    
    if (_textFieldBlock) {
        textField.tag = self.tag;
        _textFieldBlock(textField);
    }
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string; {
 
    return YES;
}

-(void)updateUI:(NSDictionary *)dic{
    
    _titleLab.text = [dic objectForKey:@"title"];
    CGSize size = [_titleLab boundingRectWithSize:CGSizeMake(0, 20)];
    [_titleLab setMj_w:size.width];
    [_requiredImagView setMj_x:left(_titleLab)];
    _requiredImagView.hidden = ![[dic objectForKey:@"required"] boolValue];
    
    _textFild.placeholder = [dic objectForKey:@"palceHolder"];
    _textFild.enabled = [[dic objectForKey:@"editable"] boolValue];
    _rightArrow.hidden = [[dic objectForKey:@"arrowState"] boolValue];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
