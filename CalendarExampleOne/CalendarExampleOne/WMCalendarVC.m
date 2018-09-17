//
//  WMCalendarVC.m
//  BeeEnrichmentAppiOS
//
//  Created by hwm on 2018/5/28.
//  Copyright © 2018年 HangZhouShangFu. All rights reserved.
//

#import "WMCalendarVC.h"
#import "WMCalendarHeaderView.h"
#import "WMCalendarAllView.h"
#import "NoDataPointView.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kSectionHeaderHeight 10
#define kSectionFooterHeight 0.000001
#define kTableViewRowHeight 44

@interface WMCalendarVC () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableViewCalendar;
//@property (nonatomic, strong) ProductsModel *productList;
@property (nonatomic, strong) WMCalendarHeaderView *calendarHeaderV;
@property (nonatomic, strong) NSMutableArray *allBackDateArray;
//@property (nonatomic, strong) NSMutableArray<BeePlanModel *> *subjectList;
@property (nonatomic, strong) NoDataPointView *noDataView;
@property (nonatomic, strong) NSString *chooseDateStr;
@property (nonatomic, assign) WMCalendarDay chooseDateType;

@end

@implementation WMCalendarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableV];
    [self creatNoDataview];
    [self setHeaderView];
    self.title = @"回款日历";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"回款月份" style:UIBarButtonItemStylePlain target:self action:@selector(returnMonth)];
    if (_chooseDateStr) {
        [self lastChooseDate];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}


- (void)setChooseDateNull {
    _chooseDateType = 10000;
    _chooseDateStr = nil;
    _calendarHeaderV.calendarView.lastCell = nil;
    _calendarHeaderV.calendarView.LastDayType = 10000;
    _calendarHeaderV.calendarView.chooseDateStr = nil;
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

#pragma mark 回款月份
- (void)returnMonth {
    WMCalendarAllView *allView = [[NSBundle mainBundle] loadNibNamed:@"WMCalendarAllView" owner:self options:nil].firstObject;
    allView.allDateArray = _allBackDateArray;
    
    __weak typeof(self) weakSelf = self;
    allView.calendarAllViewBlock = ^(NSString *dateString) {
        [self setChooseDateNull];
        NSDateFormatter *form = [[NSDateFormatter alloc] init];
        form.dateFormat = @"yyyMMdd";
        NSString *dateStr = [self turnToDateStr:dateString dateFormat:form];
        NSTimeInterval second = dateString.longLongValue / 1000.0;
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:second];
       weakSelf.calendarHeaderV.calendarView.date = date;
        self->_calendarHeaderV.monthLable.text = [NSString stringWithFormat:@"%02ld月",(long)[[dateStr substringWithRange:NSMakeRange(4, 2)] integerValue]];
        [self->_calendarHeaderV.yearBtn setTitle:[NSString stringWithFormat:@"%ld     ",(long)[[dateStr substringWithRange:NSMakeRange(0, 4)] integerValue]] forState:UIControlStateNormal];
        [self setTableFooterView:0];
    };
    [allView show];
}

#pragma mark 选择日期
- (void)lastChooseDate {
    
    NSDateFormatter *form = [[NSDateFormatter alloc] init];
    form.dateFormat = @"yyyyMMdd";
    NSDate *date = [form dateFromString:_chooseDateStr];
    self.calendarHeaderV.calendarView.date = date;
    NSInteger yearCurrent = [[_chooseDateStr substringWithRange:NSMakeRange(0, 4)] integerValue];
    NSInteger monthCurrent = [[_chooseDateStr substringWithRange:NSMakeRange(4, 2)] integerValue];
    NSInteger dayCurrent = [[_chooseDateStr substringWithRange:NSMakeRange(6, 2)] integerValue];
    NSInteger todayYear = [self.calendarHeaderV.calendarView year:[NSDate date]];
    NSInteger todayMonth = [self.calendarHeaderV.calendarView month:[NSDate date]];
    NSInteger todayDay = [self.calendarHeaderV.calendarView day:[NSDate date]];
    WMCalendarDay dayType = 0;
    if (todayYear == yearCurrent && todayMonth == monthCurrent && todayDay == dayCurrent) {// 当年当月当天
        dayType = WMCalendarDayToday;
    } else if (( todayYear == yearCurrent && todayMonth < monthCurrent ) || ( todayYear == yearCurrent &&  todayMonth == monthCurrent && todayDay < dayCurrent) || todayYear < yearCurrent) {
        dayType = WMCalendarDayLater;
    }else  {
        dayType = WMCalendarDayPre;
    }
    _chooseDateType = dayType;
//    [self loadCurrentBackDate];
    _calendarHeaderV.monthLable.text = [NSString stringWithFormat:@"%02ld月",(long)monthCurrent];
    [_calendarHeaderV.yearBtn setTitle:[NSString stringWithFormat:@"%ld     ",(long)yearCurrent] forState:UIControlStateNormal];
}

