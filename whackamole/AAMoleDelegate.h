//
//  AAMoleDelegate.h
//  whackamole
//
//  Created by Kyle Oba on 3/9/14.
//  Copyright (c) 2014 AgencyAgency. All rights reserved.
//

@class AAMole;

@protocol AAMoleDelegate <NSObject>

- (void)hasBeenWhacked:(AAMole *)mole;

@end