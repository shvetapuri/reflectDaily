//
//  iReflectMasterViewController.h
//  iReflect
//
//  Created by Shveta Puri on 1/4/13.
//  Copyright (c) 2013 Shveta Puri. All rights reserved.
//DELETEE THIS:
//An alarm in a UIApplication is known as a local notification.
//
//To create one use the method scheduleLocalNotification:.
//
//See: http://developer.apple.com/library/ios/documentation/uikit/reference/UIApplication_Class/Reference/Reference.html#//apple_ref/occ/instm/UIApplication/scheduleLocalNotification:


#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>

@interface iReflectMasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSMutableArray *list;

@property (strong,nonatomic) NSMutableArray *selectedCategoryObjects;
@property (strong,nonatomic) NSMutableArray *selectedCategoryStrings;

//@property (nonatomic, strong) NSArray *quoteList;

- (IBAction)done:(UIStoryboardSegue *)segue;
- (IBAction)cancel:(UIStoryboardSegue *)segue;
- (IBAction)cancelReminders:(id)sender;


@end
