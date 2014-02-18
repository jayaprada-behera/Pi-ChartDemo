//
//  PI-ChartView.m
//  ResolutionTweet
//
//  Created by Jayaprada Behera on 20/03/13.
//  Copyright (c) 2013 WebileApps. All rights reserved.
//

#import "PI-ChartView.h"
#define RADIUS 50.f
#define OUTER_RADIUS 60.f

#define DEG_2_RAD(x) ((M_PI * x) / 180)

@implementation PI_ChartView
@synthesize activeLabel;
@synthesize nonActivelabel;
@synthesize accomplishedLabel;
@synthesize valueArray;

-(void)codeInitialization{
    activeLabel =[[UILabel alloc]initWithFrame:CGRectZero];
    [activeLabel setTextColor:[UIColor blackColor]];
    [activeLabel setFont:[UIFont boldSystemFontOfSize:12.f]];
    [activeLabel setBackgroundColor:[UIColor clearColor]];
    [self addSubview:activeLabel];
    
    nonActivelabel =[[UILabel alloc]initWithFrame:CGRectZero];
    [self addSubview:nonActivelabel];
    [nonActivelabel setBackgroundColor:[UIColor clearColor]];
    [nonActivelabel setFont:[UIFont boldSystemFontOfSize:12.f]];
    [nonActivelabel setTextColor:[UIColor blackColor]];
    
    accomplishedLabel =[[UILabel alloc]initWithFrame:CGRectZero];
    [accomplishedLabel setFont:[UIFont boldSystemFontOfSize:12.f]];
    [accomplishedLabel setTextColor:[UIColor blackColor]];
    [accomplishedLabel setBackgroundColor:[UIColor clearColor]];
    [self addSubview:accomplishedLabel];

}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self codeInitialization];
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        
        //If pichart view is created in XIB ,then call codeInitialization method here
//        [self codeInitialization];
        
    }
    return self;
}

- (void) layoutSubviews {
    
    [activeLabel sizeToFit];
    [nonActivelabel sizeToFit];
    [accomplishedLabel sizeToFit];
    
    if (self.valueArray.count > 0) {
        
        CGFloat value0 = [[self.valueArray objectAtIndex:0] floatValue];
        CGFloat value1  = [[self.valueArray objectAtIndex:1] floatValue];
        CGFloat value2 = [[self.valueArray objectAtIndex:2] floatValue];
        CGFloat totalVal = (value0 + value1 + value2) <= 0 ? 1 : (value0 + value1 + value2);
        
        double activeAngle =((value0/totalVal)*100)/100.f * ((2 * M_PI)/2);
        activeLabel.center = CGPointMake(OUTER_RADIUS + OUTER_RADIUS* sin(activeAngle),OUTER_RADIUS - OUTER_RADIUS* cos(activeAngle));
        double non_ActiveAngle =(((value0 + value1/2.f)/totalVal)*100)/100.f * (2 * M_PI);
        //    (20.f+50/2.f)/100.f * (2 * M_PI );
        nonActivelabel.center = CGPointMake(OUTER_RADIUS + OUTER_RADIUS* sin(non_ActiveAngle),OUTER_RADIUS - OUTER_RADIUS* cos(non_ActiveAngle));
        double accomplishedAngle = (((value0 +value1 +value2/2.f)/totalVal)*100)/100.f * (2 * M_PI);
        //    (20+50+30/2.f)/100.f * (2 * M_PI );
        accomplishedLabel.center = CGPointMake(OUTER_RADIUS + OUTER_RADIUS* sin(accomplishedAngle),OUTER_RADIUS - OUTER_RADIUS* cos(accomplishedAngle));
        
        activeLabel.hidden = value0 == 0;
        nonActivelabel.hidden = value1 == 0;
        accomplishedLabel.hidden = value2 == 0;
    }
    
}

