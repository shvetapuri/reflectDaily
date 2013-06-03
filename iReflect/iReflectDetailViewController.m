//
//  iReflectDetailViewController.m
//  iReflect
//
//  Created by Shveta Puri on 1/4/13.
//  Copyright (c) 2013 Shveta Puri. All rights reserved.
//

#import "iReflectDetailViewController.h"
#import "Quote.h"
#import "Categories.h"
#import "iReflectAppDelegate.h"
#import "iReflectAddQuoteViewController.h"
#import "iReflectQuoteDetailViewController.h"

@interface iReflectDetailViewController ()
//- (void)configureView;
@end

@implementation iReflectDetailViewController
@synthesize managedObjectContext=_managedObjectContext;
@synthesize fetchedResultsController = _fetchedResultsController;
@synthesize cate=_cate;
@synthesize quoteObject=_quoteObject;

#pragma mark - Managing the detail item

//- (void)setDetailItem:(id)newDetailItem
//{
//    if (_detailItem != newDetailItem) {
//        _detailItem = newDetailItem;
//        
//        // Update the view.
//        [self configureView];
//    }
//}
//
//- (void)configureView
//{
//    // Update the user interface for the detail item.
//
//    if (self.detailItem) {
//        self.detailDescriptionLabel.text = [[self.detailItem valueForKey:@"timeStamp"] description];
//    }
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tableview_bkgnd.png"]];
    
    self.tableView.backgroundView = imageView;
    
    NSError *error;
	if (![[self fetchedResultsController] performFetch:&error]) {
		// Update to handle the error appropriately.
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		exit(-1);  // Fail
	}
    
    self.title = self.cate.name ;

    
  //  [self configureView];
}


- (void)viewDidUnload {
    self.fetchedResultsController = nil;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)done:(UIStoryboardSegue *)segue
{
    if ([[segue identifier] isEqualToString:@"ReturnInput"]) {
        
        iReflectAddQuoteViewController *addController = [segue sourceViewController];
        if (addController.quoteInput!=nil && [addController.quoteInput.text length]) {
            //save the quote in core data that was input by  user in addQuote
            Quote *quote = self.quoteObject;

           // NSDate *today = [NSDate date];
            quote.quoteEntry=addController.quoteInput.text;
            //quote.timeStamp = today;
            quote.category = self.cate;
            quote.author = addController.authorInput.text;
            
            [self.cate addQuoteObject:quote];

            //if quote's category is scheduled, then schedule quote too
            if([self.cate.scheduled isEqualToNumber:[NSNumber numberWithInt:1]]) {
                //find out the latest time scheduled and schedule new quote at end
                NSArray *fetchedQuotes = [self.fetchedResultsController fetchedObjects];
                
                //sort so that the latest date is first
                NSSortDescriptor *sortDescriptor;
                sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timeStamp" ascending:NO] ;
                NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
                NSArray *sortedArray;
                sortedArray = [fetchedQuotes sortedArrayUsingDescriptors:sortDescriptors];
                
                //calculate a time to schedule new quote by adding a day to the latest time
                
                //find latest time add a day to it
                Quote *quoteWithLastTime = [sortedArray objectAtIndex:0];
                NSDate *lastTime = quoteWithLastTime.timeStamp;
                NSCalendar *theCalendar = [NSCalendar currentCalendar];
                NSDateComponents *dayComponent = [[NSDateComponents alloc] init] ;
                dayComponent.day = 1;
                
                NSDate *newQuoteDate= [theCalendar dateByAddingComponents:dayComponent toDate:lastTime options:0];
                
                //schedule alert
                UILocalNotification *localNot= [[UILocalNotification alloc] init];
                [localNot setTimeZone:[NSTimeZone defaultTimeZone]];
                //localNot.applicationIconBadgeNumber=1;
                localNot.repeatInterval = 0;
                [localNot setAlertAction:@"Go to iReflect"];
                localNot.soundName=UILocalNotificationDefaultSoundName;
                localNot.AlertBody = addController.quoteInput.text;
                localNot.fireDate = newQuoteDate;
                [[UIApplication sharedApplication] scheduleLocalNotification:localNot];
                quote.timeStamp = newQuoteDate;
                
            }
            
            //save
            NSError *error;
            if (![self.managedObjectContext save:&error]) {
                NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            }
            
            [[self tableView] reloadData];
            
        } else {
            UIAlertView *info = [[UIAlertView alloc] initWithTitle:@"Warning" message: @"The quote field was empty, quote was not saved." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [info show];
        }
        
//        //go back to quote detail view if editing quote
//        if(addController.editQuote){
//            
//            NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//            
//            Quote *object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
//            iReflectQuoteDetailViewController *qvc =[segue destinationViewController];
//            qvc.quoteObject=object;
//            self.quoteObject=object;
//            qvc.category = object.category.name;
//            
//            iReflectQuoteDetailViewController *myOtherViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"iReflectQuoteDetailViewController"];
//            
//            [self presentViewController:myOtherViewController animated:YES completion:nil];
//            
//        }
        
        [self dismissViewControllerAnimated:YES completion:NULL];
        
        
      
    } 
    
}

- (IBAction)cancel:(UIStoryboardSegue *)segue
{
    if ([[segue identifier] isEqualToString:@"CancelInput"]) {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}



#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //return [[self.fetchedResultsController sections] count];
   return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(![self.cate.name isEqualToString:@"Favorites"]) {
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
    } else {
        return [self.favoriteQuotes count];
    }
//
 //   return 2;
}
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
        Quote *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
       cell.textLabel.text = object.quoteEntry;
 
    UIFont *myFont = [ UIFont fontWithName: @"System" size: 17.0 ];
    cell.textLabel.font  = myFont;
    
    
  //   Categories *categ = [self.fetchedResultsController objectAtIndexPath:indexPath];
  //  NSSortDescriptor *sort=[NSSortDescriptor sortDescriptorWithKey:@"quote" ascending:YES];
   // NSArray *sortedQuotes=[categ.quote sortedArrayUsingDescriptors:[NSArray arrayWithObject:sort]];
  //  Quote *quoteRow=[sortedQuotes objectAtIndex:indexPath.row];
   // cell.textLabel.text = quoteRow.quoteEntry;

   
  //  cell.textLabel.text = categ.name;
    

    
    //
    //cell.textLabel.text = [[object valueForKey:@"quoteEntry"] description];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NSLog(@"favorites %@",self.cate.name);
    if(![self.cate.name isEqualToString:@"Favorites"]) {
        [self configureCell:cell atIndexPath:indexPath];
    } else {
        [self configureFavoritesCell:cell atIndexPath:indexPath];

    }
    
    return cell;
}

