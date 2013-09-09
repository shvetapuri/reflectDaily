//
//  iReflectQuoteDetailViewController.m
//  iReflect
//
//  Created by Shveta Puri on 2/18/13.
//  Copyright (c) 2013 Shveta Puri. All rights reserved.
//

#import "iReflectQuoteDetailViewController.h"
#import "iReflectAddQuoteViewController.h"
#import "iReflectEditQuoteViewController.h"


@interface iReflectQuoteDetailViewController ()
//@property (weak, nonatomic) IBOutlet UILabel *favoriteLabel;
@property (weak, nonatomic) IBOutlet UIButton *starButton;

@end

@implementation iReflectQuoteDetailViewController

@synthesize quoteOut=_quoteOut;
@synthesize categoryOut=_categoryOut;
@synthesize authorOut = _authorOut;
@synthesize quoteObject=_quoteObject;
@synthesize timeOut = _timeOut;
//- (id)initWithStyle:(UITableViewStyle)style
//{
//    self = [super initWithStyle:style];
//    if (self) {
//        // Custom initialization
//    }
//    
//    // Update the view.
//    [self configureView];
//    
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    NSError *error;
//	if (![[self fetchedResultsController] performFetch:&error]) {
//		// Update to handle the error appropriately.
//		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
//		exit(-1);  // Fail
//	}
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tableview_bkgnd.png"]];
    
    self.tableView.backgroundView = imageView;
    
//    self.tableView.backgroundColor = [UIColor blueColor];
//    self.tableView.backgroundView = nil;
//
    if([self.category isEqualToString:@"0AFavorites"]){
        self.title = @"Favorites";
    } else {
        self.title = self.category;
        
    }


    

//    self.authorOut.text = self.quoteObject.author;
    

    
 //   [self.quoteOut flashScrollIndicators];
    //highlight favorite button if it is a favorite quote
    
    if([self.quoteObject.favorite isEqualToNumber:[NSNumber numberWithInt:1]]){
        [self.starButton setImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
        self.favoriteLabel.text = @"Favorite";
    }
    //add to model
    
    
    
    //if date has not passed
    if(self.quoteObject.timeStamp) {
        if(!([self.quoteObject.timeStamp timeIntervalSinceNow]<0.0))
        {
            NSDateFormatter *df =[[NSDateFormatter alloc] init];
            [df setDateFormat:@"MM-dd 'at' HH:mm"];
            NSString *dateInString = [df stringFromDate:self.quoteObject.timeStamp];

            // self.timeOut.text = dateInString;
    
            NSString *titleString = [@"Scheduled for: " stringByAppendingString:dateInString ] ;
                                                                        
            self.scheduledTimeLabel.text = titleString;
            
//            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 600, 23)];
//            label.textAlignment = NSTextAlignmentLeft;
//            label.backgroundColor = [UIColor clearColor];
//            //label.shadowColor = UIColorFromRGB(0xe5e7eb);
//            //label.shadowOffset = CGSizeMake(0, 1);
//            label.textColor = [UIColor whiteColor];
//            label.text = titleString;
//    
//            label.font = [UIFont boldSystemFontOfSize:20.0];
//            UIBarButtonItem *toolBarTitle = [[UIBarButtonItem alloc] initWithCustomView:label];
//            self.toolbarItems = [NSArray arrayWithObject: toolBarTitle ];

}
    }
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload {
    self.fetchedResultsController = nil;
}

- (IBAction)shareButtonAction:(UIBarButtonItem *)sender {
    
   // UIImage *image = [UIImage imageNamed:@"iReflectIcon_57.png"];

    NSAttributedString *appName=[[NSMutableAttributedString alloc] initWithString:@"iReflect" attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:[UIFont systemFontSize]],NSForegroundColorAttributeName:[UIColor brownColor]}];
    NSArray *dataToShare;
    
    if([self.quoteObject.author length]){
        dataToShare = [NSArray arrayWithObjects:@"", appName, self.quoteObject.quoteEntry,[@"-" stringByAppendingString:self.quoteObject.author],nil];

    } else {
       dataToShare = [NSArray arrayWithObjects:@"", appName, self.quoteObject.quoteEntry,nil];

    }
    
       
    UIActivityViewController* activityViewController =
    [[UIActivityViewController alloc] initWithActivityItems:dataToShare
                                      applicationActivities:nil];
    //[activityViewController setValue:@"A Reflection from iReflect" forKey:@"subject"];
    
    [self presentViewController:activityViewController animated:YES completion:^{}];
}

