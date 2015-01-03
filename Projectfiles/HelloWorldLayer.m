/*
 * Kobold2D™ --- http://www.kobold2d.org
 *
 * Copyright (c) 2010-2011 Steffen Itterheim. 
 * Released under MIT License in Germany (LICENSE-Kobold2D.txt).
 */

#import "HelloWorldLayer.h"
#import "Asteroid.h"
#import "Star.h"
#import "RainbowStar.h"
#import "WhiteStars.h"
#import "SimpleAudioEngine.h"
#import "Life.h"
#import "Slows.h"
#import "Speeds.h"
#import "ModalAlert.h"

@interface HelloWorldLayer (PrivateMethods)
@end

@implementation HelloWorldLayer

CCSprite *ship;
CCSprite *explosion;
NSMutableArray *asteroids;
NSMutableArray *stars;
NSMutableArray *bonusStars;
NSMutableArray *whiteStars;
NSMutableArray *lives;
NSMutableArray *slowArrows;
NSMutableArray *fastArrows;
NSMutableArray *bullets;
CCDirector *director;
int lifeCount = 5;
int points = 0;
CCLabelTTF *livesLabel;
CCLabelTTF *pointsLabel;
BOOL *gameOver = false;
BOOL *timedVersion = false;
NSTimer *countdownTimer;
NSTimer *gameTimer;
int secondsCount = 5;
int gameSecondsCount = 60;
CCLabelTTF *timerLabel;
CCLabelTTF *gameTimerLabel;
CCLabelTTF *pauseLabel;
CCLabelTTF *nameLabel;
CCMenu *playMenu;
CCMenu *quitMenu;
CCMenu *pauseMenu;
CCMenu *startMenu;
CCMenu *mainMenu;
CCMenu *soundOnMenu;
CCMenu *soundOffMenu;
CCMenu *timedMenu;
BOOL paused = false;
int livesRandomNum;
int slowArrowRandomNum;
int fastArrowRandomNum;
int numAsteroids = 3;
int numAsteroidsOnScreen = 3;
bool inc1 = false;
bool inc2 = false;
bool inc3 = false;
bool inc4 = false;
bool inc5 = false;
bool inc6 = false;
bool inc7 = false;
bool pauseLabelPresent = false;
int ticksWhenSlowArrowHit = 0;
int ticksWhenFastArrowHit = 0;
int tick = 0;
CCSprite *bg;
bool *gotFastArrow = false;
bool *gotSlowArrow = false;
bool *wantSound = true;
KKInput *input;
float calibrationY = 0;
float calibrationX = 0;
int direction = 1;
int shipSpeed = 30;
int shootCounter = 46;
int shootCount = 10;


-(id)init
{
	if ((self = [super init]))
	{
		glClearColor(0.1f, 0.1f, 0.3f, 1.0f); //changes background color

        director = [CCDirector sharedDirector];
        [self addBackground];
        [self addGameTitle];
        [self addStartButton];
        [self addTimedButton];
        [self addSoundOffButton];
        
        
	}
	return self;
}