- (void)setTableFooterView:(bool)isType {// 0选择日期 1
    
    if (isType) {
        [_noDataView set_title:@"当日没有回款哦" detailTitle:@"" buttonTitle:@"" isShowButton:NO imageName:@"kubee"];
    }else {
        _noDataView.titleTopContraints.constant = - kScreenHeight / 3;
        [_noDataView set_title:@"请选择日期" detailTitle:@"" buttonTitle:@"" isShowButton:NO imageName:@""];
    }
    [_tableViewCalendar reloadData];
}



- (void)initTableV {
    _tableViewCalendar = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableViewCalendar.delegate = self;
    _tableViewCalendar.dataSource = self;
    _tableViewCalendar.backgroundColor = [UIColor grayColor];
    _tableViewCalendar.separatorColor = [UIColor clearColor];
    _tableViewCalendar.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _tableViewCalendar.contentInset = UIEdgeInsetsMake(0, 0, 79, 0);
    _tableViewCalendar.rowHeight = 172;
    _tableViewCalendar.sectionHeaderHeight = kSectionFooterHeight;
    _tableViewCalendar.sectionFooterHeight = 0.5;
    [self.view addSubview:_tableViewCalendar];
}

- (void)setHeaderView {
    _calendarHeaderV = [[NSBundle mainBundle] loadNibNamed:@"WMCalendarHeaderView" owner:self options:nil].firstObject;
    _calendarHeaderV.frame = CGRectMake(0, 0, kScreenWidth, 344.0 / 667.0 * kScreenHeight);
    __weak typeof(self) weakSelf = self;
    _calendarHeaderV.calendarHeaderViewBlock = ^{
        [weakSelf setChooseDateNull];
    };
    _calendarHeaderV.calendarView.WMCalendarVBlock = ^(WMCalendarDay calendarDayType, BOOL isMarkDay, BOOL isChoose,NSString *chooseDateStr, NSInteger year, NSInteger month, NSInteger day) {
        NSLog(@"\n点击了:%zd年%zd月%zd日\n",year,month, day);
        weakSelf.chooseDateStr = chooseDateStr;
        weakSelf.chooseDateType = calendarDayType;
        if (isMarkDay) {
        }else {
            [weakSelf setTableFooterView:isChoose];
        }
        weakSelf.calendarHeaderV.monthLable.text = [NSString stringWithFormat:@"%02ld月",(long)month];
        [weakSelf.calendarHeaderV.yearBtn setTitle:[NSString stringWithFormat:@"%ld     ",(long)year] forState:UIControlStateNormal];
    };
    weakSelf.tableViewCalendar.tableHeaderView = _calendarHeaderV;
}

-(void)creatNoDataview {// 没有数据

    _noDataView = [[NSBundle mainBundle] loadNibNamed:@"NoDataPointView" owner:nil options:nil].firstObject;
    _noDataView.frame = CGRectMake(0, 0, kScreenWidth, 172);
    [_noDataView set_title:@"请选择日期" detailTitle:@"" buttonTitle:@"" isShowButton:NO imageName:@""];
    _noDataView.clickButtonBlock = ^(){
        
    };
}


#pragma mark tableView datacesource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


#pragma mark tableView delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"nodateCell"];
    [cell.contentView addSubview:_noDataView];
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)dealloc {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"WMCalendarAllDateV"];
}

@end
