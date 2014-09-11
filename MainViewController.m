//
//  MainViewController.m
//  Objective-C Example
//
//  Created by Ananya Saxena on 9/4/14.
//  Copyright (c) 2014 Ananya Saxena. All rights reserved.
//

#import "MainViewController.h"
#import "SettingsViewController.h"


@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipController;
@property NSUserDefaults* defaultsStore;
@property NSArray *tipArray;

-(IBAction)HideKeyboard:(id)sender;
-(void)updateValues;
- (void)onSettingsButton;
@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title  = @"Tip Calculator";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateValues];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];

    
    self.defaultsStore = [NSUserDefaults standardUserDefaults];
    
    self.tipController.selectedSegmentIndex = 0 ;
    [self updateTipPercentages];
    // Do any additional setup after loading the view from its nib.
}


- (void) updateTipPercentages
{
    int selectedIndex = self.tipController.selectedSegmentIndex;
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
    self.tipArray = [[NSArray alloc] init];
    
    self.tipArray = @[[NSNumber numberWithLong:tip1Val],
                      [NSNumber numberWithLong:tip2Val],
                      [NSNumber numberWithLong:tip3Val]];
    
    [self setTipControllerSegments:@[
                                     [NSString stringWithFormat:@"$%ld%%", tip1Val],
                                     [NSString stringWithFormat:@"$%ld%%", tip2Val],
                                     [NSString stringWithFormat:@"$%ld%%", tip3Val]
                                     ]];
    
    self.tipController.selectedSegmentIndex = selectedIndex;

}

- (void)setTipControllerSegments:(NSArray *)segments
{
    while(self.tipController.numberOfSegments > 0)
    {
        [self.tipController removeSegmentAtIndex:0 animated:NO];
    }
    
    for (NSString *segment in segments)
    {
        [self.tipController insertSegmentWithTitle:segment atIndex:self.tipController.numberOfSegments  animated:NO];
    }
}

- (IBAction)HideKeyboard:(id)sender {
    [self.view endEditing:YES];
    [self updateValues];
}

- (void) updateValues {
    float billAmount = [self.billTextField.text floatValue];
    
    
    
    float tipAmount = billAmount * [self.tipArray[self.tipController.selectedSegmentIndex] floatValue] * 0.01;
    float totalAmount = billAmount + tipAmount;
    
    self.tipLabel.text = [NSString stringWithFormat:@"$%0.2f", tipAmount];
    self.totalLabel.text = [NSString stringWithFormat:@"$%0.2f", totalAmount];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onSettingsButton {
    [self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [self updateTipPercentages];
    [self updateValues];
}

@end
