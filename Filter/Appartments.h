//
//  Appartments.h
//  Filter
//
//  Created by Zhuo Huang on 5/2/13.
//  Copyright (c) 2013 sample. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Appartments : NSManagedObject

@property (nonatomic, retain) NSNumber * room;
@property (nonatomic, retain) NSNumber * price;
@property (nonatomic, retain) NSString * name;

@end
