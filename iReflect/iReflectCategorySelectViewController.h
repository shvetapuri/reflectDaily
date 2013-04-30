//
//  iReflectCategorySelectViewController.h
//  iReflect
//
//  Created by Shveta Puri on 3/31/13.
//  Copyright (c) 2013 Shveta Puri. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iReflectCategorySelectViewController : UITableViewController

@property (strong,nonatomic) NSMutableArray *categoryArray;
@property (strong,nonatomic) NSMutableArray *selectedCategoryArray;


@property (strong,nonatomic) NSMutableDictionary *selectedRows;

@end
