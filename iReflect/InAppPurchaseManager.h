//
//  InAppPurchaseManager.h
//  iReflect
//
//  Created by Shveta Puri on 7/30/13.
//  Copyright (c) 2013 Shveta Puri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

#define kInAppPurchaseManagerProductsFetchedNotification @"kInAppPurchaseManagerProductsFetchedNotification"

@interface InAppPurchaseManager : NSObject<SKProductsRequestDelegate>
{
    SKProduct *proUpgradeProduct;
    SKProductsRequest *productsRequest;
}
@end
