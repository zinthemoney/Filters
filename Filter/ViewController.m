//
//  ViewController.m
//  Filter
//
//  Created by Zhuo Huang on 4/29/13.
//  Copyright (c) 2013 sample. All rights reserved.
//

#import "ViewController.h"
#import "Appartments+Create.h"

@interface ViewController ()
@property (nonatomic, strong) NSMutableDictionary *tempAppartments;
@end

@implementation ViewController
@synthesize appartmentsDatabase = _appartmentsDatabase;

#define NAME_KEY @"name"
#define PRICE_KEY @"price"
#define ROOM_KEY @"room"

#pragma mark - set up database access

- (void)setupFetchedResultsController {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Appartments"];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)]];
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.appartmentsDatabase.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
}

- (void)useDocument {
    if (![[NSFileManager defaultManager] fileExistsAtPath:[self.appartmentsDatabase.fileURL path]]) {
        [self.appartmentsDatabase saveToURL:self.appartmentsDatabase.fileURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
            [self setupFetchedResultsController];
        }];
    } else if (self.appartmentsDatabase.documentState == UIDocumentStateClosed) {
        [self.appartmentsDatabase openWithCompletionHandler:^(BOOL success) {
            [self setupFetchedResultsController];
        }];
    } else if (self.appartmentsDatabase.documentState == UIDocumentStateNormal) {
        [self setupFetchedResultsController];
    }
}

- (void)setAppartmentsDatabase:(UIManagedDocument *)appartmentsDatabase {
    if (_appartmentsDatabase != appartmentsDatabase) {
        _appartmentsDatabase = appartmentsDatabase;
        [self useDocument];
    }
}

#pragma mark - views
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //initialize database
    if (!self.appartmentsDatabase) {
        NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        url = [url URLByAppendingPathComponent:@"Default Appartments Database"];
        self.appartmentsDatabase = [[UIManagedDocument alloc] initWithFileURL:url];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //can delete these after you load you database
//    self.tempAppartments = [NSMutableDictionary dictionary];
//    [self.tempAppartments setValue:@"awesome" forKey:NAME_KEY];
//    [self.tempAppartments setValue:[NSNumber numberWithFloat:700] forKey:PRICE_KEY];
//    [self.tempAppartments setValue:[NSNumber numberWithInt:3] forKey:ROOM_KEY];
//    [Appartments appartmentsWithDictionary:self.tempAppartments inManagedObjectContext:self.appartmentsDatabase.managedObjectContext];
//    
//    self.tempAppartments = [NSMutableDictionary dictionary];
//    [self.tempAppartments setValue:@"fun place" forKey:NAME_KEY];
//    [self.tempAppartments setValue:[NSNumber numberWithFloat:2700] forKey:PRICE_KEY];
//    [self.tempAppartments setValue:[NSNumber numberWithInt:5] forKey:ROOM_KEY];
//    [Appartments appartmentsWithDictionary:self.tempAppartments inManagedObjectContext:self.appartmentsDatabase.managedObjectContext];
//    
//    self.tempAppartments = [NSMutableDictionary dictionary];
//    [self.tempAppartments setValue:@"handsome" forKey:NAME_KEY];
//    [self.tempAppartments setValue:[NSNumber numberWithFloat:900] forKey:PRICE_KEY];
//    [self.tempAppartments setValue:[NSNumber numberWithInt:3] forKey:ROOM_KEY];
//    [Appartments appartmentsWithDictionary:self.tempAppartments inManagedObjectContext:self.appartmentsDatabase.managedObjectContext];
//    
//    self.tempAppartments = [NSMutableDictionary dictionary];
//    [self.tempAppartments setValue:@"sunny place" forKey:NAME_KEY];
//    [self.tempAppartments setValue:[NSNumber numberWithFloat:1700] forKey:PRICE_KEY];
//    [self.tempAppartments setValue:[NSNumber numberWithInt:2] forKey:ROOM_KEY];
//    [Appartments appartmentsWithDictionary:self.tempAppartments inManagedObjectContext:self.appartmentsDatabase.managedObjectContext];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - Tableview datasource and delegate
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // delete a note when this is triggered
        [self.fetchedResultsController.managedObjectContext deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        [self performFetch];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"AppartmentList";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    Appartments *appartments = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.textLabel.text = appartments.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Price:$ %@ | Room: %@",appartments.price, appartments.room];
    return cell;
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"filter segue"]) {

    }
}

#pragma mark - Filter Delegate method

- (void)applyFilter:(NSPredicate *)predicate {
    self.fetchedResultsController.fetchRequest.predicate = predicate;
    [self performFetch];
    [self.tableView reloadData];
}

@end
