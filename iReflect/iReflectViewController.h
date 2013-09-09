//
//  iReflectViewController.h
//  iReflect
//
//  Created by Shveta Puri on 7/17/13.
//  Copyright (c) 2013 Shveta Puri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <StoreKit/StoreKit.h>


@interface iReflectViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate>


@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong,nonatomic) NSMutableArray *selectedCategoryObjects;
@property (strong,nonatomic) NSMutableArray *selectedCategoryStrings;

//@property (nonatomic, strong) NSArray *quoteList;
@property (nonatomic) BOOL newQuotesScheduled;


- (IBAction)done:(UIStoryboardSegue *)segue;
- (IBAction)cancel:(UIStoryboardSegue *)segue;
- (IBAction)cancelReminders:(id)sender;




@end