-(void)update:(ccTime)delta{
    
    if (gameOver)return;
    if (paused) return;
    
    tick++;
    input = [KKInput sharedInput];
    
    if (tick < 10) {
        input = [KKInput sharedInput];
        calibrationY = input.acceleration.y;
        calibrationX = input.acceleration.x;
        ship.position = director.screenCenter;
    }
    
    float offsetx = calibrationX * -shipSpeed;
    float offsety = calibrationY * -shipSpeed;
    
    float movementx = (input.acceleration.smoothedX * shipSpeed) + offsetx;
    float movementy = (input.acceleration.smoothedY * shipSpeed) + offsety;
    
    //location of the ship
    if (direction == 1){
    ship.position = CGPointMake(ship.position.x + movementx, ship.position.y + movementy);
    }
    else if (direction == -1){
        ship.position = CGPointMake(ship.position.x - movementx, ship.position.y - movementy);
    }
    if(ship.position.y < (int)director.screenSize.height*0.1)
        ship.position = CGPointMake(ship.position.x, (int)director.screenSize.height*0.1);
    
    if(ship.position.y > director.screenSize.height*0.9)
        ship.position = CGPointMake(ship.position.x, director.screenSize.height*0.9);
    
    if(ship.position.x < 0)
        ship.position = CGPointMake(0, ship.position.y);
    
    if(ship.position.x > director.screenSize.width)
        ship.position = CGPointMake(director.screenSize.width, ship.position.y);

    //bullets
    if (input.touchesAvailable && [input anyTouchLocation].y > director.screenSize.height*0.1 && [input anyTouchLocation].y < director.screenSize.height*0.90 && [bullets count] < 4 && tick > 70){
        if(shootCounter+2 > shootCount){
            shootCounter = 0;
            CCSprite *bullet = [self blankSpriteWithSize: CGSizeMake(13, 3)];
            bullet.position = CGPointMake(ship.position.x + [ship boundingBox].size.width, ship.position.y);
            bullet.color = ccc3(255, 241, 166);
            [bullets addObject:bullet];
            [self addChild:bullet z:100];
            float pitch = CCRANDOM_MINUS1_1() * 0.1f + 0.9f;
            if(wantSound){
                [[SimpleAudioEngine sharedEngine] playEffect:@"explo2.wav" pitch:pitch pan:0 gain:1];
            }
        }
                //ship.position = CGPointMake([input anyTouchLocation].x, ship.position.y);
    } else shootCounter = 46;
        
    //increments the number of asteroids relative to the time passed- +1 asteroid every something seconds
    if(tick == 1500 && inc1 == false){
        inc1 = true;
        [self addAsteroid];
        numAsteroidsOnScreen++;
        NSLog(@"numasteroids: %d", numAsteroidsOnScreen);
    }
    else if(tick == 3000 && inc2 == false){
        inc2 = true;
        [self addAsteroid];
        numAsteroidsOnScreen++;
        NSLog(@"numasteroids: %d", numAsteroidsOnScreen);
    }
    else if(tick == 4500 && inc3 == false) {
        inc3 = true;
        [self addAsteroid];
        numAsteroidsOnScreen++;
        NSLog(@"numasteroids: %d", numAsteroidsOnScreen);
    }
    else if(tick == 6000 && inc4 == false){
        inc4 = true;
        [self addAsteroid];
        numAsteroidsOnScreen++;
        NSLog(@"numasteroids: %d", numAsteroidsOnScreen);
    }
    else if(tick == 7500 && inc5 == false){
        inc5 = true;
        [self addAsteroid];
        numAsteroidsOnScreen++;
        NSLog(@"numasteroids: %d", numAsteroidsOnScreen);
    }
    else if(tick == 9000 && inc6 == false){
        inc6 = true;
        [self addAsteroid];
        numAsteroidsOnScreen++;
        NSLog(@"numasteroids: %d", numAsteroidsOnScreen);
    }
    else if(tick == 10500 && inc7 == false){
        inc7 = true;
        [self addAsteroid];
        numAsteroidsOnScreen++;
        NSLog(@"numasteroids: %d", numAsteroidsOnScreen);
    }
    
    //bullets + getting rid of them
    NSArray *bulletsTemp = [NSArray arrayWithArray:bullets];

    for(int i = 0; i < [bulletsTemp count]; i++){
        CCSprite *bullet = bulletsTemp[i];
        bullet.position = CGPointMake(bullet.position.x + 2, bullet.position.y);
        if (bullet.position.y > director.screenSize.height) {
            [bullets removeObject:bullet];
            [self removeChild:bullet];
        }
    }
        
    //if not using accelerometer and moving ship with touch instead
    //input = [KKInput sharedInput];
    //if(input.touchesAvailable){
    //   ship.position = input.anyTouchLocation;
    //}
    
    bulletsTemp = [NSArray arrayWithArray:bullets];

    //asteroids configuration
    for(int i = 0; i <[asteroids count]; i++){
        Asteroid *asteroid = asteroids [i];
            [asteroid replay];
            if(CGRectIntersectsRect([asteroid.sprite boundingBox], [ship boundingBox])){
                if(wantSound){
                    [[SimpleAudioEngine sharedEngine] playEffect:@"crash.wav" pitch:CCRANDOM_MINUS1_1() * 0.1f + 0.9f pan:0 gain:1.0f];
                }
                lifeCount--;
                [livesLabel setString:[NSString stringWithFormat:@"Lives: %d", lifeCount]];
                if (timedVersion){
                    gameSecondsCount = gameSecondsCount - 2;
                    if (gameSecondsCount < 6){
                        gameTimerLabel.color = ccRED;
                    }
                    if (gameSecondsCount >= 6){
                        gameTimerLabel.color = ccGREEN;
                    }
                }
                if (lifeCount < 2){
                    livesLabel.color = ccRED;
                }
                if (lifeCount >= 2){
                    livesLabel.color = ccGREEN;
                }
                if(lifeCount == 0 && !timedVersion){
                    [self endGame];
                    [asteroid removeExplosion];
                }
            }
            for (int i = 0; i < [bullets count]; i++) {
                CCSprite *bullet = bullets[i];
                if(CGRectIntersectsRect([asteroid.sprite boundingBox], [bullet boundingBox])){
                    if(wantSound){
                        [[SimpleAudioEngine sharedEngine] playEffect:@"boom.mp3" pitch:CCRANDOM_MINUS1_1() * 0.1f + 0.9f pan:0 gain:1.0f];
                    }
                    [bullets removeObject:bullet];
                    [self removeChild:bullet];
                    [asteroid reset];
                }
                if(bullet.position.x > director.screenSize.width){
                    [bullets removeObject:bullet];
                    [self removeChild:bullet];
                }
            }
        [asteroid update];
    }
        
    //lives configuration
    
    if (!timedVersion) {
        if (tick > livesRandomNum && tick < livesRandomNum + 20){
        //if (powerUpSecondsCount == livesRandomNum){
            [self addLife];
            NSLog(@"added");
        }
        for(int i = 0; i <[lives count]; i++){
            Life *heart = lives [i];
            [heart replay];
            if(CGRectIntersectsRect([heart.sprite boundingBox], [ship boundingBox])){
                if(wantSound){
                    [[SimpleAudioEngine sharedEngine] playEffect:@"success.wav" pitch:1 pan:0 gain:0.5];
                }
                [lives removeObject:heart];
                [self removeChild:heart.sprite cleanup:true];
                lifeCount++;
                [livesLabel setString:[NSString stringWithFormat:@"Lives: %d", lifeCount]];
            }
            [heart update];
        }
    }
    
    //slow arrows configuration
    
    if (tick > slowArrowRandomNum && tick < slowArrowRandomNum + 25){
        [self addSlowArrow];
    }
    
    for(int i = 0; i <[slowArrows count]; i++){
        Slows *slowArrow = slowArrows [i];
        [slowArrow replay];
        if(CGRectIntersectsRect([slowArrow.sprite boundingBox], [ship boundingBox])){
            if(wantSound){
                [[SimpleAudioEngine sharedEngine] playEffect:@"success.wav" pitch:2 pan:0 gain:0.5];
            }
            gotFastArrow = false;
            if (gotSlowArrow == false){
                NSLog(@"slow arrow hit");
                gotSlowArrow = true;
            }
            ticksWhenSlowArrowHit = tick;
            for(int i = 0; i <[asteroids count]; i++){
                Asteroid *asteroidVar = asteroids [i];
                [asteroidVar slowDown];
            }
            [slowArrows removeObject:slowArrow];
            [self removeChild:slowArrow.sprite cleanup:true];
        }
        [slowArrow update];
    }
    
    if(ticksWhenSlowArrowHit != 0 && tick >= ticksWhenSlowArrowHit + 300){
        if (gotSlowArrow == true){
            [self normalizeSpeeds];
            gotSlowArrow = false;
            ticksWhenSlowArrowHit = 0;
        }
    }
    
    // fast arrow config
    
    if (tick > fastArrowRandomNum && tick < fastArrowRandomNum + 20){
        [self addFastArrow];
    }
    
    for(int i = 0; i <[fastArrows count]; i++){
        Speeds *fastArrow = fastArrows [i];
        [fastArrow replay];
        if(CGRectIntersectsRect([fastArrow.sprite boundingBox], [ship boundingBox])){
            if(wantSound){
                [[SimpleAudioEngine sharedEngine] playEffect:@"fail.wav" pitch:1 pan:0 gain:1.5];
            }
            gotSlowArrow = false;
            NSLog(@"fast arrow hit");
            if (gotFastArrow == false){
                gotFastArrow = true;
            }
            ticksWhenFastArrowHit = tick;
            for(int i = 0; i <[asteroids count]; i++){
                Asteroid *asteroidVar = asteroids [i];
                [asteroidVar speedUp];
            }
            [fastArrows removeObject:fastArrow];
            [self removeChild:fastArrow.sprite cleanup:true];
        }
        [fastArrow update];
    }
        
    if(ticksWhenFastArrowHit != 0 && tick > ticksWhenFastArrowHit + 300){
        if (gotFastArrow ==true) {
            [self normalizeSpeeds];
            gotFastArrow = false;
        }
        ticksWhenFastArrowHit = 0;
    }
    
    //stars config
    for(int i = 0; i <[stars count]; i++){
        Star *star = stars [i];
        [star replay];
        if(CGRectIntersectsRect([star.sprite boundingBox], [ship boundingBox])){
            points++;
            if(wantSound){
                [[SimpleAudioEngine sharedEngine] playEffect:@"chimecut.mp3" pitch:1 pan:0 gain:1];
            }
            [pointsLabel setString:[NSString stringWithFormat:@"Points: %d", points]];
        }
        [star update];
    }
        
    //rainbow stars config
    for(int i = 0; i <[bonusStars count]; i++){
        RainbowStar *bonusStar = bonusStars [i];
        [bonusStar replay];
        if(CGRectIntersectsRect([bonusStar.sprite boundingBox], [ship boundingBox])){
            points+=5;
            if(wantSound){
                [[SimpleAudioEngine sharedEngine] playEffect:@"chimecut.mp3" pitch:2 pan:0 gain:0.5];
            }
            [pointsLabel setString:[NSString stringWithFormat:@"Points: %d", points]];
        }
        [bonusStar update];
    }
        
    //white stars config
    for(int i = 0; i <[whiteStars count]; i++){
        WhiteStars *whiteStar = whiteStars [i];
        [whiteStar update];
    }
}

