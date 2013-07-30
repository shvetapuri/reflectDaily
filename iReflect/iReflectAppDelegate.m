//
//  iReflectAppDelegate.m
//  iReflect
//
//  Created by Shveta Puri on 1/4/13.
//  Copyright (c) 2013 Shveta Puri. All rights reserved.
//

#import "iReflectAppDelegate.h"

#import "iReflectViewController.h"
#import "Quote.h"
#import "Categories.h"

@implementation iReflectAppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (void)customizeAppearance
{
    // Create resizable images
//    UIImage *gradientImage44 = [[UIImage imageNamed:@"tabBar_textured_44"]
//                                resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
//    UIImage *gradientImage32 = [[UIImage imageNamed:@"tabBar_gradient_textured_32"]
//                                resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
//    
//    // Set the background image for *all* UINavigationBars
//    [[UINavigationBar appearance] setBackgroundImage:gradientImage44
//                                       forBarMetrics:UIBarMetricsDefault];
//    [[UINavigationBar appearance] setBackgroundImage:gradientImage32
//                                       forBarMetrics:UIBarMetricsLandscapePhone];
    
    [[UINavigationBar appearance] setTintColor:[UIColor brownColor]];
     [[UIToolbar appearance] setTintColor:[UIColor brownColor]];
   
//    // Customize the title text for *all* UINavigationBars
//    [[UINavigationBar appearance] setTitleTextAttributes:
//     [NSDictionary dictionaryWithObjectsAndKeys:
//      [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0],
//      UITextAttributeTextColor,
//      [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8],
//      UITextAttributeTextShadowColor,
//      [NSValue valueWithUIOffset:UIOffsetMake(0, -1)],
//      UITextAttributeTextShadowOffset,
//      [UIFont fontWithName:@"Arial-Bold" size:0.0],
//      UITextAttributeFont, 
//      nil]];
//    

//    UIImage *button30 = [[UIImage imageNamed:@"button_textured_30"]
//                         resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
//    UIImage *button24 = [[UIImage imageNamed:@"button_textured_24"]
//                         resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
//    [[UIBarButtonItem appearance] setBackgroundImage:button30 forState:UIControlStateNormal
//                                          barMetrics:UIBarMetricsDefault];
//    [[UIBarButtonItem appearance] setBackgroundImage:button24 forState:UIControlStateNormal
//                                          barMetrics:UIBarMetricsLandscapePhone];
    
//    [[UIBarButtonItem appearance] setTitleTextAttributes:
//     [NSDictionary dictionaryWithObjectsAndKeys:
//      [UIColor colorWithRed:220.0/255.0 green:104.0/255.0 blue:1.0/255.0 alpha:1.0],
//      UITextAttributeTextColor,
//      [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0],
//      UITextAttributeTextShadowColor,
//      [NSValue valueWithUIOffset:UIOffsetMake(0, 1)],
//      UITextAttributeTextShadowOffset,
//      [UIFont fontWithName:@"AmericanTypewriter" size:0.0],
//      UITextAttributeFont, 
//      nil] 
//                                                forState:UIControlStateNormal];
    
    
//    UIImage *buttonBack30 = [[UIImage imageNamed:@"button_back_textured_30"]
//                             resizableImageWithCapInsets:UIEdgeInsetsMake(0, 13, 0, 5)];
//    UIImage *buttonBack24 = [[UIImage imageNamed:@"button_back_textured_24"]
//                             resizableImageWithCapInsets:UIEdgeInsetsMake(0, 12, 0, 5)];
//    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:buttonBack30
//                                                      forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:buttonBack24
//                                                      forState:UIControlStateNormal barMetrics:UIBarMetricsLandscapePhone];
    
    
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions

{

    [self customizeAppearance];
    // Override point for customization after application launch.
    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
    iReflectViewController *controller = (iReflectViewController *)navigationController.topViewController;
    navigationController.toolbarHidden=NO;
    
    controller.managedObjectContext = self.managedObjectContext;

    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    if (![defaults objectForKey:@"firstRun"])
    {
        [defaults setObject:[NSDate date] forKey:@"firstRun"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self loadDataFromPropertyList];
    }
    
//    if(self.newQuotesScheduled==1)
//    {
//        [defaults setBool:YES forKey:@"localNotifsScheduled"];
//        
//        [[NSUserDefaults standardUserDefaults] synchronize];
//    } else {
//        [defaults setBool:NO forKey:@"localNotifsScheduled"];
//        
//        [[NSUserDefaults standardUserDefaults] synchronize];
//    }
    
//    UILocalNotification *notification = [launchOptions objectForKey:
//                                         UIApplicationLaunchOptionsLocalNotificationKey];
//    
//    if (notification) {
//        
//        [self.window addSubview:controller.view];
//        [self.window makeKeyAndVisible];
//        
//    }
    
    
    
 //   NSManagedObjectContext *context = [self managedObjectContext];
  
//    Categories *cate = [NSEntityDescription
//                                       insertNewObjectForEntityForName:@"Categories"
//                                       inManagedObjectContext:context];
//    cate.name=@"Wisdom" ;
//    //quote.timeStamp=[NSDate date];
//    Quote *quo = [NSEntityDescription insertNewObjectForEntityForName:@"Quote"
//                                             inManagedObjectContext:context] ;
//    quo.category = cate;
//    quo.quoteEntry = @"to be or not to be";
//    quo.timeStamp = [NSDate date];
//    cate.quote = [[NSSet alloc] initWithObjects:quo, nil];
//
//    
//    Quote *quo2 = [NSEntityDescription insertNewObjectForEntityForName:@"Quote"
//                                               inManagedObjectContext:context] ;
//    quo2.category = cate;
//    quo2.quoteEntry = @"be the change";
//    quo2.timeStamp = [NSDate date];
//    
//    [cate addQuoteObject:quo2];
//    
//    
//    NSError *error;
//    if (![context save:&error]) {
//        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
//    }
//    
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//    NSEntityDescription *entity = [NSEntityDescription
//                                   entityForName:@"Categories" inManagedObjectContext:context];
//    [fetchRequest setEntity:entity];
//    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
//    for (Categories *info in fetchedObjects) {
//    
//        NSLog(@"Category: %@", info.name);
//       // NSLog(@"Quote: %@", info.quote.quoteEntry);
//    }
//    
//    NSFetchRequest *fetchRequest1 = [[NSFetchRequest alloc] init];
//    NSEntityDescription *entity1 = [NSEntityDescription
//                                   entityForName:@"Quote" inManagedObjectContext:context];
//    [fetchRequest1 setEntity:entity1];
//    NSArray *fetchedObjects1 = [context executeFetchRequest:fetchRequest1 error:&error];
//    for (Quote *info in fetchedObjects1) {
//       // NSLog(@"Category: %@", info.name);
//        NSLog(@"Quote: %@", info.quoteEntry);
//    }
   
    
    
    return YES;
}

- (void)loadDataFromPropertyList {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"quoteData" ofType:@"plist"];
    NSArray *items = [NSArray arrayWithContentsOfFile:path];
    
    NSManagedObjectContext *ctx = self.managedObjectContext;
    
    for (NSDictionary *dict in items) {
        Categories *c = [NSEntityDescription insertNewObjectForEntityForName:@"Categories" inManagedObjectContext:ctx];
    
        [c setName:[dict objectForKey:@"name"]];
        
        if([[dict objectForKey:@"quoteEntry"] count]) {
        NSArray *quotes = [dict objectForKey:@"quoteEntry"];
        
        
        for(int i=0; i<(([quotes count]/2)+1);i=i+2) {
            
            Quote *q = [NSEntityDescription insertNewObjectForEntityForName:@"Quote" inManagedObjectContext:ctx];
            NSLog(@"here is i : %d",i);
            q.quoteEntry=[quotes objectAtIndex:i];
            q.author =[quotes objectAtIndex:i+1];
            q.category=c;
            [c addQuoteObject:q];
            
        }
        }
    }
    
    NSError *err = nil;
    [ctx save:&err];
    
    if (err != nil) {
        NSLog(@"error saving managed object context: %@", err);
    }
}

