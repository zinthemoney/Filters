//
//  Appartments.h
//  Filter
//
//  Created by Zhuo Huang on 5/2/13.
//  Copyright (c) 2013 sample. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Appartments : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) int room;
@property (nonatomic, assign) float price;

- (id)initWithDictionary:(NSDictionary *)dict;
@end