- (void)endGame{
    if(wantSound){
        [[SimpleAudioEngine sharedEngine] playEffect:@"boo.wav" pitch:1 pan:0 gain:1];
    }
    gameOver = true;
    [self removeAllChildren];
    [stars removeAllObjects];
    [asteroids removeAllObjects];
    [bonusStars removeAllObjects];
    [whiteStars removeAllObjects];
    [bullets removeAllObjects];
    
    [gameTimer invalidate];
    gameTimer = nil;
    
    [countdownTimer invalidate];
    countdownTimer = nil;

    [self addBackground];
    [self addPointsLabel];
    [self addGameOverLabel];
    [self addMainMenuButton];
    [self addReplayButton];
    
    points = 0;
}

- (void)replayButtonTapped:(id)sender {
    if(wantSound){
        [[SimpleAudioEngine sharedEngine] playEffect:@"pop.wav" pitch:1 pan:0 gain:1];
    }
    
    [gameTimer invalidate];
    gameTimer = nil;
    
    [countdownTimer invalidate];
    countdownTimer = nil;
    
    tick = 0;
    gameOver = false;
    numAsteroids = 3;
    numAsteroidsOnScreen = 3;
    secondsCount = 5;
    gameSecondsCount = 60;
    paused = false;
    [self unscheduleUpdate];
    self.removeAllChildren;

    [self addBackground];
    [self addTimerLabel];
    [self addPointsLabel];
    [self addCalibrationButton];
    [self addInvertButton];
    [self addPauseButton];
    [self addQuitButton];
    [self addBars];
    if (!timedVersion)[self addLivesLabel];
    else if (timedVersion)[self addGameTimerLabel];
    [self addShip];
    [self setTimer];
    [self scheduleUpdate]; //screen updates 30 times per second to make it seem like the object is really moving
}

