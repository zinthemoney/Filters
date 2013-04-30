//
//  FiltersTableViewController.m
//  Filter
//
//  Created by Zhuo Huang on 4/29/13.
//  Copyright (c) 2013 sample. All rights reserved.
//

#import "FiltersTableViewController.h"

@interface FiltersTableViewController ()
@property (nonatomic, assign) BOOL studio;
@property (nonatomic, assign) BOOL oneBed;
@property (nonatomic, assign) BOOL twoBed;
@property (nonatomic, assign) BOOL threeBed;
@property (nonatomic, assign) BOOL fourBed;

@end

@implementation FiltersTableViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureRangeSlider];
    
    //additional configs for button
    // Set the button Text Color
    [self.studioButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    // Set the button Background Color
    [self.studioButton setBackgroundColor:[UIColor blackColor]];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self updateRangeLabels];// same method used when rangeSlider value changed
}

- (void)viewDidUnload {
    [super viewDidUnload];
    
    [self setPriceLabel:nil];

    [self setRangeSlider:nil];
}

#pragma mark - Range  Sliders

- (void) configureRangeSlider {
    self.rangeSlider.minimumValue = 0;
    self.rangeSlider.maximumValue = 10000;
    self.rangeSlider.lowerValue = 0;
    self.rangeSlider.upperValue = 10000;
    self.rangeSlider.minimumRange = 100;
}

- (void)updateRangeLabels {
    // 
    self.priceLabel.text = [NSString stringWithFormat:@"$%d - $%d", (int)self.rangeSlider.lowerValue, (int)self.rangeSlider.upperValue];
    
}

- (IBAction)rangeSliderChanged:(NMRangeSlider*)sender {
    [self updateRangeLabels];
}

#pragma mark - Room selections buttons
- (void)updateRoomLabel {
    if (self.studio) {
        self.roomLabel.text = @"studio";
    } else {
        self.roomLabel.text = @"No selection";
    }
}

- (IBAction)studio:(id)sender {
    if (!self.studio) {
        [self setStudio:YES];
        //highlight button
        [self.studioButton setBackgroundColor:[UIColor greenColor]];
    } else {
        [self setStudio:NO];
        [self.studioButton setBackgroundColor:[UIColor blackColor]];
    }
    [self updateRoomLabel];

}
- (IBAction)oneBed:(id)sender {
    [self setOneBed:YES];
}

@end
