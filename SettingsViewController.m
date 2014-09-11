//
//  SettingsViewController.m
//  Objective-C Example
//
//  Created by Ananya Saxena on 9/10/14.
//  Copyright (c) 2014 Ananya Saxena. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *defaultTip1;
@property (weak, nonatomic) IBOutlet UILabel *defaultTip2;
@property (weak, nonatomic) IBOutlet UILabel *defaultTip3;
@property (weak, nonatomic) IBOutlet UIStepper *tip1Controller;
@property (weak, nonatomic) IBOutlet UIStepper *tip2Controller;
@property (weak, nonatomic) IBOutlet UIStepper *tip3Controller;

@property  NSUserDefaults *defaultsStore;

@end

@implementation SettingsViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.defaultsStore = [NSUserDefaults standardUserDefaults];
    
    
    NSInteger tip1Val = [self.defaultsStore integerForKey:@"tip1Val" ];
    if(!tip1Val){
        tip1Val = 15;
    }
    
    NSInteger tip2Val = [self.defaultsStore integerForKey:@"tip2Val" ];
    if(!tip2Val){
        tip2Val = 25;
    }
    
    NSInteger tip3Val = [self.defaultsStore integerForKey:@"tip3Val" ];
    if(!tip3Val){
        tip3Val = 35;
    }
    
    self.defaultTip1.text = [NSString stringWithFormat:@"$%2ld%%", (long)tip1Val];
    self.tip1Controller.value = tip1Val;
    self.defaultTip2.text = [NSString stringWithFormat:@"$%2ld%%", (long)tip2Val];
    self.tip2Controller.value = tip2Val;
    self.defaultTip3.text = [NSString stringWithFormat:@"$%2ld%%", (long)tip3Val];
    self.tip3Controller.value = tip3Val;

    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView
{
    return 1;
}


- (IBAction)tip1Changed:(id)sender {
    self.defaultTip1.text = [NSString stringWithFormat:@"$%.0f%%", self.tip1Controller.value];
    
    [self.defaultsStore setInteger:self.tip1Controller.value forKey:@"tip1Val"];
}

- (IBAction)tip2Changed:(id)sender {
    self.defaultTip2.text = [NSString stringWithFormat:@"$%.0f%%", self.tip2Controller.value];
    [self.defaultsStore setInteger:self.tip2Controller.value forKey:@"tip2Val"];
}

- (IBAction)tip3Changed:(id)sender {
    self.defaultTip3.text = [NSString stringWithFormat:@"$%.0f%%", self.tip3Controller.value];
    [self.defaultsStore setInteger:self.tip3Controller.value forKey:@"tip3Val"];
}

@end
