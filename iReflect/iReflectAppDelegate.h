//
//  iReflectAppDelegate.h
//  iReflect
//
//  Created by Shveta Puri on 1/4/13.
//  Copyright (c) 2013 Shveta Puri. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iReflectAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic) BOOL newQuotesScheduled;


- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

-(NSArray *)getDataFromModel:(NSString *)dataType ;

@end
