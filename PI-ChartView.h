//
//  PI-ChartView.h
//  ResolutionTweet
//
//  Created by Jayaprada Behera on 20/03/13.
//  Copyright (c) 2013 WebileApps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PI_ChartView : UIView{
    UILabel *activeLabel;
    UILabel*nonActivelabel;
    UILabel *accomplishedLabel;
}

@property(nonatomic,strong)NSArray *valueArray;
@property(nonatomic,strong)  UILabel *activeLabel;
@property(nonatomic,strong) UILabel*nonActivelabel;
@property(nonatomic,strong) UILabel *accomplishedLabel;

@end
