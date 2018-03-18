//
//  TitleWithItemCell.h
//  37duxinB
//
//  Created by 37duxin on 07/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleWithItemCell : UITableViewCell<UITextFieldDelegate>
typedef void (^textFieldBlock)(UITextField *textField);
@property(nonatomic,retain)UILabel *titleLab;
@property(nonatomic,retain)UIImageView *requiredImagView;
@property(nonatomic,retain)UITextField *textFild;
@property(nonatomic,retain)UILabel *itemLabel;
@property(nonatomic,copy)textFieldBlock textFieldBlock;
-(void)updateUI:(NSDictionary *)dic;
@end