-(void)soundOffButtonTapped:(id)sender{
    if(wantSound){
        [[SimpleAudioEngine sharedEngine] playEffect:@"pop.wav" pitch:1 pan:0 gain:1];
    }
    wantSound = false;
    soundOffMenu.removeAllChildren;
    [self addSoundOnButton];
}

-(void)soundOnButtonTapped:(id)sender{
    if(wantSound){
        [[SimpleAudioEngine sharedEngine] playEffect:@"pop.wav" pitch:1 pan:0 gain:1];
    }
    wantSound = true;
    soundOnMenu.removeAllChildren;
    [self addSoundOffButton];
}

-(void)timedButtonTapped:(id)sender{
    if(wantSound){
        [[SimpleAudioEngine sharedEngine] playEffect:@"pop.wav" pitch:1 pan:0 gain:1];
    }
    timedVersion = true;
    tick = 0;
    secondsCount = 5;
    gameOver = false;
    paused = false;
    [self unscheduleUpdate];
    [self removeChild:nameLabel];
    [self removeChild:startMenu];
    [self removeChild:timedMenu];
    if(wantSound){
        [self removeChild:soundOffMenu];
    }
    else if(!wantSound){
        [self removeChild:soundOnMenu];
    }
    
    [gameTimer invalidate];
    gameTimer = nil;
    
    [countdownTimer invalidate];
    countdownTimer = nil;
    
    [KKInput sharedInput].accelerometerActive = YES;
    [KKInput sharedInput].acceleration.filteringFactor = 0.2f;
  
    //initializing the arrays of objects
    asteroids = [[NSMutableArray alloc] init];
    stars = [[NSMutableArray alloc] init];
    bonusStars = [[NSMutableArray alloc] init];
    whiteStars = [[NSMutableArray alloc] init];
    bullets = [[NSMutableArray alloc] init];
    slowArrows = [[NSMutableArray alloc] init];
    fastArrows = [[NSMutableArray alloc] init];
    
    //preloads audio
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"boom.mp3"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"click.mp3"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"explo2.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"crash.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"blop.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"ting.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"bleep.wav"];
    
    slowArrowRandomNum = arc4random() % 500 + 500;
    NSLog(@"slow arrow random number: %d", slowArrowRandomNum);
    
    fastArrowRandomNum = arc4random() % 500 + 500;
    NSLog(@"fast arrow random number: %d", fastArrowRandomNum);
    
    [self addShip];
    [self addTimerLabel];
    [self addBars];
    [self addGameTimerLabel];
    [self addPointsLabel];
    [self addCalibrationButton];
    [self addInvertButton];
    [self addPauseButton];
    [self addQuitButton];
    [self setTimer];
    [self normalizeSpeeds];

    [self scheduleUpdate]; //screen updates 30 times per second to make it seem like the object is really moving
}

-(void)playButtonTapped:(id)sender{
    if(wantSound){
        [[SimpleAudioEngine sharedEngine] playEffect:@"pop.wav" pitch:1 pan:0 gain:1];
    }
    NSLog(@"play button tapped");
    paused = false;
    [self removeChild:pauseLabel];
    pauseLabelPresent = false;
    [self addPauseButton];
    playMenu.removeAllChildren;
}

-(void)pauseButtonTapped:(id)sender{
    if(wantSound){
        [[SimpleAudioEngine sharedEngine] playEffect:@"pop.wav" pitch:1 pan:0 gain:1];
    }
    paused = true;
    NSLog(@"paused button tapped");
    pauseLabel = [CCLabelTTF labelWithString:@"PAUSED" fontName:@"Squarefont" fontSize:50];
    pauseLabel.position = CGPointMake((int)director.screenSize.width/2, (int)director.screenSize.height/2);
    pauseLabel.color = ccGREEN;
    [self addChild:pauseLabel z:111];
    pauseLabelPresent = true;
    pauseMenu.removeAllChildren;
    [self addPlayButton];
}

