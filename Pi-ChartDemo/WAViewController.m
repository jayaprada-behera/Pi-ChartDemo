//
//  WAViewController.m
//  Pi-ChartDemo
//
//  Created by Jayaprada Behera on 18/02/14.
//  Copyright (c) 2014 Webileapps. All rights reserved.
//

#import "WAViewController.h"

@interface WAViewController ()
{
    PI_ChartView *piChart;
}
@end

@implementation WAViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    piChart = [[PI_ChartView alloc]initWithFrame:CGRectMake(120, 120, 120, 120)];
    piChart.valueArray = [[NSArray alloc] initWithObjects:@"20",@"30",@"50", nil];
    [self.view addSubview:piChart];
    piChart.backgroundColor = [UIColor clearColor];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
