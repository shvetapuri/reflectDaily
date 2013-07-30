//
//  iReflectViewController.m
//  iReflect
//
//  Created by Shveta Puri on 1/4/13.
//  Copyright (c) 2013 Shveta Puri. All rights reserved.
//

#import "iReflectViewController.h"
#import "iReflectAddCategoryViewController.h"
#import "iReflectDetailViewController.h"
#import "iReflectScheduleQuotesViewController.h"
#import "iReflectAppDelegate.h"

#import "Quote.h"
#import "Categories.h"
@interface iReflectViewController ()
@property (strong, nonatomic) Categories *favoriteCategory;
@property (strong, nonatomic) IBOutlet UILabel *dailyQuoteLabel;
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) iReflectAppDelegate *appDelegate;
@end

@implementation iReflectViewController
@synthesize managedObjectContext;

//@synthesize quoteList=_quoteList;
@synthesize fetchedResultsController=_fetchedResultsController;

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
   

    
    self.appDelegate = (iReflectAppDelegate *)[[UIApplication sharedApplication] delegate];
    
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    //self.editButtonItem.action = @selector(editButtonPushed:);
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tableview_bkgnd.png"]];
    self.tableView.backgroundView = imageView;
    
    
    //  [[self view] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"iReflect_tableBackgnd.png"]]];
    
    //daily quote label
    self.dailyQuoteLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 160)];
    self.dailyQuoteLabel.font=[UIFont fontWithName:@"Georgia"  size:13];
    self.dailyQuoteLabel.backgroundColor =[UIColor clearColor];
    self.dailyQuoteLabel.numberOfLines = 0;
    self.dailyQuoteLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:self.imageView];
    //[self.view bringSubviewToFront:self.dailyQuoteLabel];
    [self.imageView addSubview:self.dailyQuoteLabel];
    
    
    //    UIBarButtonItem *buttonItem;
    ////
    // //   buttonItem = [[ UIBarButtonItem alloc ] initWithTitle: @"Cancel all Reminders"
    //                                                    style: UIBarButtonItemStyleBordered
    //                                                   target: self
    //                                                   action: @selector(scheduleCancel:)
    //
    //                                                ];
    //
    //    self.toolbarItems =
    //    buttonItem = [[ UIBarButtonItem alloc ] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(scheduleReminder)];
    
    //   self.toolbarItems = [ NSArray arrayWithObject: buttonItem ];
    
    
    
    
    NSError *error;
	if (![[self fetchedResultsController] performFetch:&error]) {
		// Update to handle the error appropriately.
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		exit(-1);  // Fail
	}
    
    
    self.title = @"iReflect";
    
    //check and add favorites
    //[self addFavorites];
    
    //   UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    //  self.navigationItem.rightBarButtonItem = addButton;
}



//-(void) showNewQuotesScheduledAlert {
//    
//    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"localNotifsScheduled"];
//    
//    [[NSUserDefaults standardUserDefaults] synchronize];
//    
//    UIAlertView *alert = [[UIAlertView alloc]
//                          initWithTitle:@"Alert"
//                          message: @"New reflections have been added to the schedule"
//                          delegate: nil
//                          cancelButtonTitle:@"OK"
//                          otherButtonTitles:nil];
//    [alert show];
//    
//    
//    
//}

- (void)viewDidAppear:(BOOL)animated {
    self.dailyQuoteLabel.text=[self getDailyQuote ];

//    [super viewDidAppear:YES];
//    
//    BOOL didScheduleNotifs=[[NSUserDefaults standardUserDefaults]  boolForKey:@"localNotifsScheduled"];
//    NSLog(@"bool vaue %d",didScheduleNotifs);
//    
//    if(didScheduleNotifs) {
//        NSLog(@"in alert show");
//        
//     //   [self showNewQuotesScheduledAlert];
//    
//    }
}


-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];

    
    [self addFavoriteCategory];
    
       
    [self updateScheduledLabel];
}
-(NSArray *) getCurrentQuoteObjects{
    NSArray *fetched = [self.fetchedResultsController fetchedObjects] ;
    NSMutableArray *allQuoteObjects = [[NSMutableArray alloc] init];
    
    for(Categories *cat in fetched) {
        for(Quote *q in cat.quote) {
            [allQuoteObjects addObject:q];
        }
    }
    
    return allQuoteObjects;
}

