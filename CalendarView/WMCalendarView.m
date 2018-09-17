//
//  WMCalendarView.m
//  BeeEnrichmentAppiOS
//
//  Created by hwm on 2018/5/30.
//  Copyright © 2018年 HangZhouShangFu. All rights reserved.
//

#import "WMCalendarView.h"
#import "WMCalendarCell.h"

@interface WMCalendarView() <UICollectionViewDelegate , UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionV;
@property (nonatomic, strong) NSArray *weekDaysArray;

@end

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

NSString *const WMCalendarCellIdentifier = @"WMCalendarCell";

@implementation WMCalendarView


- (void)awakeFromNib {
    [super awakeFromNib];
    [self setInfo];
    [self addSwipe];
    
}

- (void)setInfo {
    _weekDaysArray = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    _allBackDateArray = [NSArray array];
    self.collectionV.showsHorizontalScrollIndicator = NO;
}

- (void)setDate:(NSDate *)date {
    _date = date;
    [self.collectionV reloadData];
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

- (UICollectionView *)collectionV {
    if (!_collectionV) {
        CGFloat itemWidth = kScreenWidth / 7;
        CGFloat itemHeight = self.frame.size.height / 7;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        layout.itemSize = CGSizeMake(itemWidth, itemHeight);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        _collectionV = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionV.frame = self.bounds;
        _collectionV.delegate = self;
        _collectionV.dataSource = self;
        _collectionV.backgroundColor = [UIColor whiteColor];
        [_collectionV registerClass:[WMCalendarCell class] forCellWithReuseIdentifier:WMCalendarCellIdentifier];
        [self addSubview:_collectionV];
        
    }
    return _collectionV;
}

- (void)chooseDayWithDate:(NSDate *)date {
    
    NSIndexPath *indexP;
    
    [self chooseDayWithIndext:indexP];
}

- (void)nextAction:(UIButton *)button {
    [UIView transitionWithView:self duration:0.4 options:UIViewAnimationOptionTransitionCurlUp animations:^(void) {
        self.date = [self nextMonth:self.date];
    } completion:nil];
}

- (void)lastAction:(UIButton *)button {
    [UIView transitionWithView:self duration:0.4 options:UIViewAnimationOptionTransitionCurlDown animations:^(void) {
        self.date = [self lastMonth:self.date];
    } completion:nil];
}

- (void)addSwipe
{
    UISwipeGestureRecognizer *swipLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(nextAction:)];
    swipLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self addGestureRecognizer:swipLeft];
    
    UISwipeGestureRecognizer *swipRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(lastAction:)];
    swipRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self addGestureRecognizer:swipRight];
}


// 日
- (NSInteger)day:(NSDate *)date {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components day];
}

// 月
- (NSInteger)month:(NSDate *)date {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components month];
}

// 年
- (NSInteger)year:(NSDate *)date {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components year];
}

- (WMCalendarDay)isInMonthDayWithRow:(NSInteger)row {// row == 100
    WMCalendarDay dayType;
    NSInteger firstWeekday = [self firstWeekdayInThisMonth:_date];
    NSInteger day = 0;
    if (row == 100) {
        day = 1;
    }else {
       day = row - firstWeekday + 1;
    }
    
    NSInteger yearCurrent = [self year:_date];
    NSInteger monthCurrent = [self month:_date];
    NSInteger todayYear = [self year:_today];
    NSInteger todayMonth = [self month:_today];
    NSInteger todayDay = [self day:_today];
    
    if (todayYear == yearCurrent && todayMonth == monthCurrent && todayDay == day) {// 当年当月当天
//        if (day == [self day:_date]) {
            dayType = WMCalendarDayToday;
//        } else if (day > [self day:_date]) {
//            dayType = WMCalendarDayLater;
//        } else {
//            dayType = WMCalendarDayPre;
//        }
    } else if (( todayYear == yearCurrent && todayMonth < monthCurrent ) || ( todayYear == yearCurrent &&  todayMonth == monthCurrent && todayDay < day) || todayYear < yearCurrent) {
        dayType = WMCalendarDayLater;
    }else  {
        dayType = WMCalendarDayPre;
    }
    return dayType;
}

- (void)setAllBackDateArray:(NSArray *)allBackDateArray {
    _allBackDateArray = allBackDateArray;
    [_collectionV reloadData];
}

// 当月1日是星期几
- (NSInteger)firstWeekdayInThisMonth:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:1];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    return firstWeekday - 1;
}

// 当月有几天
- (NSInteger)totaldaysInMonth:(NSDate *)date{
    NSRange daysInLastMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return daysInLastMonth.length;
}

- (NSDate *)nextMonth:(NSDate *)date {
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = +1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    WMCalendarDay dayType = [self isInMonthDayWithRow:100];
    if (self.WMCalendarVBlock) {
        self.WMCalendarVBlock(dayType, nil, NO, _chooseDateStr, [self year:newDate], [self month:newDate], [self day:newDate]);
    }
    return newDate;
}

