//
//  DBClient.h
//  GG
//
//  Created by Dmitriy Remezov on 24.08.13.
//  Copyright (c) 2013 Dmitriy Remezov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Films.h"
#import "ViewController.h"
#import "FavViewController.h"

@interface DBClient : NSObject

@property (nonatomic, strong, readonly) NSManagedObjectContext *ManagedObjectContext;

+(DBClient *)sharedInstance;

- (NSMutableArray *) selectFilmFavorite:(BOOL)favorite;
- (BOOL *) insertToDB:(Films *)Film;
- (BOOL *) insertFavoriteToDB:(Films *)Film;
- (Films *) addNewFilmWIthTitle:(NSString *)title;
- (BOOL *) deleteFilm:(Films *)film;
- (BOOL *) reloadData;
- (BOOL *) refreshData;
- (BOOL *) searchElementByTitle:(NSString *)title;


@end