-(void)quitButtonTapped:(id)sender{
    if(wantSound){
        [[SimpleAudioEngine sharedEngine] playEffect:@"pop.wav" pitch:1 pan:0 gain:1];
    }
    paused = true;
    if (pauseLabelPresent){
        [self removeChild:pauseLabel];
    }
    playMenu.removeAllChildren;
    [self addPauseButton];
    [ModalAlert Ask: @"Are you sure you want to quit the game?"
            onLayer:self // this is usually the current scene layer
           yesBlock: ^{
               if(wantSound){
                   [[SimpleAudioEngine sharedEngine] playEffect:@"pop.wav" pitch:1 pan:0 gain:1];
               }
               gameOver = true;
               [self endGame];
           }
            noBlock: ^{
                if(wantSound){
                    [[SimpleAudioEngine sharedEngine] playEffect:@"pop.wav" pitch:1 pan:0 gain:1];
                }
                paused = false;
                return;
            }];
}

-(void)mainMenuButtonTapped:(id)sender{
    if(wantSound){
        [[SimpleAudioEngine sharedEngine] playEffect:@"pop.wav" pitch:1 pan:0 gain:1];
    }
    timedVersion = false;
    
    [self removeAllChildren];
    
    [self addBackground];
    [self addGameTitle];
    [self addTimedButton];
    [self addStartButton];
    if(wantSound){
        [self addSoundOffButton];
    }
    else if(!wantSound){
        [self addSoundOnButton];
    }
}

-(void)startButtonTapped:(id)sender{
    if(wantSound){
        [[SimpleAudioEngine sharedEngine] playEffect:@"pop.wav" pitch:1 pan:0 gain:1];
    }
    tick = 0;
    gameOver = false;
    paused = false;
    timedVersion = false;
    secondsCount = 5;
    [self unscheduleUpdate];
    [self removeChild:nameLabel];
    [self removeChild:startMenu];
    [self removeChild:timedMenu];
    if(wantSound){
        [self removeChild:soundOffMenu];
    }
    else if(!wantSound){
        [self removeChild:soundOnMenu];
    }
    
    [gameTimer invalidate];
    gameTimer = nil;
    
    [countdownTimer invalidate];
    countdownTimer = nil;
    
    [KKInput sharedInput].accelerometerActive = YES;
    [KKInput sharedInput].acceleration.filteringFactor = 0.2f;
    
    //initializing the arrays of objects
    asteroids = [[NSMutableArray alloc] init];
    stars = [[NSMutableArray alloc] init];
    bonusStars = [[NSMutableArray alloc] init];
    whiteStars = [[NSMutableArray alloc] init];
    bullets = [[NSMutableArray alloc] init];
    slowArrows = [[NSMutableArray alloc] init];
    lives = [[NSMutableArray alloc] init];
    fastArrows = [[NSMutableArray alloc] init];
    
    //preloads audio
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"boom.mp3"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"explo2.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"crash.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"blop.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"ting.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"bleep.wav"];
    
    //intiial randomnumbers
    livesRandomNum = arc4random() % 500 + 500;
    NSLog(@"life random number: %d", livesRandomNum);
    
    slowArrowRandomNum = arc4random() % 500 + 500;
    NSLog(@"slow arrow random number: %d", slowArrowRandomNum);
    
    fastArrowRandomNum = arc4random() % 500 + 500;
    NSLog(@"fast arrow random number: %d", fastArrowRandomNum);
    
    
    
    [self addShip];
    [self addTimerLabel];
    [self addBars];
    [self addLivesLabel];
    [self addPointsLabel];
    [self addCalibrationButton];
    [self addInvertButton];
    [self addPauseButton];
    [self addQuitButton];
    [self setTimer];
    [self normalizeSpeeds];
    
    [self scheduleUpdate]; //screen updates 30 times per second to make it seem like the object is really moving
}

-(void) loadGame{
    paused = false;
    secondsCount = 5;
    gameSecondsCount = 60;
    lifeCount = 5;
    points = 0;
    
    if (!timedVersion){
        livesRandomNum = arc4random() % 500 + 300;
        NSLog(@"life random number: %d", livesRandomNum);
    }
    
    slowArrowRandomNum = arc4random() % 500 + 300;
    NSLog(@"slow arrow random number: %d", slowArrowRandomNum);
    
    fastArrowRandomNum = arc4random() % 500 + 300;
    NSLog(@"fast arrow random number: %d", fastArrowRandomNum);
    
    //adds diff objects
    for(int i = 0; i < numAsteroids; i++){
        Asteroid *asteroid = [[Asteroid alloc] init];
        asteroid.ship = ship;
        asteroid.layer = self;
        [self addChild:asteroid.sprite z:100];//add asteroid to screen
        [asteroids addObject:asteroid];//adds asteroid object to the array asteroids
    }
    
    [self normalizeSpeeds];
    
    for(int i = 0; i < 5; i++){
        Star *star = [[Star alloc] init];
        star.ship = ship;
        star.layer = self;
        [self addChild:star.sprite z:100];//add asteroid to screen
        [stars addObject:star];//adds asteroid object to the array asteroids
    }
    
    for(int i = 0; i < 1; i++){
        RainbowStar *bonusStar = [[RainbowStar alloc] init];
        bonusStar.ship = ship;
        bonusStar.layer = self;
        [self addChild:bonusStar.sprite z:100];//add asteroid to screen
        [bonusStars addObject:bonusStar];//adds asteroid object to the array asteroids
    }
    
    for(int i = 0; i < 25; i++){
        WhiteStars *whiteStar = [[WhiteStars alloc] init];
        //whiteStar.ship = ship;
        whiteStar.layer = self;
        [self addChild:whiteStar.sprite z:100];//add asteroid to screen
        [whiteStars addObject:whiteStar];//adds asteroid object to the array asteroids
    }
}