- (NSDate *)lastMonth:(NSDate *)date {
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = -1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    WMCalendarDay dayType = [self isInMonthDayWithRow:100];
    if (self.WMCalendarVBlock) {
        self.WMCalendarVBlock(dayType, nil, NO, _chooseDateStr, [self year:newDate], [self month:newDate], [self day:newDate]);
    }
    return newDate;
}

- (void)chooseDayWithIndext:(NSIndexPath *)indexPath {
    if (_lastCell) {
        if (_LastDayType == WMCalendarDayToday) {
            _lastCell.dataLable.layer.borderColor = _lastCell.dataLable.textColor.CGColor;
        }else {
            _lastCell.dataLable.layer.borderColor = [UIColor clearColor].CGColor;
        }
        _chooseDateStr = nil;
    }
    WMCalendarDay dayType = [self isInMonthDayWithRow:indexPath.row];
    WMCalendarCell *cell = (WMCalendarCell *)[_collectionV cellForItemAtIndexPath:indexPath];
    cell.tag = indexPath.row;
    _lastCell = cell;
    _LastDayType = dayType;
    _lastCell.dataLable.layer.borderColor = [UIColor redColor].CGColor;
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self.date];
    NSInteger firstWeekday = [self firstWeekdayInThisMonth:_date];
    NSInteger day = indexPath.row - firstWeekday + 1;
    BOOL isMarkDay = !cell.markLable.hidden;// 1是回款日
    NSInteger chooseYear = [components year];
    NSInteger chooseMonth = [components month];
    if (!cell.markLable.hidden) {
        _chooseDateStr = [NSString stringWithFormat:@"%zd%02zd%02zd",chooseYear,chooseMonth,day];
    }else {
        _chooseDateStr = nil;
    }
    if (self.WMCalendarVBlock) {
        self.WMCalendarVBlock(dayType, isMarkDay, YES, _chooseDateStr, chooseYear, chooseMonth, day);
    }
}


#pragma mark delegate collection
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 7;
    }else {
        return 42;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WMCalendarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:WMCalendarCellIdentifier forIndexPath:indexPath];
    
    NSInteger row = indexPath.row;
    cell.dataLable.textColor = [UIColor grayColor];
    cell.dataLable.layer.borderColor = [UIColor clearColor].CGColor;
    cell.markLable.hidden = YES;
    if (indexPath.section == 0) {
        cell.dataLable.text = _weekDaysArray[row];
        cell.dataLable.layer.borderColor = [UIColor clearColor].CGColor;
    }else {
        cell.tag = indexPath.row;
        NSInteger daysInThisMonth = [self totaldaysInMonth:_date];
        NSInteger firstWeekday = [self firstWeekdayInThisMonth:_date];
        NSInteger row = indexPath.row;
        if (row < firstWeekday) {
            [cell.dataLable setText:@""];
        }else if (row > firstWeekday + daysInThisMonth - 1){
            [cell.dataLable setText:@""];
        }else {
            NSInteger day = row - firstWeekday + 1;
            NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
            [fmt setDateFormat:@"yyyyMMdd"];
            cell.dataLable.text = [NSString stringWithFormat:@"%li",(long)day];
            WMCalendarDay dayType = [self isInMonthDayWithRow:row];
            
            if (dayType == WMCalendarDayToday) {
                [cell.dataLable setTextColor:[UIColor grayColor]];
                cell.dataLable.layer.borderColor = cell.dataLable.textColor.CGColor;
                cell.dataLable.text = @"今日";
            }
            for (NSString *dateItem in _allBackDateArray) {// 当前时间有回款
                NSString *dateStr01 = [self turnToDateStr:dateItem dateFormat:fmt];
                NSDate *date01 = [fmt dateFromString:dateStr01];
                NSInteger dateYear =  [self year:date01];
                NSInteger dateMonth =  [self month:date01];
                NSInteger dateDay = [self day:date01];
                NSInteger currentYear =  [self year:_date];
                NSInteger currentMonth =  [self month:_date];
                if (dateYear == currentYear && dateMonth == currentMonth && dateDay == day) {
                    cell.markLable.hidden = NO;
                    if ([_chooseDateStr isEqualToString:dateStr01]) {
                        cell.dataLable.layer.borderColor = [UIColor redColor].CGColor;
                        _lastCell = cell;
                    }
                }
            }
        }
    }
    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {// 有时间的日历允许点击
        NSInteger daysInThisMonth = [self totaldaysInMonth:_date];
        NSInteger firstWeekday = [self firstWeekdayInThisMonth:_date];
        NSInteger day = 0;
        NSInteger i = indexPath.row;
        if (i >= firstWeekday && i <= firstWeekday + daysInThisMonth - 1) {
            day = i - firstWeekday + 1;
            return YES;
        }
    }
    return NO;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self chooseDayWithIndext:indexPath];
}

@end
