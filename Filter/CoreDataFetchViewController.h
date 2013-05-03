//
//  CoreDataFetchViewController.h
//  Filter
//
//  Created by Zhuo Huang on 5/2/13.
//  Copyright (c) 2013 sample. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface CoreDataFetchViewController :  UITableViewController <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic) BOOL suspendAutomaticTrackingOfChangesInManagedObjectContext;

- (void)performFetch;
@end