- (CCSprite*)blankSpriteWithSize:(CGSize)size{
    CCSprite *sprite = [CCSprite node];
    GLubyte *buffer = malloc(sizeof(GLubyte)*4);
    for (int i=0;i<4;i++) {buffer[i]=255;}
    CCTexture2D *tex = [[CCTexture2D alloc] initWithData:buffer pixelFormat:kCCTexture2DPixelFormat_RGB5A1 pixelsWide:1 pixelsHigh:1 contentSize:size];
    [sprite setTexture:tex];
    [sprite setTextureRect:CGRectMake(0, 0, size.width, size.height)];
    free(buffer);
    return sprite;
}

-(void)timerRun{
    if(!paused){
        secondsCount = secondsCount - 1;
        if (wantSound){
            [[SimpleAudioEngine sharedEngine] playEffect:@"click.mp3" pitch:1 pan:0 gain:1];
        }
        if (secondsCount == 0) {
            [countdownTimer invalidate];
            countdownTimer = nil;
            [self removeChild:timerLabel];
            [self loadGame];
            if (timedVersion) [self setGameTimer];
        }
        [timerLabel setString:[NSString stringWithFormat:@"%d", secondsCount]];
    }
}

-(void)setTimer{
    countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerRun) userInfo:nil repeats:YES];
}

-(void)addTimerLabel{
    timerLabel = [CCLabelTTF labelWithString:@"5"
                                    fontName:@"Squarefont"
                                    fontSize:500];
    timerLabel.position = director.screenCenter;
    timerLabel.color = ccWHITE;
    timerLabel.opacity = 220;
    [self addChild:timerLabel z:10];
}

- (void)addAsteroid{
    Asteroid *asteroid = [[Asteroid alloc] init];
    asteroid.ship = ship;
    asteroid.layer = self;
    [self addChild:asteroid.sprite z:100];//add asteroid to screen
    [asteroids addObject:asteroid];
}

-(void)addLife{
    Life *lifeVar= [[Life alloc] init];//initializes the life array with one life
    lifeVar.ship = ship;
    lifeVar.layer = self;
    [self addChild:lifeVar.sprite z:100];//add life to screen
    [lives addObject:lifeVar];
    livesRandomNum = livesRandomNum + arc4random() % 1000 + 200;
    NSLog(@"New life randomNum: %d", livesRandomNum);
}

-(void)addSlowArrow{
    Slows *slowVar= [[Slows alloc] init];//initializes the life array with one life
    slowVar.ship = ship;
    slowVar.layer = self;
    [self addChild:slowVar.sprite z:100];//add life to screen
    [slowArrows addObject:slowVar];
    slowArrowRandomNum = slowArrowRandomNum + arc4random() % 1500 + 200;
    NSLog(@"New slow arrow randomNum: %d", slowArrowRandomNum);
}

-(void)addFastArrow{
    Speeds *fastVar= [[Speeds alloc] init];//initializes the life array with one life
    fastVar.ship = ship;
    fastVar.layer = self;
    [self addChild:fastVar.sprite z:100];//add life to screen
    [fastArrows addObject:fastVar];
    fastArrowRandomNum = fastArrowRandomNum + arc4random() % 1500 + 200;
    NSLog(@"New fast arrow randomNum: %d", slowArrowRandomNum);
}

-(void)normalizeSpeeds{
    for(int i = 0; i <[asteroids count]; i++){
        Asteroid *asteroidVar = asteroids [i];
        [asteroidVar goToNormal];
    }
}

-(void)addPauseButton{
    CCMenuItem *pauseMenuItem = [CCMenuItemImage
                     itemFromNormalImage:@"pause.png" selectedImage:@"pause.png"
                     target:self selector:@selector(pauseButtonTapped:)];
    pauseMenuItem.position = CGPointMake(0, 0);
    pauseMenuItem.scale = 0.1;
    pauseMenu = [CCMenu menuWithItems:pauseMenuItem, nil];
    pauseMenu.position = CGPointMake(director.screenCenter.x-25, 25);
    [self addChild:pauseMenu z:101];
}

-(void)addStartButton{
    CCMenuItem *startMenuItem = [CCMenuItemImage
                    itemFromNormalImage:@"classic.png" selectedImage:@"classicselected.png"
                    target:self selector:@selector(startButtonTapped:)];
    startMenuItem.position = CGPointMake(0, 0);
    startMenuItem.scale = 1;
    startMenu = [CCMenu menuWithItems:startMenuItem, nil];
    startMenu.position = CGPointMake(director.screenCenter.x, director.screenCenter.y*0.90);
    [self addChild:startMenu z:101];
}

