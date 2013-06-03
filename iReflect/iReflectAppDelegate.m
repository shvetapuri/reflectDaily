//
//  iReflectAppDelegate.m
//  iReflect
//
//  Created by Shveta Puri on 1/4/13.
//  Copyright (c) 2013 Shveta Puri. All rights reserved.
//

#import "iReflectAppDelegate.h"

#import "iReflectMasterViewController.h"
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
    
   // [[UINavigationBar appearance] setTintColor:[UIColor brownColor]];
     
    
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
    iReflectMasterViewController *controller = (iReflectMasterViewController *)navigationController.topViewController;
    navigationController.toolbarHidden=NO;
    
    controller.managedObjectContext = self.managedObjectContext;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults objectForKey:@"firstRun"])
    {
        [defaults setObject:[NSDate date] forKey:@"firstRun"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self loadDataFromPropertyList];
    }

    
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
        
        
        for(int i=0; i<=(([quotes count]/2)+1);i=i+2) {
            
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

//    UIApplicationState applicationState = application.applicationState;
//    if (applicationState == UIApplicationStateActive) {
//        [application presentLocalNotificationNow:notification];
  //  }
    
   // [self scheduleQuotes];
}

-(void)scheduleQuotes
{
    
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
