//
//  iReflectMasterViewController.h
//  iReflect
//
//  Created by Shveta Puri on 1/4/13.
//  Copyright (c) 2013 Shveta Puri. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>

@interface iReflectMasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