- (void)application:(UIApplication *)application
didReceiveLocalNotification:(UILocalNotification *)notification {
    
    UIApplicationState state = [application applicationState];
    
    //if app is active, and ireflect message arrives, show it
    if (state == UIApplicationStateActive) {
        //[[UIApplication sharedApplication] presentLocalNotificationNow:notification];
        
        UIAlertView *notifAlert = [[UIAlertView alloc]
                              initWithTitle:@"iReflect"
                              message:notification.alertBody
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [notifAlert show];
        
        

    }
    
    self.newQuotesScheduled = 0;
    
    
    int n = [[[UIApplication sharedApplication] scheduledLocalNotifications] count];
    int x = 64 - n;

    
    [self scheduleQuotes:x];

//    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"localNotifsScheduled"];
//    
//    [[NSUserDefaults standardUserDefaults] synchronize];
//    NSLog(@"in didreceive local notif");
    
//    //if app schedules new local notifs then let the user know
//    if(state == UIApplicationStateInactive) {
//    UIAlertView *alert = [[UIAlertView alloc]
//                          initWithTitle:@"Alert"
//                          message: @"New reflections have been added to the schedule"
//                          delegate: nil
//                          cancelButtonTitle:@"OK"
//                          otherButtonTitles:nil];
//    [alert show];
//
//     [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
//    }
    
//    UIApplicationState applicationState = application.applicationState;
//    if (applicationState == UIApplicationStateActive) {
//        [application presentLocalNotificationNow:notification];
  //  }
    
   // [self scheduleQuotes];
}

-(NSArray *)getDataFromModel:(NSString *)dataType {
    NSFetchRequest *fetchRequest1 = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity1 ;
    if([dataType isEqualToString:@"Categories"]) {
        entity1= [NSEntityDescription
                                       entityForName:@"Categories" inManagedObjectContext:self.managedObjectContext];
    } else {
        entity1 = [NSEntityDescription
                                        entityForName:@"Quote" inManagedObjectContext:self.managedObjectContext];
    }
        [fetchRequest1 setEntity:entity1];
    NSError *error;
    
        NSArray *fetchedObjects1 = [self.managedObjectContext executeFetchRequest:fetchRequest1 error:&error];
        
    return fetchedObjects1;
}
-(void)scheduleQuotes:(int)x
{
    //find scheduled categories and scheduled up to x reflections
    //schedule quotes for only scheduled categories
    
    NSArray *data=[self getDataFromModel:@"Categories"];
    int count = 0;
    
            for(Categories *c in data) {
                if(![c.scheduleType isEqualToString:@"none"]){

                    for(Quote *q in c.quote) {
                            if(!(q.timeStamp) || ([q.timeStamp timeIntervalSinceNow]<0.0) )
                            {
                                //if timeinterval has passed or doesn't exist,schedule
                                //quote
                                if(count < x) {
                                    
                                    [self scheduleLocalNotif:c.scheduleType quoteObject:q count:count];
                                    count++;
                                } 
                                
                            
                        }
                }
                
                }
            }
    
    if(count>0){
        self.newQuotesScheduled = 1;
        NSLog(@"marked it true");
    }
    
       
    
}

-(void)scheduleLocalNotif:(NSString *)timeType quoteObject:(Quote*)quoteObject count:(int)count {
    
    NSCalendar *theCalendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [[NSDateComponents alloc]init ];
    
    
    //find last quote scheduled
    NSDate *latestQuote=[self findDateOfLatestQuote];
    
    if(!(latestQuote)) {
        //if couldn't find latest quote then use today's date
        latestQuote=[NSDate date];
    }
    dateComponents=[theCalendar components:(NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:latestQuote];

    
    //Find random Time
    
    if([timeType isEqualToString:@"randomTime"]) {

        [dateComponents setHour: [self calcRandomTime:@"hour" quoteObject:quoteObject]];
        [dateComponents setMinute: [self calcRandomTime:@"minute" quoteObject:quoteObject]];
        
    }
    
    //add a day to the last scheduled quote
    [dateComponents setDay: ([dateComponents day] +1) ];
    
    
    NSDate *newDay = [theCalendar dateFromComponents:dateComponents];
    
    UILocalNotification *localNot= [[UILocalNotification alloc] init];
    [localNot setTimeZone:[NSTimeZone defaultTimeZone]];
    //localNot.applicationIconBadgeNumber=1;
    localNot.repeatInterval = 0;
    [localNot setAlertAction:@"iReflect"];    
    localNot.soundName=UILocalNotificationDefaultSoundName;    
     localNot.fireDate=newDay;
    [localNot setAlertBody:quoteObject.quoteEntry];
    
    NSLog(@"scheduling quote %@",quoteObject.quoteEntry);

    //set variables core data
    quoteObject.timeStamp=newDay;
    
    
     [[UIApplication sharedApplication] scheduleLocalNotification:localNot];
    
    [self saveContext];
    
}

-(NSDate *) findDateOfLatestQuote {
    //find out the latest time scheduled or return today's date if none is found
    NSArray *fetchedQuotes = [self getDataFromModel:@"Quotes"];
    
    
    //sort so that the latest date is first
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timeStamp" ascending:NO] ;
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSArray *sortedArray;
    sortedArray = [fetchedQuotes sortedArrayUsingDescriptors:sortDescriptors];
    

    for(Quote *q in sortedArray) {
       

        if([q.timeStamp timeIntervalSinceNow]>0.0){

             NSLog(@"latest quote : %@",q.quoteEntry);
            return q.timeStamp;
        } }
    
    return 0;

}
-(int )calcRandomTime:(NSString *)type quoteObject:(Quote *) quoteObject {
    
    int randHrMin;
    int start;
    int end;

    if([type isEqualToString:@"hour" ]) {
        
        if(quoteObject.scheduleStart) {
            start = [quoteObject.scheduleStart intValue];
            end =[quoteObject.scheduleEnd intValue];
        } else {
            start = 12;
            end = 18;
        }
        randHrMin  = (arc4random() % (end-start)) + start; 
    } else {
        randHrMin = (arc4random() % 59);
    }
    
    return randHrMin;
   }

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    application.applicationIconBadgeNumber = 0;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    
    [self saveContext];
}


- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"iReflect" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"iReflect.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
