//
//  FiltersTableViewController.m
//  Filter
//
//  Created by Zhuo Huang on 4/29/13.
//  Copyright (c) 2013 sample. All rights reserved.
//

#import "FiltersTableViewController.h"
#import "ViewController.h"

typedef NS_OPTIONS(NSUInteger, ZHSelectionMask) {
    ZHNone                  = 0,
    ZHStudio                = 1 << 0,
    ZHOneBed                = 1 << 1,
    ZHTwoBed                = 1 << 2,
    ZHThreeBed              = 1 << 3,
    ZHFourBed               = 1 << 4,
};

@interface FiltersTableViewController ()

@property (nonatomic) ZHSelectionMask roomSelectionMask;
@property (nonatomic, strong) NSString *labelString;
@end

@implementation FiltersTableViewController
#define MAX_ROOM_COUNT 5

- (NSArray *)selectedRoom {
    //just iterate through the mask
    NSMutableArray *rooms = [NSMutableArray array];
    for (int i = 0; i < MAX_ROOM_COUNT; i++) {
        if (self.roomSelectionMask & (1 << i)) {
            [rooms addObject:[NSNumber numberWithInt:i]];
        }
    }
    
    //no selections
    if ([rooms count] == 0) {
        // not filtered, assume user doesn't mean none
        return @[@0,@1,@2,@3,@4];
    } else {
        return (NSArray*) rooms;
    }
    
    
}
- (IBAction)applyFilter:(id)sender {
    ViewController *viewController = (ViewController*)[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count - 2];

    self.delegate = viewController;
    // make sure delegate is responsive
    if ([[self delegate] respondsToSelector:@selector(applyFilter:)]) {
        
        NSPredicate *predicateRoom = [NSPredicate predicateWithFormat:@"SELF.price > %d AND SELF.price < %d AND SELF.room IN $ROOMLIST", (int)self.rangeSlider.lowerValue, (int)self.rangeSlider.upperValue];
        NSPredicate *predicateRoomList = [predicateRoom predicateWithSubstitutionVariables:
                         [NSDictionary dictionaryWithObject:[self selectedRoom] forKey:@"ROOMLIST"]];
        [self.delegate performSelector:@selector(applyFilter:) withObject:predicateRoomList];
    }

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureRangeSlider];
    
    //set the room selection to none
    self.roomSelectionMask = ZHNone;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self updateRoomLabel];
    if (self.rangeSlider.lowerValue != 500) {
        self.rangeSlider.lowerValue = 500;
    }
    [self updateRangeLabels];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    
    [self setPriceLabel:nil];
    [self setRangeSlider:nil];
}

#pragma mark - Range  Sliders

- (void) configureRangeSlider {
    self.rangeSlider.minimumValue = 500;
    self.rangeSlider.maximumValue = 10000;
    self.rangeSlider.lowerValue = 500;
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

- (NSString *)mapMaskToString:(NSInteger)mask {
    NSString *roomString;
    if (mask == ZHStudio)
        roomString = @"Studio";
    if (mask == ZHOneBed)
        roomString = @"1 Bed";
    if (mask == ZHTwoBed)
        roomString = @"2 Bed";
    if (mask == ZHThreeBed)
        roomString = @"3 Bed";
    if (mask == ZHFourBed)
        roomString = @"4 Bed+";
    
    return roomString;
}

- (void)updateRoomLabel {
    // No selection, done
    if (self.roomSelectionMask == 0) {
        self.roomLabel.text = @"Please Select";
        return;
    }
    
    // Tedious logic to update the room selection label
    self.labelString = @""; // init
    BOOL contiguous = NO; // check for contiguous or not
    NSMutableArray *selected = [NSMutableArray array];
    for (int i = 0; i < MAX_ROOM_COUNT; i++) {
        if (self.roomSelectionMask & (1 << i)) {    //***hit***
            if (i == 0) {
                //Studio
                [selected addObject:(id)[self mapMaskToString:(1<<i)]];
                contiguous = YES;
            }
            //chech is contiguous
            if (!contiguous) {
                if ([selected lastObject] != nil)[selected addObject:(id)@","];
                [selected addObject:(id)[self mapMaskToString:(1<<i)]];
                contiguous = YES;
            } else if (i == MAX_ROOM_COUNT -1) { //last one
                [selected addObject:(id)@" - "];
                [selected addObject:(id)[self mapMaskToString:(1<<i)]];
            }
        } else {                    //***miss***
            //check is contiguous
            if (contiguous) {
                // put "-" and index - 1 since previous was in contiguous state
                if (i >= 1 && (self.roomSelectionMask & (1 << i-2))) {
                    // if previous not inserted already**
                    [selected addObject:(id)@" - "];
                    [selected addObject:(id)[self mapMaskToString:(1<<(i-1))]];
                }
            } 
            contiguous = NO;
        }
    }
    self.labelString = [selected componentsJoinedByString:@""];
    self.roomLabel.text = self.labelString;
}

// Toggle switches for the buttons
- (IBAction)studio:(UIButton *)sender {
    self.roomSelectionMask ^= ZHStudio;
    [self updateRoomLabel];
    sender.selected = (!sender.selected)? YES : NO;
}
- (IBAction)oneBed:(UIButton *)sender {
    self.roomSelectionMask ^= ZHOneBed;
    [self updateRoomLabel];
    sender.selected = (!sender.selected)? YES : NO;
}

- (IBAction)twoBed:(UIButton *)sender {
    self.roomSelectionMask ^= ZHTwoBed;
    [self updateRoomLabel];
    sender.selected = (!sender.selected)? YES : NO;
}
- (IBAction)threeBed:(UIButton *)sender {
    self.roomSelectionMask ^= ZHThreeBed;
    [self updateRoomLabel];
    sender.selected = (!sender.selected)? YES : NO;
}
- (IBAction)fourBed:(UIButton *)sender {
    self.roomSelectionMask ^= ZHFourBed;
    [self updateRoomLabel];
    sender.selected = (!sender.selected)? YES : NO;
}

@end
