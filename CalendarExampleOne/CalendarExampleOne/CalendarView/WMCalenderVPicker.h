//
//  WMCalenderVPicker.h
//  BeeEnrichmentAppiOS
//
//  Created by hwm on 2018/5/31.
//  Copyright © 2018年 HangZhouShangFu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WMCalenderVPickerBlock)(NSString *date);
@interface WMCalenderVPicker : UIView

- (void)show;

@property (nonatomic, copy) WMCalenderVPickerBlock calenderVPickerBlock;
@property (nonatomic, assign) NSInteger firstYear;
@property (nonatomic, assign) NSInteger firstMonth;

@end