- (void)configureFavoritesCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    if(self.favoriteQuotes) {
        Quote *object = [self.favoriteQuotes objectAtIndex:indexPath.row];
        cell.textLabel.text = object.quoteEntry;
        
        UIFont *myFont = [ UIFont fontWithName: @"System" size: 17.0 ];
        cell.textLabel.font  = myFont;
    } else {
        NSLog(@"none");
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // The table view should not be re-orderable.
    return NO;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"quoteDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Quote *object;
        if(![self.cate.name isEqualToString:@"Favorites"]) {
            object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
        } else {
            object = [self.favoriteQuotes objectAtIndex:indexPath.row];
        }
        iReflectQuoteDetailViewController *qvc =[segue destinationViewController];
        qvc.quoteObject=object;
        self.quoteObject=object;
        qvc.category = object.category.name;
        qvc.categoryObject=object.category;
        qvc.managedObjectContext=self.managedObjectContext;
        
//        qvc.quoteOut.text = object.quoteEntry;
//        qvc.categoryOut.text = object.category.name;
        
       // [[segue destinationViewController] set;
    }
    if ([[segue identifier] isEqualToString:@"addQuote"]) {
     //   NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
       // Quote *object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
        
        UINavigationController *navController = (UINavigationController*)[segue destinationViewController];
        iReflectAddQuoteViewController *addQ=(iReflectAddQuoteViewController *) [navController topViewController];
        
        self.quoteObject = [NSEntityDescription insertNewObjectForEntityForName:@"Quote"
                                                     inManagedObjectContext:self.managedObjectContext] ;
        
        addQ.category=self.cate.name;
        
        
        //[self.navigationController pushViewController:addQ animated:YES];
    }
    
    
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Quote" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    //filter based on category
    Categories *categoryName = self.cate;
    NSLog(@"category = %@", categoryName.name);
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"category = %@", categoryName];
//    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"category = Wisdom"];

    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"quoteEntry" ascending:YES];
    NSArray *sortDescriptors = @[sortDescriptor];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
	NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    return _fetchedResultsController;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

/*
 // Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed.
 
 - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
 {
 // In the simplest, most efficient, case, reload the table view.
 [self.tableView reloadData];
 }
 */




@end
