//
//  AAViewController.m
//  whackamole
//
//  Created by Kyle Oba on 3/8/14.
//  Copyright (c) 2014 AgencyAgency. All rights reserved.
//

#import "AAFieldVC.h"
#import "AAMole.h"

@interface AAFieldVC ()
@property (strong, nonatomic) UIDynamicAnimator *animator;
@property (assign, nonatomic) CGPoint moleDirection;
@end

@implementation AAFieldVC

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Add animator:
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
}

- (void)addMoleAtLocation:(CGPoint)location
{
    CGRect frame = CGRectMake(0.0, 0.0, 20.0, 20.0);
    AAMole *mole = [[AAMole alloc] initWithFrame:frame];
    mole.center = location;
    [self.view addSubview:mole];
    [self flickMole:mole];
}

- (void)flickMole:(AAMole *)mole
{
    UIPushBehavior *flickBehavior = [[UIPushBehavior alloc] initWithItems:@[mole] mode:UIPushBehaviorModeInstantaneous];
    CGPoint moleDirection = [[self valueForKey:@"moleDirection"] CGPointValue];
    flickBehavior.pushDirection = CGVectorMake(moleDirection.x, moleDirection.y);
    
    // Must set magnitude *after* setting direction:
    flickBehavior.magnitude = 0.1f;
    
    [self.animator addBehavior:flickBehavior];
    
    NSLog(@"behaviors added: %i", [[self.animator behaviors] count]);
}

- (IBAction)handleFieldTap:(UITapGestureRecognizer *)sender
{
    NSLog(@"tap");
    [self addMoleAtLocation:[sender locationInView:self.view]];
}


@end
