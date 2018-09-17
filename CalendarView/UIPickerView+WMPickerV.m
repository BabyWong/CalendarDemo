//
//  UIPickerView+WMPickerV.m
//  BeeEnrichmentAppiOS
//
//  Created by hwm on 2018/5/31.
//  Copyright © 2018年 HangZhouShangFu. All rights reserved.
//

#import "UIPickerView+WMPickerV.h"

@implementation UIPickerView (WMPickerV)
- (void)clearSpearatorLine
{
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (obj.frame.size.height < 1)
        {
            [obj setBackgroundColor:[UIColor clearColor]];
        }
    }];
}

@end
