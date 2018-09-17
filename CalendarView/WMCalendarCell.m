//
//  WMCalendarCell.m
//  BeeEnrichmentAppiOS
//
//  Created by hwm on 2018/5/30.
//  Copyright © 2018年 HangZhouShangFu. All rights reserved.
//

#import "WMCalendarCell.h"

#define dateLableWH    34
#define markLableWH    6

@interface WMCalendarCell ()

@end

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@implementation WMCalendarCell

- (UILabel *)dataLable {
    if (!_dataLable) {
        _dataLable = [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth / 7 - dateLableWH) / 2, 0, dateLableWH, dateLableWH)];
        _dataLable.layer.borderWidth = 1;
        _dataLable.layer.cornerRadius = dateLableWH / 2;
        _dataLable.layer.masksToBounds = YES;
        _dataLable.font = [UIFont systemFontOfSize:15];
        _dataLable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_dataLable];
    }
    return _dataLable;
}

- (UILabel *)markLable {
    if (!_markLable) {
        _markLable = [[UILabel alloc] initWithFrame:CGRectMake(0,  0, markLableWH, markLableWH)];
        _markLable.center = CGPointMake(_dataLable.center.x, dateLableWH - 4);
        _markLable.layer.cornerRadius = markLableWH / 2;
        _markLable.backgroundColor = [UIColor redColor];
        _markLable.layer.masksToBounds = YES;
        [self addSubview:_markLable];
    }
    return _markLable;
}

- (void)setDataUIDic:(NSDictionary *)dataUIDic {
    _dataUIDic = dataUIDic;
//    NSInteger section = dataUIDic[@"type"];
//    if (section == 0) {
//
//    }else {
//
//    }
    
}

@end
