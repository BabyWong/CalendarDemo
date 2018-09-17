//
//  WMCalendarView.h
//  BeeEnrichmentAppiOS
//
//  Created by hwm on 2018/5/30.
//  Copyright © 2018年 HangZhouShangFu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WMCalendarCell;


typedef NS_ENUM(NSInteger, WMCalendarDay) {
    WMCalendarDayPre = -1,
    WMCalendarDayToday, // 今日
    WMCalendarDayLater
    // 10000 是nil
};

@interface WMCalendarView : UIView

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSDate *today;
@property (nonatomic, strong) WMCalendarCell *lastCell;
@property (nonatomic, assign) WMCalendarDay LastDayType;
@property (nonatomic, strong) NSString *chooseDateStr;
/**/
@property (nonatomic, copy) void(^WMCalendarVBlock)(WMCalendarDay calendarDayType, BOOL isMarkDay,  BOOL isChoose, NSString *chooseDateStr, NSInteger year, NSInteger month, NSInteger day);
@property (nonatomic, strong) NSArray *allBackDateArray;// 所有回款时间

- (NSDate *)nextMonth:(NSDate *)date;
- (NSDate *)lastMonth:(NSDate *)date;
- (NSInteger)year:(NSDate *)date;
- (NSInteger)month:(NSDate *)date;
- (NSInteger)day:(NSDate *)date;

- (WMCalendarDay)isInMonthDayWithRow:(NSInteger)row;
- (void)chooseDayWithDate:(NSDate *)date;

@end