//-(void)willPresentAlertView:(UIAlertView *)alertView{
//    UILabel *title = [alertView valueForKey:@"_titleLabel"];
//    title.font = [UIFont fontWithName:@"Arial" size:18];
//    [title setTextColor:[UIColor whiteColor]];
//     
//     UILabel *body = [alertView valueForKey:@"_bodyTextLabel"];
//     body.font = [UIFont fontWithName:@"Arial" size:9];
//     [body setTextColor:[UIColor whiteColor]];
//      }

      
-(NSArray *) sortQuotesByTimeStamp:(NSArray *)quotesArray ascending:(BOOL)ascending {
    
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timeStamp" ascending:ascending] ;
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSArray *sortedArray;
    sortedArray = [quotesArray sortedArrayUsingDescriptors:sortDescriptors];
    
    return sortedArray;
}
-(NSString *) getDailyQuote {
    
    NSArray *fetchedQuotes = [self getCurrentQuoteObjects] ;
    
    NSArray *sortedArray = [self sortQuotesByTimeStamp:fetchedQuotes ascending:YES];
    NSDate *dateToday = [NSDate date];
    for (Quote *findLatest in sortedArray ) {
                
        
        if(findLatest.timeStamp) {
            NSDate *latestDate = findLatest.timeStamp;
            //Extract date only
            
            [[NSCalendar currentCalendar] rangeOfUnit:NSDayCalendarUnit startDate:&dateToday interval:NULL forDate:dateToday];
            [[NSCalendar currentCalendar] rangeOfUnit:NSDayCalendarUnit startDate:&latestDate interval:NULL forDate:latestDate];

            
            if([self daysBetweenDate:dateToday andDate:latestDate]==0) {
                NSLog(@"HEre is latest QUOTE : %@",findLatest.quoteEntry);
                
                return (findLatest.quoteEntry);
            }
        }
    }
    
    Quote *latestQuote = [sortedArray objectAtIndex:0];
    NSLog(@"HEre is  QUOTE : %@",latestQuote.quoteEntry);
    return (latestQuote.quoteEntry);
    
}

-(NSInteger *) daysBetweenDate:(NSDate *)firstDate andDate: (NSDate *) secondDate
{
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [currentCalendar components: NSDayCalendarUnit
                                                      fromDate: firstDate
                                                        toDate: secondDate
                                                       options: 0];
    
    NSInteger day = [components day];
    return day;
}

-(void) addFavoriteCategory {
    NSArray *fetched = [self.fetchedResultsController fetchedObjects] ;
    Categories *cateFav;
    
    for(Categories *cat in fetched) {
        if([cat.name isEqual:@"0AFavorites"]){//favorite category
            cateFav=cat;
            self.favoriteCategory = cat;
            
        }
        
    }
    
    if(!cateFav) {
        
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        Categories *category = [NSEntityDescription insertNewObjectForEntityForName:@"Categories"
                                                             inManagedObjectContext:context] ;
        //favorites called 0favorites to enable correct sorting order
        [category setName:@"0AFavorites"];
        self.favoriteCategory=category;
        
        [self saveContext];
        
    }
    
    
}
-(NSArray *)addFavorites{
    NSArray *fetched = [self.fetchedResultsController fetchedObjects] ;
    NSMutableArray *favQuotes = [[NSMutableArray alloc] init];
    
    
    for(Categories *cat in fetched) {
        for(Quote *q in cat.quote) {
            if([q.favorite isEqualToNumber:[NSNumber numberWithInt:1]]) {
                [favQuotes addObject:q];
            }
        }
        
    }
    
    
    
    return favQuotes;
    
}
- (IBAction)cancelReminders:(id)sender{
    
    //are you sure you want to cancel
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Cancel all scheduled reflections?" delegate:(id<UIActionSheetDelegate>) self cancelButtonTitle:@"Don't cancel" destructiveButtonTitle:@"Cancel schedule" otherButtonTitles:nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
    
    
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
 	if (buttonIndex == 0) {
        //cancel all exisiting notifications
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        
        //delete timestamp in quote object
        NSArray *fetched = [self.fetchedResultsController fetchedObjects] ;
        for (Categories *ca in fetched) {
            ca.scheduleType = @"none";
            for(Quote *q in ca.quote) {
                
                q.timeStamp = nil;
                
            }
        }
        NSError *error;
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"couldn't erase timestamp: %@", [error localizedDescription]);
        }
        
        [self.tableView reloadData];
        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Alert"
                              message: @"All scheduled reflections have been canceled."
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
 	} else if (buttonIndex == 1) {
 		NSLog(@"Cancel button clicked");
 	}
}




