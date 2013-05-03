//
//  FiltersTableViewController.h
//  Filter
//
//  Created by Zhuo Huang on 4/29/13.
//  Copyright (c) 2013 sample. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NMRangeSlider.h"

@protocol FilterDelegate <NSObject>
- (void)applyFilter:(NSPredicate *)predicate;
@end

@interface FiltersTableViewController : UITableViewController
//range slider
@property (nonatomic, weak) IBOutlet NMRangeSlider *rangeSlider;
@property (nonatomic, weak) IBOutlet UILabel *priceLabel;

//the 5 buttons
@property (nonatomic, weak) IBOutlet UIButton *studioButton;
@property (nonatomic, weak) IBOutlet UIButton *oneButton;
@property (nonatomic, weak) IBOutlet UIButton *twoButton;
@property (nonatomic, weak) IBOutlet UIButton *threeButton;
@property (nonatomic, weak) IBOutlet UIButton *fourButton;

@property (nonatomic, weak) IBOutlet UILabel *roomLabel;
@property (nonatomic, assign) id<FilterDelegate> delegate;

- (IBAction)rangeSliderChanged:(NMRangeSlider*)sender;
- (void)updateRoomLabel;

@end
