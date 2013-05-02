//
//  Appartments.m
//  Filter
//
//  Created by Zhuo Huang on 5/2/13.
//  Copyright (c) 2013 sample. All rights reserved.
//

#import "Appartments.h"

@implementation Appartments

- (id)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.name = [dict objectForKey:@"name"];
        self.room = [[dict objectForKey:@"room"] integerValue];
        self.price = [[dict objectForKey:@"price"] floatValue];
    }
    
    return self;
}

@end
