//
//  iReflectDetailViewController.h
//  iReflect
//
//  Created by Shveta Puri on 1/4/13.
//  Copyright (c) 2013 Shveta Puri. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iReflectDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
