//
//  Categories.h
//  iReflect
//
//  Created by Shveta Puri on 1/18/13.
//  Copyright (c) 2013 Shveta Puri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Quote;

@interface Categories : NSManagedObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSSet *quote;
@property (nonatomic,retain) NSString *scheduleType;

@end

@interface Categories (CoreDataGeneratedAccessors)

- (void)addQuoteObject:(Quote *)value;
- (void)removeQuoteObject:(Quote *)value;
- (void)addQuote:(NSSet *)values;
- (void)removeQuote:(NSSet *)values;

@end
