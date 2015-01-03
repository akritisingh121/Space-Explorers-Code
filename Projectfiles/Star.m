//
//  Star.m
//  newestspacetraveler
//
//  Created by Akriti Singh on 9/2/14.
//
//

#import "Star.h"


CCDirector *director;
int tempSpeed;

@implementation Star

-(id) init{
    director = [CCDirector sharedDirector];
    self.sprite = [CCSprite spriteWithFile:@"star.png"];//load star from file
    self.sprite.position = CGPointMake(arc4random() % (int)director.screenSize.width,
                                       arc4random() % (int)director.screenSize.height*0.77 + (int)director.screenSize.height*0.1);
    self.sprite.scale = 0.2f;
    self.speed = -4;
    return self;
}
//
//CCSprite *explosion;
//int explosionCounter = 0;

-(void) update{
    //NSLog(@"star updated");
    if (self.sprite.position.x < 0){
        [self reset];
    }
    if(CGRectIntersectsRect([self.sprite boundingBox], [self.ship boundingBox])){
        [self reset];
    }
    self.sprite.position = CGPointMake(self.sprite.position.x + self.speed,
                                       self.sprite.position.y);
}

-(void) reset{
    self.sprite.position = CGPointMake(director.screenSize.width,
                                       arc4random() % (int)director.screenSize.height*0.77 + (int)director.screenSize.height*0.1);}

-(void) replay{
    self.speed = -4;
}

-(void) pause{
    // tempSpeed = self.speed;
    self.speed = 0;
}

@end