- (IBAction)favoriteItem:(UIButton *)sender {
    UIImage *image = self.starButton.currentImage;
    Quote *quote = self.quoteObject;
    
    
    if([image isEqual:[UIImage imageNamed:@"star"]])
    {
        [sender setImage:[UIImage imageNamed:@"star_gray"] forState:UIControlStateNormal];
        
        //take out of model
        quote.favorite=[NSNumber numberWithInt:0];
        
        self.favoriteLabel.text = @"Add to favorites";

    } else {
        [sender setImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
        
        //add to model
        quote.favorite=[NSNumber numberWithInt:1];
        self.favoriteLabel.text = @"Favorite";
  
    }
    
    
   [self saveData];
}


//- (void)configureView
//{
//    // Update the user interface for the detail item.
//   // BirdSighting *theSighting = self.sighting;
//    
//    static NSDateFormatter *formatter = nil;
//    if (formatter == nil) {
//        formatter = [[NSDateFormatter alloc] init];
//        [formatter setDateStyle:NSDateFormatterMediumStyle];
//    }
//    if (self.quoteObject) {
//        self.quoteOut.text = self.quoteObject.quoteEntry;
//        self.authorOut.text = self.quoteObject.author;
//        
//       // self.categoryOut.text = self.quoteObject.categor;
//       
//    }
//}

- (IBAction)done:(UIStoryboardSegue *)segue
{
    if ([[segue identifier] isEqualToString:@"ReturnInput"]) {
        iReflectEditQuoteViewController *editController = [segue sourceViewController];
        
        if (editController.quoteInput!=nil && [editController.quoteInput.text length]) {
            //save the quote in core data that was input by  user in addQuote
            Quote *quote = self.quoteObject;
            
            // NSDate *today = [NSDate date];
            quote.quoteEntry=editController.quoteInput.text;
            //quote.timeStamp = today;
            quote.category = self.categoryObject;
            quote.author = editController.authorInput.text;
            
            [self.categoryObject addQuoteObject:quote];
            
            //save
            
            [self saveData];
            //update labels
//            self.quoteOut.text = quote.quoteEntry;
//            self.authorOut.text = quote.author;
//            
//            [self.quoteOut flashScrollIndicators];

        
        } else {
            UIAlertView *info = [[UIAlertView alloc] initWithTitle:@"Warning" message: @"The quote field was empty, quote was not saved." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [info show];
        }
    
     [self dismissViewControllerAnimated:YES completion:NULL];
    }
}

-(void)saveData {
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    
    
    [[self tableView] reloadData];
}

- (IBAction)cancel:(UIStoryboardSegue *)segue
{
    if ([[segue identifier] isEqualToString:@"CancelInput"]) {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"editQuote"]) {

        UINavigationController *navController = (UINavigationController*)[segue destinationViewController];
        iReflectEditQuoteViewController *editQ=(iReflectEditQuoteViewController *) [navController topViewController];
        editQ.quoteTextfieldString = self.quoteObject.quoteEntry;
        editQ.authorTextfieldString = self.quoteObject.author;
        editQ.category = self.category;
               
        
    }
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //static NSString *CellIdentifier = @"Cell";
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    if(cell.tag==1)  {
        cell.textLabel.numberOfLines=0;
        cell.textLabel.font=[self fontForCell];
       cell.textLabel.text = self.quoteObject.quoteEntry;
    
    } else if(cell.tag==2) {
        cell.textLabel.numberOfLines=0;
        cell.textLabel.font=[self fontForCell];
        cell.textLabel.text = self.quoteObject.author;

    }
    
   
    return cell;
}




/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *text = [self getTextForIndexPath:indexPath];
    UIFont *font = [self fontForCell];
    CGSize size = [self getSizeOfText:text withFont:font];
    
    //set height for textview too
//    CGRect frame = self.quoteOut.frame;
//    frame.size=size;
//    self.quoteOut.frame = frame;
    
    return (size.height); // I put some padding on it.
}

- (UIFont *)fontForCell
{
    return [UIFont systemFontOfSize:14];
}
//- See more at: http://timbroder.com/2012/09/ios-multiple-lines-of-text-in-a-uitableviewcell.html#sthash.7INNdhP5.dpuf

//Then you write a method pull the text for this cell...

- (NSString *)getTextForIndexPath:(NSIndexPath *)indexPath
{
    //NSString *sectionHeader = [self.tableSections objectAtIndex:[indexPath section]];
    NSString *sectionContent;
   // NSLog(@"indexpathsection %d", indexPath.section);
    if(indexPath.section==0) {
        sectionContent= self.quoteObject.quoteEntry;
    } else if (indexPath.section==1){
        sectionContent=self.quoteObject.author;
    } else {
        sectionContent=@"Star favorite your item";
    }
    return sectionContent;
}
//And this is to get the size of the text.

- (CGSize)getSizeOfText:(NSString *)text withFont:(UIFont *)font
{
    return [text sizeWithFont:font constrainedToSize:CGSizeMake(280.0f, MAXFLOAT) ];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        
    UIView *backView = [[UIView alloc] initWithFrame:CGRectZero];
    backView.backgroundColor = [UIColor clearColor];
    cell.backgroundView = backView;
    
    
//    if(indexPath.section==2){
//        [cell.contentView addSubview:self.starButton];
//        NSLog(@"content");
//    }
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//    
//    [self configureCell:cell atIndexPath:indexPath];
//    
//    
//    return cell;
//}
//
//- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
//{
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
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
   
    Categories *categoryName = self.categoryObject;
   // NSLog(@"category11 = %@", categoryName.name);

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

//- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
//       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
//      newIndexPath:(NSIndexPath *)newIndexPath
//{
//    UITableView *tableView = self.tableView;
//    
//    switch(type) {
//        case NSFetchedResultsChangeInsert:
//            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
//            break;
//            
//        case NSFetchedResultsChangeDelete:
//            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//            break;
//            
//        case NSFetchedResultsChangeUpdate:
//            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
//            break;
//            
//        case NSFetchedResultsChangeMove:
//            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
//            break;
//    }
//}

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