-(void)addReplayButton{
    CCMenuItem *replayMenuItem = [CCMenuItemImage
                                  itemFromNormalImage:@"replaybutton.png" selectedImage:@"replayselected.png"
                                  target:self selector:@selector(replayButtonTapped:)];
    replayMenuItem.position = CGPointMake(0, 0);
    replayMenuItem.scale = 1;
    CCMenu *replayMenu = [CCMenu menuWithItems:replayMenuItem, nil];
    replayMenu.position = CGPointMake(director.screenCenter.x, director.screenCenter.y*0.8);
    [self addChild:replayMenu z:101];
}

-(void)addMainMenuButton{
    CCMenuItem *mainMenuItem = [CCMenuItemImage
                                 itemFromNormalImage:@"mainmenu.png" selectedImage:@"menuselected.png"
                                 target:self selector:@selector(mainMenuButtonTapped:)];
    mainMenuItem.position = CGPointMake(0, 0);
    mainMenuItem.scale = 1;
    mainMenu = [CCMenu menuWithItems:mainMenuItem, nil];
    mainMenu.position = CGPointMake(director.screenCenter.x, director.screenCenter.y*0.55);
    [self addChild:mainMenu z:101];
}

-(void)addTimedButton{
    CCMenuItem *timedItem = [CCMenuItemImage
                                itemFromNormalImage:@"timedbutton.png" selectedImage:@"timedselected.png"
                                target:self selector:@selector(timedButtonTapped:)];
    timedItem.position = CGPointMake(0, 0);
    timedItem.scale = 1;
    timedMenu = [CCMenu menuWithItems:timedItem, nil];
    timedMenu.position = CGPointMake(director.screenCenter.x, director.screenCenter.y*0.65);
    [self addChild:timedMenu z:101];
}

-(void)addSoundOffButton{
    CCMenuItem *soundOffItem = [CCMenuItemImage
                             itemFromNormalImage:@"soundbutton.png" selectedImage:@"soundselected.png"
                             target:self selector:@selector(soundOffButtonTapped:)];
    soundOffItem.position = CGPointMake(0, 0);
    soundOffItem.scale = 1;
    soundOffMenu = [CCMenu menuWithItems:soundOffItem, nil];
    soundOffMenu.position = CGPointMake(director.screenCenter.x, director.screenCenter.y*0.40);
    [self addChild:soundOffMenu z:101];
}

-(void)addSoundOnButton{
    CCMenuItem *soundOnItem = [CCMenuItemImage
                                itemFromNormalImage:@"soundon.png" selectedImage:@"soundonselected.png"
                                target:self selector:@selector(soundOnButtonTapped:)];
    soundOnItem.position = CGPointMake(0, 0);
    soundOnItem.scale = 1;
    soundOnMenu = [CCMenu menuWithItems:soundOnItem, nil];
    soundOnMenu.position = CGPointMake(director.screenCenter.x, director.screenCenter.y*0.40);
    [self addChild:soundOnMenu z:101];
}


-(void)addPlayButton{
    CCMenuItem *playMenuItem = [CCMenuItemImage
                                itemFromNormalImage:@"play.png" selectedImage:@"play.png"
                                target:self selector:@selector(playButtonTapped:)];
    playMenuItem.position = CGPointMake(0, 0);
    playMenuItem.scale = 0.272;
    playMenu = [CCMenu menuWithItems:playMenuItem, nil];
    playMenu.position = CGPointMake(director.screenCenter.x-25, 25);
    [self addChild:playMenu z:101];
}

-(void)addQuitButton{
    CCMenuItem *quitMenuItem = [CCMenuItemImage
                    itemFromNormalImage:@"quit.png" selectedImage:@"quit.png"
                    target:self selector:@selector(quitButtonTapped:)];
    quitMenuItem.position = CGPointMake(0, 0);
    quitMenuItem.scale = 0.335;
    quitMenu = [CCMenu menuWithItems:quitMenuItem, nil];
    quitMenu.position = CGPointMake(director.screenCenter.x+25, 25);
    [self addChild:quitMenu z:101];
}

-(void)addBars{
    CCSprite *topBar = [CCSprite spriteWithFile:@"whitebar.png"];
    topBar.scale = 4.0;
    topBar.opacity = 140;
    topBar.position = CGPointMake((int)director.screenSize.width/2, (int)director.screenSize.height);
    
    CCSprite *bottomBar = [CCSprite spriteWithFile:@"whitebar.png"];
    bottomBar.scale = 3.50;
    bottomBar.opacity = 140;
    bottomBar.position = CGPointMake((int)director.screenSize.width/2, 0);
    
    [self addChild:topBar z:1];
    [self addChild:bottomBar z:1];
}

-(void)addLivesLabel{
    livesLabel = [CCLabelTTF labelWithString:@"Lives: 5"
                                    fontName:@"Squarefont"
                                    fontSize:20];
    livesLabel.position = CGPointMake(60, 20);
    livesLabel.color = ccGREEN;
    [self addChild:livesLabel z:100];
}

-(void)addGameTimerLabel{
    gameTimerLabel = [CCLabelTTF labelWithString:@"Time: 60"
                                    fontName:@"Squarefont"
                                    fontSize:20];
    gameTimerLabel.position = CGPointMake(60, 20);
    gameTimerLabel.color = ccGREEN;
    [self addChild:gameTimerLabel z:100];
}

