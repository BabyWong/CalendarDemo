//
//  WMCalendarAllView.m
//  BeeEnrichmentAppiOS
//
//  Created by hwm on 2018/6/6.
//  Copyright © 2018年 HangZhouShangFu. All rights reserved.
//

#import "WMCalendarAllView.h"
#import "WMCalendarAllDateCell.h"


@interface WMCalendarAllView() <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *popView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (nonatomic, strong) NSMutableArray *dateMonthArray;

@end

@implementation WMCalendarAllView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initTab];
    _popView.layer.cornerRadius = 6;
    _popView.layer.masksToBounds = YES;
    _dateMonthArray = [NSMutableArray array];
}

- (void)initTab {
    _tableView.rowHeight = 50;
    _tableView.separatorColor = [UIColor clearColor];
}

#pragma mark 时间戳转换-带参数dateFormat
- (NSString *)turnToDateStr:(NSString *)string dateFormat:(NSDateFormatter *)dateFormat
{
    NSDate *timeDate = [[NSDate alloc] initWithTimeIntervalSince1970:([string longLongValue])/1000.0];
    NSString *timeStr = [dateFormat stringFromDate:timeDate];
    if (string != nil) {
        return timeStr;
    } else {
        return @"空";
    }
}

- (void)setAllDateArray:(NSMutableArray *)allDateArray {
    _allDateArray = allDateArray;
    NSDateFormatter *forM = [[NSDateFormatter alloc] init];
    forM.dateFormat = @"yyyy年MM月";
    NSString *dateStr;
    NSMutableArray *arrayDate = [NSMutableArray array];
    NSInteger countCut = 0;
    for (NSInteger i = 0; i < allDateArray.count; i++) {
        dateStr = [self turnToDateStr:allDateArray[i] dateFormat:forM];
        if (i == 0) {
            [_dateMonthArray addObject:dateStr];
            [arrayDate addObject:allDateArray[i]];
            continue;
        }
        [arrayDate addObject:allDateArray[i]];
        [_dateMonthArray addObject:dateStr];
        NSInteger once = 0;
        for (NSInteger k = 0; k < _dateMonthArray.count; k++) {
            if ([_dateMonthArray[k] isEqualToString:dateStr]) {
                if (once == 0) {
                    once = 1;
                }else  {
                    [arrayDate removeObjectAtIndex:i-countCut];
                    countCut++;
                    [_dateMonthArray removeObjectAtIndex:k];
                }
            }
        }
    }
    _allDateArray = arrayDate;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self remove];
}

- (void)show {
    self.frame = [UIScreen mainScreen].bounds;
    self.popView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    self.popView.alpha = 0.01;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        self.popView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        self.popView.alpha = 1.0;
    }];
}

- (void)remove {
    [UIView animateWithDuration:0.3 animations:^{
        self.popView.transform = CGAffineTransformMakeScale(0.1, 0.1);
        self.popView.alpha = 0.1;
    } completion:^(BOOL finished) {
        [self.popView removeFromSuperview];
        [self removeFromSuperview];
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dateMonthArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WMCalendarAllDateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WMCalendarAllDateCell"];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"WMCalendarAllDateCell" owner:self options:nil].firstObject;
    }
    cell.dateLable.text = _dateMonthArray[indexPath.row];
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"WMCalendarAllDateV"];
    if (str) {
        NSDateFormatter *forM = [[NSDateFormatter alloc] init];
        forM.dateFormat = @"yyyy年MM月";
        str = [self turnToDateStr:str dateFormat:forM];
        if ([cell.dateLable.text isEqualToString: str]) {
            cell.chooseBtn.selected = YES;
        }else {
            cell.chooseBtn.selected = NO;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    WMCalendarAllDateCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.chooseBtn.selected = !cell.chooseBtn.selected;
    [[NSUserDefaults standardUserDefaults] setObject:_allDateArray[indexPath.row] forKey:@"WMCalendarAllDateV"];
    if (self.calendarAllViewBlock) {
        _calendarAllViewBlock(_allDateArray[indexPath.row]);
    }
    [self remove];
    
}

@end
