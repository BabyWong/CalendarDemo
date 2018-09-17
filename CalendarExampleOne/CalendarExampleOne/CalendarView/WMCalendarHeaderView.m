//
//  WMCalendarHeaderView.m
//  BeeEnrichmentAppiOS
//
//  Created by hwm on 2018/5/28.
//  Copyright © 2018年 HangZhouShangFu. All rights reserved.
//

#import "WMCalendarHeaderView.h"
//#import "SKConstant.h"
#import "WMCalendarView.h"
#import "WMCalenderVPicker.h"

@interface WMCalendarHeaderView()

//@property (weak, nonatomic) IBOutlet SKCalendarView *calendarView;
@property (weak, nonatomic) IBOutlet UIButton *lastMonthBtn;// 上个月
@property (weak, nonatomic) IBOutlet UIButton *nextMonthBtn;// 下个月
@property (nonatomic, strong) WMCalenderVPicker *calendarPickerV;

@end

@implementation WMCalendarHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setCalendarView];
    [_yearBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 45, 0, 0)];
}

- (void)setCalendarView {
    _calendarView.today = [NSDate date];
    _calendarView.date = _calendarView.today;
    _monthLable.text = [NSString stringWithFormat:@"%02ld月",(long)[_calendarView month:_calendarView.date]];
    [_yearBtn setTitle:[NSString stringWithFormat:@"%zd     ",(long)[_calendarView year:_calendarView.date]] forState:UIControlStateNormal];
}

- (void)chooseDate {
    
}

- (IBAction)chooseYearBtn:(id)sender {
    
    __weak typeof(self) weakSelf = self;
    _calendarPickerV = [[NSBundle mainBundle] loadNibNamed:@"WMCalenderVPicker" owner:self options:nil].lastObject;
    _calendarPickerV.frame = [UIScreen mainScreen].bounds;
    _calendarPickerV.firstYear = [[_yearBtn.titleLabel.text substringWithRange:NSMakeRange(0, 4)] integerValue];
    _calendarPickerV.firstMonth = [[_monthLable.text substringWithRange:NSMakeRange(0, 2)] integerValue];
    _calendarPickerV.calenderVPickerBlock = ^(NSString *date) {
        if (weakSelf.calendarHeaderViewBlock) {
            weakSelf.calendarHeaderViewBlock();
        }
//        NSString *year = [date substringWithRange:NSMakeRange(0, 4)];
//        NSString *month = [date substringWithRange:NSMakeRange(4, 2)];
        [weakSelf.yearBtn setTitle:[NSString stringWithFormat:@"%@     ",[date substringWithRange:NSMakeRange(0, 4)]] forState:UIControlStateNormal];
        weakSelf.monthLable.text = [NSString stringWithFormat:@"%@月",[date substringWithRange:NSMakeRange(4, 2)]];
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        format.dateFormat = @"yyyyMMdd";
        NSDate *data = [format dateFromString:date];
        NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
        dateComponents.month = -1;
        NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:data options:0];
        weakSelf.calendarView.date = [weakSelf.calendarView nextMonth:newDate];
//        weakSelf.calendarView.date = data;
//        weakSelf.calendarView.WMCalendarVBlock([weakSelf.calendarView isInMonthDayWithRow:100], 0, [year integerValue], [month integerValue], 01);
    };
    [_calendarPickerV show];
}

- (IBAction)nextMonthBtn:(id)sender {
    [UIView transitionWithView:self duration:0.4 options:UIViewAnimationOptionTransitionCurlUp animations:^(void) {
        self->_calendarView.date = [_calendarView nextMonth:_calendarView.date];
        self->_monthLable.text = [NSString stringWithFormat:@"%02ld月",(long)[_calendarView month:_calendarView.date]];
        [self->_yearBtn setTitle:[NSString stringWithFormat:@"%zd     ",(long)[_calendarView year:_calendarView.date]] forState:UIControlStateNormal];
    } completion:nil];
    if (self.calendarHeaderViewBlock) {
        self.calendarHeaderViewBlock();
    }
}

- (IBAction)lastMonthBtn:(id)sender {
    [UIView transitionWithView:self duration:0.4 options:UIViewAnimationOptionTransitionCurlDown animations:^(void) {
        self->_calendarView.date = [_calendarView lastMonth:_calendarView.date];
        self->_monthLable.text = [NSString stringWithFormat:@"%02ld月",(long)[_calendarView month:_calendarView.date]];
        [self->_yearBtn setTitle:[NSString stringWithFormat:@"%zd     ",(long)[_calendarView year:_calendarView.date]] forState:UIControlStateNormal];
    } completion:nil];
    if (self.calendarHeaderViewBlock) {
        self.calendarHeaderViewBlock();
    }
}

@end
