//
//  WMCalendarAllView.h
//  BeeEnrichmentAppiOS
//
//  Created by hwm on 2018/6/6.
//  Copyright © 2018年 HangZhouShangFu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WMCalendarAllViewBlock)(NSString *dateString);
@interface WMCalendarAllView : UIView

@property (nonatomic, strong) NSMutableArray *allDateArray;
- (void)show;

@property (nonatomic, copy) WMCalendarAllViewBlock calendarAllViewBlock;

@end
