//
//  TextFieldRightBtnCell.m
//  37duxinB
//
//  Created by Zhang Xinrong on 02/03/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "TextFieldRightBtnCell.h"

@implementation TextFieldRightBtnCell
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
        
        _showDetailBtn = [[UIButton alloc] initWithFrame:CGRectMake(SIZE.width-50,0,40, 40)];
        _showDetailBtn.center = CGPointMake(_showDetailBtn.center.x,_titleLab.center.y);
        [_showDetailBtn setImage:[UIImage imageNamed:Image(@"question")] forState:UIControlStateNormal];
        [_showDetailBtn addTarget:self action:@selector(showDetailAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_showDetailBtn];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(20, 52, SIZE.width-20, 1)];
        lineView.backgroundColor = Color_F1F1F1;
        [self addSubview:lineView];
        
    }
    
    return self;
}

-(void)showDetailAction:(UIButton *)btn{
    if (_showDeailBlock) {
        _showDeailBlock();
    }
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
    _showDetailBtn.hidden = [[dic objectForKey:@"arrowState"] boolValue];
    
}

@end
