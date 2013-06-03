//
//  iReflectQuoteDetailViewController.h
//  iReflect
//
//  Created by Shveta Puri on 2/18/13.
//  Copyright (c) 2013 Shveta Puri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Categories.h"
#import "Quote.h"
#import <CoreData/CoreData.h>
@class Quote;
@class Categories;

@interface iReflectQuoteDetailViewController : UITableViewController<NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
//@property (strong, nonatomic) IBOutlet UILabel *quoteOut;
@property (weak, nonatomic) IBOutlet UITextView *quoteOut;
@property (weak, nonatomic) IBOutlet UITextView *authorOut;
@property (weak, nonatomic) IBOutlet UILabel *categoryOut;
//@property (strong, nonatomic) IBOutlet UILabel *authorOut;
@property (weak, nonatomic) IBOutlet UILabel *timeOut;
@property (weak, nonatomic) IBOutlet UILabel *scheduledTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *favoriteLabel;

@property (strong,nonatomic) Quote *quoteObject;
@property (strong, nonatomic) NSString *category;


@property (strong, nonatomic) Categories *categoryObject;


- (IBAction)done:(UIStoryboardSegue *)segue;
- (IBAction)cancel:(UIStoryboardSegue *)segue;
@end
