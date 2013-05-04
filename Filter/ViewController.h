//
//  ViewController.h
//  Filter
//
//  Created by Zhuo Huang on 4/29/13.
//  Copyright (c) 2013 sample. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FiltersTableViewController.h"
#import "CoreDataFetchViewController.h"

@interface ViewController : CoreDataFetchViewController <FilterDelegate>
@property (nonatomic, strong) UIManagedDocument *appartmentsDatabase;
@end
