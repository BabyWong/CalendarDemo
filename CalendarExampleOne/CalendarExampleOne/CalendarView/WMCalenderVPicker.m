//
//  WMCalenderVPicker.m
//  BeeEnrichmentAppiOS
//
//  Created by hwm on 2018/5/31.
//  Copyright © 2018年 HangZhouShangFu. All rights reserved.
//

#import "WMCalenderVPicker.h"
#import "UIPickerView+WMPickerV.h"


@interface WMCalenderVPicker () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *popView;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (nonatomic, strong) NSArray *monthArray;
@property (nonatomic, strong) NSArray *yearArray;
/* 第一设置 */
@property (nonatomic, assign) BOOL isInitial;
@property (nonatomic, strong) NSString *chooseData;

@end


@implementation WMCalenderVPicker

- (void)awakeFromNib {
    [super awakeFromNib];
//    [self changeSpearatorLineColor];
    _popView.layer.cornerRadius = 5;
    _popView.layer.masksToBounds = YES;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self hidden];
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
    [self initialText];
}

- (void)hidden {
    [UIView animateWithDuration:0.3 animations:^{
        self.popView.transform = CGAffineTransformMakeScale(0.1, 0.1);
        self.popView.alpha = 0.1;
    } completion:^(BOOL finished) {
        [self.popView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

// 初始化文字的方法
- (void)initialText
{
    if (_isInitial == NO) {
        NSInteger year = 0;
        if (_firstYear) {
            year = _firstYear % 2000;
        }
        [self pickerView:_pickerView didSelectRow:year inComponent:0];
//        [self pickerView:_pickerView didSelectRow:_firstMonth inComponent:0];
        _isInitial = YES;
    }
}

- (IBAction)cancelButton:(id)sender {
    [self hidden];
}

- (IBAction)ensureButton:(id)sender {
    if (self.calenderVPickerBlock) {
        
        _calenderVPickerBlock(_chooseData);
    }
    [self hidden];
}

#pragma mark - UIPickerViewDataSource
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return 12;
    }else {
        return 100;
    }
}

#pragma mark UIPickerViewDelegate
// row title
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    [pickerView clearSpearatorLine];
    NSInteger month = 01;
    NSInteger year = 2000;
    if (component == 0) {
        month += row;
        return [NSString stringWithFormat:@"%02zd月",month];
    }else {
        year += row;
        return [NSString stringWithFormat:@"%zd年",year];
    }
}

// 返回 component  height
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 36.0;
}

// 选中某一行的时候调用 choose
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSMutableArray *array = [NSMutableArray array];
    for(NSUInteger k = 0; k < pickerView.numberOfComponents; k++)
    {
        NSUInteger selectedRow = [_pickerView selectedRowInComponent:k];
        NSString *title;
//        if (_isInitial==NO) {
//            if (k) {
//                title = [[_pickerView delegate] pickerView:_pickerView titleForRow:_firstYear % 2000 forComponent:k];
//            }else {
//                title = [[_pickerView delegate] pickerView:_pickerView titleForRow:_firstMonth forComponent:k];
//            }
//        }else {
            title = [[_pickerView delegate] pickerView:_pickerView titleForRow:selectedRow forComponent:k];
//        }
        [array addObject:title];
    }
    NSString *year = array[1];
    year = [year stringByReplacingOccurrencesOfString:@"年" withString:@""];
    NSString *month = array[0];
    month = [month stringByReplacingOccurrencesOfString:@"月" withString:@""];
    _chooseData = [NSString stringWithFormat:@"%@%@01",year,month];
//    DLog(@"%@",_chooseData);
//    DLog(@"%zd",row);
    
    
}

@end
