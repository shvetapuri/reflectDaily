//
//  IAPHelper.h
//  iReflect
//
//  Created by Shveta Puri on 8/26/13.
//  Copyright (c) 2013 Shveta Puri. All rights reserved.
//
#import <StoreKit/StoreKit.h>
#import "VerificationController.h"
UIKIT_EXTERN NSString *const IAPHelperProductPurchasedNotification;

typedef void (^RequestProductsCompletionHandler)(BOOL success, NSArray * products);

@interface IAPHelper : NSObject

- (id)initWithProductIdentifiers:(NSSet *)productIdentifiers;
- (void)requestProductsWithCompletionHandler:(RequestProductsCompletionHandler)completionHandler;

- (void)buyProduct:(SKProduct *)product;
- (BOOL)productPurchased:(NSString *)productIdentifier;
- (void)restoreCompletedTransactions;


@end
