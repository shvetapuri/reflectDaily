//
//  iReflectMainPageViewController.m
//  iReflect
//
//  Created by Shveta Puri on 5/21/13.
//  Copyright (c) 2013 Shveta Puri. All rights reserved.
//

#import "iReflectMainPageViewController.h"
#import "iReflectMasterViewController.h"
@interface iReflectMainPageViewController ()

@end

@implementation iReflectMainPageViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)goToFolders {
    iReflectMasterViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"masterView"];
    [self.navigationController pushViewController:view animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
