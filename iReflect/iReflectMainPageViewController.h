//
//  iReflectMainPageViewController.h
//  iReflect
//
//  Created by Shveta Puri on 5/21/13.
//  Copyright (c) 2013 Shveta Puri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@interface iReflectMainPageViewController : UIViewController<NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (weak, nonatomic) IBOutlet UILabel *currentQuoteLabel;
@property (weak, nonatomic) IBOutlet UIButton *folderButton;
@property (weak, nonatomic) IBOutlet UIButton *scheduleButton;

@end