-(void) saveContext {
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"couldn't erase timestamp: %@", [error localizedDescription]);
    }
    
}

-(void) scheduleReminder:(id)sender {
    
    iReflectScheduleQuotesViewController *addController = [[iReflectScheduleQuotesViewController alloc] init];
    
    // if ([[segue identifier] isEqualToString:@"schedule"]) {
    
    //    AddQuoteViewController *addController = [segue destinationViewController];
    
    // UINavigationController *navigationController = [[UINavigationController alloc]
    //   initWithRootViewController:addController];
    // [self presentViewController:navigationController animated:YES completion: nil];
    [self.navigationController pushViewController:addController animated:YES];
    //  }
}
- (void)viewDidUnload {
    //        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    //    [context deleteObject:self.favoriteCategory];
    //    [self saveContext];
    //
    self.fetchedResultsController = nil;
    
    
    
}


- (IBAction)done:(UIStoryboardSegue *)segue
{
    if ([[segue identifier] isEqualToString:@"ReturnInputAddCate"]) {
        
        iReflectAddCategoryViewController *addController = [segue sourceViewController];
        
        NSArray *fetchedCategories = [self.fetchedResultsController fetchedObjects] ;
        NSMutableArray *categoryNames=[[NSMutableArray alloc ]init ];
        for(Categories *ca in fetchedCategories) {
            [categoryNames addObject:ca.name];
        }
        
        if (addController.categoryInput!=nil && [addController.categoryInput.text length] && ![categoryNames containsObject:addController.categoryInput.text]) {
            //save the quote in core data that was input by  user in addQuote
            
            NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
            //   NSManagedObjectContext *context = self.managedObjectContext;
            
            Categories *category = [NSEntityDescription insertNewObjectForEntityForName:@"Categories"
                                                                 inManagedObjectContext:context] ;
            
            [category setName:addController.categoryInput.text];
            
            
            
            //save
            NSError *error;
            if (![context save:&error]) {
                NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            }
            
            
            //sort alphabetically
            NSArray *fetchedCategories = [self.fetchedResultsController fetchedObjects] ;
            NSSortDescriptor *sortDescriptor;
            sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES] ;
            NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
            NSArray *sortedArray;
            sortedArray = [fetchedCategories sortedArrayUsingDescriptors:sortDescriptors];
            
            //save
            if (![context save:&error]) {
                NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            }
            
            
            [[self tableView] reloadData];
            
            
        } else {
            //don't save duplicate category
            if([categoryNames containsObject:addController.categoryInput.text]) {
                UIAlertView *info = [[UIAlertView alloc] initWithTitle:@"Warning" message: @"This category name already exists, category was not saved." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [info show];
            } else {
                //don't save empty category
                
                UIAlertView *info = [[UIAlertView alloc] initWithTitle:@"Warning" message: @"The category field was empty, category was not saved." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [info show];
            }
        }
        
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
    
    
    
    //SCHEDULE LOCAL NOTIFICATIONS
    if ([[segue identifier] isEqualToString:@"ReturnInput"]) {
        
        
        
        Boolean randomTime;
        BOOL favoriteSelected = NO;
        iReflectScheduleQuotesViewController *addSchedule = [segue sourceViewController];
        
        NSCalendar *theCalendar = [NSCalendar currentCalendar];
        
        NSDate *startDate =[[NSDate alloc] init];
        
        NSDateComponents *randComponents = [[NSDateComponents alloc]init ];
        randComponents=[theCalendar components:(NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:[NSDate date]];
        
        NSMutableArray *quoteTimes=[[NSMutableArray alloc] init];
        //segment button random time or scheduled
        NSInteger index = [addSchedule.intervalPicker selectedSegmentIndex];
        int startTimeLocal;
        int endTimeLocal;
        
        switch (index) {
                
            case 0:
            {  //Set time picked by user
                randomTime=NO;
                startDate = addSchedule.datePicker.date;
                break;
            }
            case 1:
            {
                randomTime = YES;
                
                startTimeLocal= [addSchedule convertTo24hr:addSchedule.startTime ampm:addSchedule.startampm];
                endTimeLocal = [addSchedule convertTo24hr:addSchedule.endTime ampm:addSchedule.endampm];
                
                NSLog(@"starttimelocal : %d  startTimeSelected %@  , endTimelocal : %d  endTimeselected %@",startTimeLocal, addSchedule.startTime, endTimeLocal, addSchedule.endTime );
                
                if(endTimeLocal<=startTimeLocal) {
                    UIAlertView *alert = [[UIAlertView alloc]
                                          initWithTitle:@"Attention: Action Canceled!"
                                          message: @"Start time must be before end time in random timer window. Please select correct times and reschedule"
                                          delegate: nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
                    [alert show];
                    
                    return;
                }
                
                break;
            }
                
            default:
            {
                startDate = addSchedule.datePicker.date;
                break;
                
            }
        }
        
        //cancel all exisiting notifications
        
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        
        NSArray *fetched = [self.fetchedResultsController fetchedObjects] ;
        
        NSMutableArray *allQuotes = [[NSMutableArray alloc] init];
        //      NSMutableDictionary *quotesDict = [[NSMutableDictionary alloc] init];
        //      NSMutableArray *quoteDictArray = [[NSMutableArray alloc] init];
        
        // if([addSchedule.selectedCategoryArray count]){
        //            for(int f=0;f<[addSchedule.selectedCategoryArray count];f++)
        //            {
        //                NSLog(@"YES, %@",[addSchedule.selectedCategoryArray objectAtIndex:f]);
        //            }
        //}
        
        
        if([addSchedule.selectedCategoryArray containsObject:@"all"]) {
            
            for (Categories *ca in fetched) {
                for(Quote *q in ca.quote) {
                    [allQuotes addObject:q];
                }
            }
        } else {
            
            for (Categories *ca in fetched) {
                if([addSchedule.selectedCategoryArray containsObject:ca.name]) {
                    for(Quote *q in ca.quote) {
                        [allQuotes addObject:q];
                    }
                }
                
                
            }
            
            if([addSchedule.selectedCategoryArray containsObject:@"0AFavorites"]){
                
                favoriteSelected= YES;
                //get all the quote objects marked favorite, if it has not already been
                //added to allQuotes array then add it.
                NSArray *favoriteQuotes = [self addFavorites];
                for(Quote *favQ in favoriteQuotes) {
                    if(![allQuotes containsObject:favQ]) {
                        [allQuotes addObject:favQ];
                    }
                }
            }
            
            
        }
        
        //mark the all categories not scheduled and erase timestamp
        
        for (Categories *ca in fetched) {
            ca.scheduleType=@"none";
            for(Quote *q in ca.quote) {
                q.timeStamp = nil;
            }
            
        }
        
        
        NSDateComponents *dayComponent = [[NSDateComponents alloc] init] ;
        dayComponent.day = 1;
        //dayComponent.minute = 1;
        int totalCount = [allQuotes count];
        int maxLocalNotifs = 64;
        if(totalCount>maxLocalNotifs) {
            totalCount=maxLocalNotifs;
        }
        
        Quote *quote=nil;
        
        for (int i=0;i<=totalCount;i++) {
            
            UILocalNotification *localNot= [[UILocalNotification alloc] init];
            [localNot setTimeZone:[NSTimeZone defaultTimeZone]];
            //localNot.applicationIconBadgeNumber=1;
            localNot.repeatInterval = 0;
           // localNot.
            [localNot setAlertAction:@"iReflect"];
            
            localNot.soundName=UILocalNotificationDefaultSoundName;
            
            //get random quote
            if([allQuotes count] != 0 ) {
                unsigned index= (arc4random() % [allQuotes count]);
                quote = allQuotes[index];
                [allQuotes removeObjectAtIndex:index];
            }
            
            if(randomTime) {
                NSDate *newDay;
                
                int randHour   = (arc4random() % (endTimeLocal-startTimeLocal)) + startTimeLocal;
                int randMinute = (arc4random() % 59);
                
                [randComponents setHour: randHour];
                [randComponents setMinute: randMinute];
                [randComponents setDay: ([randComponents day] +1) ];
                
                newDay = [theCalendar dateFromComponents:randComponents];
                
                NSDateFormatter *df =[[NSDateFormatter alloc] init];
                [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                NSString *dateInString = [df stringFromDate:newDay];
                NSLog(@"quote: %@ , random: %@ , int = %d ",quote.quoteEntry, dateInString, randHour);
                
                localNot.fireDate=newDay;
                
                //set the time value in the quote dictionary
                
                if(i!=totalCount){
                    NSString *s= quote.quoteEntry;
                    [localNot setAlertBody:s];
                    quote.timeStamp=newDay;
                    if((favoriteSelected) && [quote.favorite isEqualToNumber:[NSNumber numberWithInt:1]]) {
                        self.favoriteCategory.scheduleType=@"randomTime";
                        //??
                    } else {
                        //mark the category scheduled
                        quote.category.scheduleType=@"randomTime";
                        quote.scheduleStart=[NSNumber numberWithInt:startTimeLocal];
                        quote.scheduleEnd=[NSNumber numberWithInt:endTimeLocal];
                    }
                    [quoteTimes insertObject:newDay atIndex:i];
                    //save context
                    NSError *error;
                    if (![self.managedObjectContext save:&error]) {
                        NSLog(@"couldn't save timestamp: %@", [error localizedDescription]);
                    }
                } else {
                    [localNot setAlertBody:@"There are no more scheduled quotes, reschedule by going to iReflect"];
                }
                
                //if last quote scheduled give user option to reshchedule quotes
                if(i==(totalCount-1)) {
                    [localNot setAlertAction:@"iReflect"];
                    
                }
                
                
                [[UIApplication sharedApplication] scheduleLocalNotification:localNot];
                
                //else if  set time
            } else {
                
                localNot.fireDate=startDate;
                
                
                NSDateFormatter *df2 =[[NSDateFormatter alloc] init];
                [df2 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                NSString *dateInString2 = [df2 stringFromDate:startDate];
                NSLog(@"set time: %@ ",dateInString2);
                
                //set the time value in the quote dictionary
                if(i!=totalCount){
                    
                    NSString *s= quote.quoteEntry;
                    [localNot setAlertBody:s];
                    quote.timeStamp=startDate;
                    [quoteTimes insertObject:startDate atIndex:i];
                    //mark category scheduled
                    if((favoriteSelected) && [quote.favorite isEqualToNumber:[NSNumber numberWithInt:1]]) {
                        self.favoriteCategory.scheduleType=@"setTime";
                    } else {
                        //mark the category scheduled
                        quote.category.scheduleType=@"setTime";
                        quote.scheduleStart=[NSNumber numberWithInt:startTimeLocal];
                        quote.scheduleEnd=[NSNumber numberWithInt:endTimeLocal];
                    }
                    
                    
                    //save context
                    NSError *error;
                    if (![self.managedObjectContext save:&error]) {
                        NSLog(@"couldn't save timestamp: %@", [error localizedDescription]);
                    }
                    
                } else {
                    [localNot setAlertBody:@"There are no more scheduled quotes, reschedule by going to iReflect"];
                    
                }
                
                //if last quote scheduled give user option to reshchedule quotes
                if(i==(totalCount-1)) {
                    [localNot setAlertAction:@"iReflect"];
                    
                }
                
                [[UIApplication sharedApplication] scheduleLocalNotification:localNot];
                
                //add a day to the time
                
                startDate = [theCalendar dateByAddingComponents:dayComponent toDate:startDate options:0];
                
                
            } //else
            
        }//for
        
        self.dailyQuoteLabel.text=[self getDailyQuote ];
        
        [[self tableView] reloadData];
        [self dismissViewControllerAnimated:YES completion:NULL];
        
        
    }
    
}

- (IBAction)cancel:(UIStoryboardSegue *)segue
{
    if ([[segue identifier] isEqualToString:@"CancelInputAddCate"]) {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
    
    if ([[segue identifier] isEqualToString:@"CancelInput"]) {
        [self dismissViewControllerAnimated:YES completion:NULL];
        
    }
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)insertNewObject:(id)sender
//{
//    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
//    NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
//    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
//
//    // If appropriate, configure the new managed object.
//    // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
//    [newManagedObject setValue:[NSDate date] forKey:@"timeStamp"];
//
//    // Save the context.
//    NSError *error = nil;
//    if (![context save:&error]) {
//         // Replace this implementation with code to handle the error appropriately.
//         // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
//        abort();
//    }
//}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.fetchedResultsController sections] count];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
    
    //return [self.quoteList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BasicCell" forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    
    //    Quote *string = [self.quoteList objectAtIndex:indexPath.row];
    //    cell.textLabel.text = string.quoteEntry;
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    //    Quote *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
    //   cell.textLabel.text = object.quoteEntry;
    
    Categories *cate = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    if([cate.name isEqualToString:@"0AFavorites"]){
        //add star image to front
        //    UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"BasicCell" forIndexPath:indexPath];
        ///   UITableViewCell *cell1=[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BasicCell"]];
        cell.textLabel.textAlignment=NSTextAlignmentLeft;
        cell.textLabel.text=@"Favorites";
        cell.imageView.image = [UIImage imageNamed:@"fav_star.png"];
        //cell.imageView.frame = CGRectMake(1,1,30,30);
        
    } else {
        cell.imageView.image=nil;
        cell.textLabel.text = cate.name;
        
    }
    // NSLog(@"catescheduld %@ : %@", cate.name, cate.scheduled);
    
    
    
    if(![cate.scheduleType isEqualToString:@"none"]) {
        cell.detailTextLabel.text=@"Scheduled";
    } else {
        cell.detailTextLabel.text=@" ";
    }
    
    
    
    
}
-(NSArray *)getQuotesFromCategory:(Categories *) currentCategory{
    
    NSArray *allQuotes = [self getCurrentQuoteObjects];
    NSMutableArray *quotesInCate = [[NSMutableArray alloc] init];
    
    for(Quote *q in allQuotes) {
        if([q.category.name isEqual:currentCategory.name]) {
            [quotesInCate addObject:q];
        }
    }
    
    return quotesInCate;
}
-(void)updateScheduledLabel {
    //check if quotes in the category are still scheduled, if not, then set scheduled to fals
    
    // NSSet *quotes = [[NSSet alloc] initWithSet:currentCategory.quote];
    //    NSArray *quotes = [[NSArray alloc]initWithArray:[currentCategory.quote allObjects]];
    //
    //    NSArray *sortedArray = [self sortQuotesByTimeStamp:quotes ascending:YES];
    BOOL foundScheduledQuote = NO;
    
    NSArray *fetchedObjects = [self.fetchedResultsController fetchedObjects];
    //if date has not passed
    for(Categories *c in fetchedObjects) {
        for(Quote *q in c.quote) {
            if(q.timeStamp) {
                if(!([q.timeStamp timeIntervalSinceNow]<0.0))
                {
                    foundScheduledQuote=YES;
                }
            }
        }
        
        if(!foundScheduledQuote) {
            c.scheduleType = @"none";
        } else {
            foundScheduledQuote=NO;
        }
    }
    
    
    return;
    
}



- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return UITableViewCellEditingStyleDelete;
//}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:animated];
}
//- (void) editButtonPushed:(id)sender
//{
//    
//    [self.tableView setEditing:YES animated:YES];
//    
//}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    Categories *cate = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    if([cate.name isEqualToString:@"0AFavorites"]){
        return NO;
    }
    
    return YES;
}

//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
////    SimpleEditableListAppDelegate *controller = (SimpleEditableListAppDelegate *)[[UIApplication sharedApplication] delegate];
////    if (indexPath.row == [controller countOfList]-1) {
////        return UITableViewCellEditingStyleInsert;
////    } else {
//        return UITableViewCellEditingStyleDelete;
//    //}
//}

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
-(NSMutableArray *) createCategoryArray {
    
    NSArray *fetched = [self.fetchedResultsController fetchedObjects] ;
    //NSMutableArray *categoryStringArray=[[NSMutableArray alloc]init];
    
    NSMutableArray *selectedCategoryStrings = [[NSMutableArray alloc] init];
    
    //  [self.selectedCategoryObjects insertObject:@"all" atIndex:0];
    
    [selectedCategoryStrings insertObject:@"all" atIndex:0];
    for (Categories *ca in fetched) {
        
        //only schedule category if there are quotes in it
        if([ca.quote count] || [ca.name isEqual:@"0AFavorites"]){
            [selectedCategoryStrings addObject:ca.name];
            
        }
    }
    return selectedCategoryStrings;
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Categories *object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
        
        //     [[segue destinationViewController] setDetailItem:object];
        iReflectDetailViewController *vc=[segue destinationViewController];
        
        vc.managedObjectContext=[self.fetchedResultsController managedObjectContext];
        vc.cate=object;
        vc.favoriteQuotes=[self addFavorites];
    }
    
    
    if ([[segue identifier] isEqualToString:@"schedule"]) {
        
        UINavigationController *navController = (UINavigationController*)[segue destinationViewController];
        iReflectScheduleQuotesViewController *schedule=(iReflectScheduleQuotesViewController *) [navController topViewController];
        
        
        
        self.selectedCategoryObjects=[self createCategoryArray];
        
        //schedule.categoryArray=[NSArray arrayWithArray:categoryStringArray];
        schedule.categoryArray = [[NSMutableArray alloc] init];
        schedule.selectedCategoryArray=[[NSMutableArray alloc] initWithObjects:@"all", nil];
        
        schedule.categoryArray = self.selectedCategoryObjects;
        
        
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
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Categories" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    //[NSFetchedResultsController deleteCacheWithName:@"UserSearch"];
    
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
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
