//
//  Quote.h
//  iReflect
//
//  Created by Shveta Puri on 1/7/13.
//  Copyright (c) 2013 Shveta Puri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Quote : NSManagedObject

@property (nonatomic, retain) NSString * quoteEntry;
@property (nonatomic, retain) NSDate * timeStamp;

@end
