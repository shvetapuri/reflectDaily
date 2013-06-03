//
//  iReflectDetailViewController.h
//  iReflect
//
//  Created by Shveta Puri on 1/4/13.
//  Copyright (c) 2013 Shveta Puri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Categories.h"
@class Quote;
@class Categories;
@interface iReflectDetailViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) Categories *cate;
@property (strong,nonatomic) NSArray *favoriteQuotes;

@property (strong,nonatomic) Quote *quoteObject;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

- (IBAction)done:(UIStoryboardSegue *)segue;
- (IBAction)cancel:(UIStoryboardSegue *)segue;

@end