- (void)drawRect:(CGRect)rect
{
    if (self.valueArray.count > 0) {
        
        // Drawing code
        CGFloat value0 = [[self.valueArray objectAtIndex:0] floatValue];
        CGFloat value1 =[[self.valueArray objectAtIndex:1] floatValue];
        CGFloat value2 = [[self.valueArray objectAtIndex:2] floatValue];
        CGFloat totalVal = (value0 + value1 + value2) <= 0 ? 1 : (value0 + value1 + value2);

        CGFloat endAngle0 = 360 * value0/totalVal;
        CGFloat endAngle1 = endAngle0 + 360 * value1/totalVal;
        CGFloat endAngle2 = 360;
        //active
        CGFloat startRadians0 =  -M_PI_2;
        CGFloat endRadians0 = DEG_2_RAD(endAngle0) - M_PI_2;
        CGPoint center = CGPointMake(OUTER_RADIUS,OUTER_RADIUS);
        UIBezierPath *arc = [UIBezierPath bezierPath];
        [arc moveToPoint:center];
        CGPoint next0;
        next0.x = center.x + RADIUS * cos(startRadians0);
        next0.y = center.y + RADIUS * sin(startRadians0);
        [arc addLineToPoint:next0]; //go one end of arc
        [arc addArcWithCenter:center radius:RADIUS startAngle:startRadians0 endAngle:endRadians0 clockwise:YES]; //add the arc
        [[UIColor colorWithRed:10/255.f green:58/255.f blue:70/255.f alpha:1.0] set];
        [arc fill];
        //non-active
        CGFloat endRadians1 = DEG_2_RAD(endAngle1) - M_PI_2;
        UIBezierPath *arc2 = [UIBezierPath bezierPath];
        [arc2 moveToPoint:center];
        CGPoint next1;
        next1.x = center.x + RADIUS * cos(endRadians1);
        next1.y = center.y + RADIUS * sin(endRadians1);
        [arc2 addLineToPoint:center]; //go one end of arc
        [arc2 addArcWithCenter:center radius:RADIUS startAngle:endRadians0 endAngle:endRadians1 clockwise:YES]; //add the arc
        [[UIColor colorWithRed:0/255.f green:124/255.f blue:152/255.f alpha:1.f] set];
        [arc2 fill];
        
        //accomplish
        CGFloat endRadians2 =  DEG_2_RAD(endAngle2) - M_PI_2;
        UIBezierPath *arc3 = [UIBezierPath bezierPath];
        [arc3 moveToPoint:center];
        CGPoint next2;
        next2.x = center.x + RADIUS * cos(endRadians1);
        next2.y = center.y + RADIUS * sin(endRadians1);
        [arc3 addLineToPoint:next2]; //go one end of arc
        [arc3 addArcWithCenter:center radius:RADIUS startAngle:endRadians1 endAngle:endRadians2 clockwise:YES]; //add the arc
        [[UIColor colorWithRed:1/255.f green:188/255.f blue:233/255.f alpha:1.f] set];
        [arc3 fill];
    }
}

- (void) setValueArray:(NSArray *)valueArray1 {
    self->valueArray = valueArray1;
    //    self->valueArray = [NSArray arrayWithObjects:@"0",@"25",@"75", nil];
    [self setNeedsLayout];
    [self setNeedsDisplay];
    CGFloat activelabel = [[self.valueArray objectAtIndex:0] floatValue];
    CGFloat nonActiveLabel = [[self.valueArray objectAtIndex:1] floatValue];
    CGFloat accomplishLabel = [[self.valueArray objectAtIndex:2]  floatValue];
    CGFloat totalVal = activelabel + nonActiveLabel + accomplishLabel;
    CGFloat activeLabelPercentage = activelabel*100/totalVal;
    CGFloat non_activePercentage = nonActiveLabel * 100/totalVal;
    CGFloat accomplishPercentage = 100 - (activeLabelPercentage + non_activePercentage);
    
    [activeLabel setText:[NSString stringWithFormat:@"%.0f%%",roundf(activeLabelPercentage)]];
    [nonActivelabel setText:[NSString stringWithFormat:@"%.0f%%",roundf(non_activePercentage)]];
    [accomplishedLabel setText:[NSString stringWithFormat:@"%.0f%%",roundf(accomplishPercentage)]];
}

@end
