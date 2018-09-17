//
//  WMCalendarHeaderView.h
//  BeeEnrichmentAppiOS
//
//  Created by hwm on 2018/5/28.
//  Copyright © 2018年 HangZhouShangFu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WMCalendarView.h"

typedef void(^WMCalendarHeaderViewBlock)(void);
@interface WMCalendarHeaderView : UIView

@property (weak, nonatomic) IBOutlet UILabel *monthLable;
@property (weak, nonatomic) IBOutlet UIButton *yearBtn;// 年份选择
@property (weak, nonatomic) IBOutlet WMCalendarView *calendarView;

@property (nonatomic, copy) WMCalendarHeaderViewBlock calendarHeaderViewBlock;

@end