-(void)addPointsLabel{
    pointsLabel = [CCLabelTTF labelWithString:@"Points: 0"
                                     fontName:@"Squarefont"
                                     fontSize:20];
    pointsLabel.color = ccGREEN;
    [pointsLabel setString:[NSString stringWithFormat:@"Points: %d", points]];
    if (gameOver){
        pointsLabel.position = CGPointMake(director.screenCenter.x, director.screenCenter.y*1.2);
        pointsLabel.fontSize = 35;
    }
    else if (!gameOver){
        pointsLabel.position = CGPointMake(260, 20);
    }
    [self addChild:pointsLabel z:100];
}

-(void)addGameOverLabel{
    CCLabelTTF *gameOverLabel = [CCLabelTTF labelWithString:@"Game over!"
                                                   fontName:@"Squarefont"
                                                   fontSize:50];
    gameOverLabel.position = CGPointMake(director.screenCenter.x, director.screenCenter.y*1.5);
    gameOverLabel.color = ccGREEN;
    [self addChild:gameOverLabel z:100];
}

////////////CALIBRATION>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
-(void)calibrate:(id)sender{
    if(wantSound){
        [[SimpleAudioEngine sharedEngine] playEffect:@"pop.wav" pitch:1 pan:0 gain:1];
    }
    input = [KKInput sharedInput];
    calibrationY = input.acceleration.y;
    calibrationX = input.acceleration.x;
    ship.position = director.screenCenter;
}

-(void)addCalibrationButton{
    CCMenuItemLabel *calibrationMenuItem = [CCMenuItemLabel
                                      itemWithLabel:[CCLabelTTF labelWithString:@"Calibrate"
                                      fontName:@"Squarefont"
                                      fontSize:18.0f]
                                      target:self
                                      selector:@selector(calibrate:)];
    calibrationMenuItem.color = ccGREEN;
    CCMenu *calibrationMenu = [CCMenu menuWithItems: calibrationMenuItem, nil];
    [calibrationMenu alignItemsHorizontallyWithPadding:50];
    calibrationMenu.position = CGPointMake((int)director.screenSize.width * 0.25, (int)director.screenSize.height*0.935);
    [self addChild:calibrationMenu z:101];
}

-(void)invert:(id)sender{
    if(wantSound){
        [[SimpleAudioEngine sharedEngine] playEffect:@"pop.wav" pitch:1 pan:0 gain:1];
    }
    if (direction == 1) direction = -1;
    else if (direction == -1) direction = 1;
}

-(void)addInvertButton{
    CCMenuItemLabel *invertMenuItem = [CCMenuItemLabel
                                            itemWithLabel:[CCLabelTTF labelWithString:@"Invert"
                                                                             fontName:@"Squarefont"
                                                                             fontSize:18.0f]
                                            target:self
                                            selector:@selector(invert:)];
    invertMenuItem.color = ccGREEN;
    CCMenu *invertMenu = [CCMenu menuWithItems: invertMenuItem, nil];
    [invertMenu alignItemsHorizontallyWithPadding:50];
    invertMenu.position = CGPointMake((int)director.screenSize.width * 0.75, (int)director.screenSize.height*0.935);
    [self addChild:invertMenu z:101];
}

//timed game controls

-(void)gameTimerRun{
    if(!paused){
        gameSecondsCount = gameSecondsCount - 1;
        float pitch = CCRANDOM_MINUS1_1() * 0.1f + 0.9f;
        if (wantSound){
            [[SimpleAudioEngine sharedEngine] playEffect:@"blop.wav" pitch:pitch pan:0 gain:1];
        }
        if (gameSecondsCount < 6){
            gameTimerLabel.color = ccRED;
        }
        if (gameSecondsCount >= 6){
            gameTimerLabel.color = ccGREEN;
        }
        if (gameSecondsCount <= 0) {
            [gameTimer invalidate];
            gameTimer = nil;
            gameOver = true;
            [self endGame];
        }
        [gameTimerLabel setString:[NSString stringWithFormat:@"Time: %d", gameSecondsCount]];
    }
}

-(void)setGameTimer{
    countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(gameTimerRun) userInfo:nil repeats:YES];
}

-(void)addBackground{
    bg = [CCSprite spriteWithFile:@"space.jpg"];
    bg.scale = 3.15;
    bg.position = director.screenCenter;
    [self addChild:bg z:0];
}

-(void)addGameTitle{
    nameLabel = [CCLabelTTF labelWithString:@"Space Explorers"
                                   fontName:@"Squarefont"
                                   fontSize:60
                                 dimensions:CGSizeMake(400, 500)
                                 hAlignment:UITextAlignmentCenter];
    nameLabel.position = director.screenCenter;
    nameLabel.color = ccGREEN;
    [self addChild:nameLabel z:101];
}

-(void)addShip{
    ship = [CCSprite spriteWithFile:@"ship.png"];//load ship from file
    input = [KKInput sharedInput];
    calibrationY = input.acceleration.y;
    calibrationX = input.acceleration.x;

    ship.position = [CCDirector sharedDirector].screenCenter;//position ship in the center of the screen
    [self addChild:ship z:222];//add ship to screen
}

@end
