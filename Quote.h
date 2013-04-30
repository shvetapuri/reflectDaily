//
//  Quote.h
//  iReflect
//
//  Created by Shveta Puri on 1/18/13.
//  Copyright (c) 2013 Shveta Puri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Categories;

@interface Quote : NSManagedObject

@property (nonatomic, retain) NSString * quoteEntry;
@property (nonatomic, retain) NSDate * timeStamp;
@property (nonatomic,retain) NSString *author;
@property (nonatomic, retain) Categories *category;

@end
