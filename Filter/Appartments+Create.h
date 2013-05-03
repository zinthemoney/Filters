//
//  Appartments+Create.h
//  Filter
//
//  Created by Zhuo Huang on 5/2/13.
//  Copyright (c) 2013 sample. All rights reserved.
//

#import "Appartments.h"

@interface Appartments (Create)
+ (Appartments *)appartmentsWithDictionary:(NSDictionary *)aDict inManagedObjectContext:(NSManagedObjectContext *)context;
@end
