//
//  NoDataPointView.h
//  JuCaiEmployee
//
//  Created by LiuXiaoMin on 16/3/20.
//  Copyright © 2016年 HangZhouShangFu. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef void(^clickButtonBlock)(void);



@interface NoDataPointView : UIView
@property (strong, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutlet UIButton *clickButton;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleTopContraints;

- (void)set_title:(NSString *)title detailTitle:(NSString *)detailTitle buttonTitle:(NSString *)buttonTitle isShowButton:(BOOL)isShowButton imageName:(NSString *)imageName;
@property (nonatomic, copy)clickButtonBlock clickButtonBlock;
@end
