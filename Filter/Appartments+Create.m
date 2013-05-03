//
//  Appartments+Create.m
//  Filter
//
//  Created by Zhuo Huang on 5/2/13.
//  Copyright (c) 2013 sample. All rights reserved.
//

#import "Appartments+Create.h"

@implementation Appartments (Create)

+ (Appartments *)appartmentsWithDictionary:(NSDictionary *)aDict inManagedObjectContext:(NSManagedObjectContext *)context {
    Appartments *appartments = nil;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Appartments"];
    request.predicate = [NSPredicate predicateWithFormat:@"name = %@", [aDict objectForKey:@"name"]];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSError *error = nil;
    NSArray *AppartmentCollection = [context executeFetchRequest:request error:&error];
    if (!AppartmentCollection || [AppartmentCollection count]>1) {
        //error
    }
    if (![AppartmentCollection count]){
        appartments = [NSEntityDescription insertNewObjectForEntityForName:@"Appartments" inManagedObjectContext:context];
        appartments.name = [aDict objectForKey:@"name"];//added to dictionary
        appartments.price = [aDict objectForKey:@"price"];
        appartments.room = [aDict objectForKey:@"room"];
    } else {
        appartments = [AppartmentCollection lastObject];
    }
    return appartments;
}

@end
