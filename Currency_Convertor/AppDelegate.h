//
//  AppDelegate.h
//  Currency_Convertor
//
//  Created by Sermandurai Subbiah on 12/07/18.
//  Copyright © 2018 Sermandurai Subbiah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

