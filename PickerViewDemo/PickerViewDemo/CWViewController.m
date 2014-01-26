//
//  CWViewController.m
//  PickerViewDemo
//
//  Created by wangchao on 14-1-26.
//  Copyright (c) 2014年 wangchao. All rights reserved.
//

#import "CWViewController.h"

@interface CWViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (nonatomic, strong) NSArray *provincesArray;
@property (nonatomic, strong) NSArray *citiesArray;

@end

@implementation CWViewController

#pragma App Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.citiesArray = self.provincesArray[0][@"cities"];
    [self.pickerView reloadAllComponents];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - GetMethods

- (NSArray *)provincesArray {
    if (!_provincesArray) {
        _provincesArray = [[NSMutableArray alloc] init];
        NSURL *provincesURL = [[NSBundle mainBundle] URLForResource:@"Provinces" withExtension:@"plist"];
        NSArray *provincesArray = [NSArray arrayWithContentsOfURL:provincesURL];
        _provincesArray = provincesArray;
    }
    return _provincesArray;
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (0 == component) {
        return self.provincesArray.count;
    } else {
        return self.citiesArray.count;
    }
}

#pragma mark - UIPickerViewDelegate

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 30;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if (0 == component) {
        return self.view.frame.size.width / 3.0;
    } else {
        return self.view.frame.size.width / 3.0 * 2;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (0 == component) {
        NSDictionary *item = self.provincesArray[row];
        return item[@"ProvinceName"];
    } else {
        NSDictionary *cityDict = self.citiesArray[row];
        return cityDict[@"CityName"];
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *label = (UILabel *)view;
    if (!label) {
        label = [[UILabel alloc] init];
        label.adjustsFontSizeToFitWidth = YES;
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont boldSystemFontOfSize:14];
    }
    label.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (0 == component) {
        self.citiesArray = self.provincesArray[row][@"cities"];
        [self.pickerView reloadAllComponents];
        [self.pickerView selectRow:0 inComponent:1 animated:YES];
    } else {
        
    }
}

@end
