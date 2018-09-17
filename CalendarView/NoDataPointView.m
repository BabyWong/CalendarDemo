//
//  NoDataPointView.m
//  JuCaiEmployee
//
//  Created by LiuXiaoMin on 16/3/20.
//  Copyright © 2016年 HangZhouShangFu. All rights reserved.
//

#import "NoDataPointView.h"

@interface NoDataPointView ()

@property (strong, nonatomic) IBOutlet UIImageView *noDataImageView;
@property (strong, nonatomic) IBOutlet UILabel *detailLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topContraints;

@end



@implementation NoDataPointView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib
{    [super awakeFromNib];

    _clickButton.layer.borderColor = [UIColor grayColor].CGColor;
//    _topContraints.constant = (kScreenHeight - 64 - 59) *59 / 559;
}

- (void)set_title:(NSString *)title detailTitle:(NSString *)detailTitle buttonTitle:(NSString *)buttonTitle isShowButton:(BOOL)isShowButton imageName:(NSString *)imageName
{
    _label.text = title;
    _detailLabel.text = detailTitle;
    if (imageName.length > 0) {
       _noDataImageView.image = [UIImage imageNamed:imageName];
        _noDataImageView.hidden = NO;
        _titleTopContraints.constant = CGRectGetMaxY(_noDataImageView.frame) - _noDataImageView.frame.size.height - 30 ;
    }else {
        _titleTopContraints.constant = -CGRectGetMaxY(_noDataImageView.frame) + 30;
        _noDataImageView.hidden = YES;
    }
    
    if (buttonTitle.length > 0) {
        _clickButton.hidden = NO;
        _lineView.hidden = NO;
        [_clickButton setTitle:buttonTitle forState:UIControlStateNormal];
    }else
    {
        _clickButton.hidden = YES;
        _lineView.hidden = YES;
    }
}



- (IBAction)clickButtonAction:(id)sender {
    if (self.clickButtonBlock) {
        self.clickButtonBlock();
    }
}
@end
