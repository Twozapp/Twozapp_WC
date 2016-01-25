//
//  MainViewController.m
//  Twozapp
//
//  Created by Priya on 10/01/16.
//  Copyright © 2016 Priya. All rights reserved.
//

#import "MainViewController.h"
#import "RNFrostedSidebar.h"
#import "DraggableView.h"
#import "NetworkManager.h"
#import "UserFriends.h"
#import "MatchesViewController.h"
#import "OverlayView.h"
#import "UserDetails.h"

static const int MAX_BUFFER_SIZE = 2; //%%% max number of cards loaded at any given time, must be greater than 1
static const float CARD_HEIGHT = 386; //%%% height of the draggable card
static const float CARD_WIDTH = 290;

@interface MainViewController ()<RNFrostedSidebarDelegate>{
    NSInteger cardsLoadedIndex; 
    NSMutableArray *loadedCards;
    NSMutableArray *friendList;
    OverlayView *overlayView;
}
@property (nonatomic, strong) NSMutableIndexSet *optionIndices;


@end

@implementation MainViewController
@synthesize exampleCardLabels;
@synthesize allCards;

- (void)viewDidLoad {
    [super viewDidLoad];
    friendList = [[NSMutableArray alloc] init];
    _imgViewProfilePic.layer.cornerRadius = 7.0f;
    [_imgViewProfilePic.layer setMasksToBounds:YES];
    _viewName.layer.cornerRadius = 7.0f;
    [_viewName.layer setMasksToBounds:YES];
    _viewBazi.layer.cornerRadius = 7.0f;
    [_viewBazi.layer setMasksToBounds:YES];
    
    UIImage *navImage =  [[UIImage imageNamed:@"navigationbar"]
                          resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
    
    [[UINavigationBar appearance] setBackgroundImage:navImage forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setBackgroundImage:navImage forBarMetrics:UIBarMetricsCompact];
    
    exampleCardLabels = [[NSArray alloc]initWithObjects:@"first",@"second",@"third",@"fourth",@"last", @"first",@"second",@"third",@"fourth",@"last", @"first",@"second",@"third",@"fourth",@"last", nil]; //%%% placeholder for card-specific information
    loadedCards = [[NSMutableArray alloc] init];
    allCards = [[NSMutableArray alloc] init];
    cardsLoadedIndex = 0;
    
    
    
    loadedCards = [[NSMutableArray alloc] init];
    NSString  *urlPath    = [NSString stringWithFormat:@"http://infowebtechsolutions.com/demo/twzapp/near_friends.php?user_id=%@",[UserDetails sharedInstance].user_id];
    
    [[NetworkManager sharedManager] getvalueFromServerForGetterURL:urlPath
                                                 completionHandler:^(NSError *error, NSDictionary *result) {
                                                     if(error) {
                                                         NSLog(@"error : %@", [error description]);
                                                     } else {
                                                         // This is the expected result
                                                         NSLog(@"result : %@", result);
                                                         if (result.count >0) {
                                                             if ([result[@"response"][@"Success"] isEqualToString:@"1"]) {
                                                                 
                                                                 NSMutableArray *arrResponse = [[NSMutableArray alloc] init];
                                                                 
                                                                 arrResponse = result[@"response"][@"User Profile"];
                                                                 for (int i = 0; i<[arrResponse count]; i++) {
                                                                     UserFriends *listfriends = [[UserFriends alloc] init];
                                                                     listfriends.frdId = [[arrResponse objectAtIndex:i] objectForKey:@"id"];
                                                                     listfriends.frdName = [[arrResponse objectAtIndex:i] objectForKey:@"full_name"];
                                                                     listfriends.fndImage = [[arrResponse objectAtIndex:i] objectForKey:@"image"];
                                                                     [friendList addObject:listfriends];
                                                                 }
                                                                 [self loadCards];
                                                             }
                                                             else
                                                             {
                                                                 
                                                             }
                                                         }
                                                         
                                                     }
                                                                                                     }];
}

- (void)viewDidAppear:(BOOL)animated
{
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [NSURLConnection sendAsynchronousRequest:[self uploadImages]
                                       queue:queue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
                               if (error) {
                                   
                               }
                               else
                               {
                                   NSString *response = [NSJSONSerialization JSONObjectWithData:data
                                                                                            options:NSJSONReadingMutableContainers | NSJSONReadingAllowFragments
                                                                                              error:&error];
                                   NSLog(@"the image response = %@",response);
                               }
                               
                           }];
}

- (NSMutableURLRequest *)uploadImages
{
    // Dictionary that holds post parameters. You can set your post parameters that your server accepts or programmed to accept.
    NSMutableDictionary* _params = [[NSMutableDictionary alloc] init];
   // [_params setObject:[UserDetails sharedInstance].user_id forKey:@"profile_id"];
   // [_params setObject:@"profile_picture1" forKey:@"profile_picture1"];
    
    // the boundary string : a random string, that will not repeat in post data, to separate post data fields.
    NSString *BoundaryConstant = @"----------V2ymHFg03ehbqgZCaKO6jy";
    
    // string constant for the post parameter 'file'. My server uses this name: `file`. Your's may differ
    NSString* FileParamConstant = @"file";
    
    // the server url to which the image (or the media) is uploaded. Use your server url here
    NSURL* requestURL = [NSURL URLWithString:@"http://infowebtechsolutions.com/demo/twzapp/image_move.php?"];
    
    // create request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:30];
    [request setHTTPMethod:@"POST"];
    
    // set Content-Type in HTTP header
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", BoundaryConstant];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    // post body
    NSMutableData *body = [NSMutableData data];
    
    // add params (all params are strings)
    for (NSString *param in _params) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", param] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@\r\n", [_params objectForKey:param]] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    UIImage *img = [UIImage imageNamed:@"imgSample.png"];
    // add image data
    NSData *imageData = UIImageJPEGRepresentation(img, 1.0);
    if (imageData) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"image.jpg\"\r\n", FileParamConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:imageData];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    
    // set the content-length
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[body length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    // set URL
    [request setURL:requestURL];
    
    return request;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)actionSideMenu:(id)sender {
    
    NSArray *images = @[
                        [UIImage imageNamed:@"imgSample.png"],
                        [UIImage imageNamed:@"chat"],
                        [UIImage imageNamed:@"match1"],
                        [UIImage imageNamed:@"profile"],
                        [UIImage imageNamed:@"star"]];
    NSArray *colors = @[[UIColor colorWithRed:240/255.f green:159/255.f blue:254/255.f alpha:1],
                        [UIColor colorWithRed:240/255.f green:159/255.f blue:254/255.f alpha:1],
                        [UIColor colorWithRed:255/255.f green:137/255.f blue:167/255.f alpha:1],
                        [UIColor colorWithRed:126/255.f green:242/255.f blue:195/255.f alpha:1],
                        [UIColor colorWithRed:119/255.f green:152/255.f blue:255/255.f alpha:1]
                        ];
    
    // NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userName;
    NSArray *labels;
    
        labels = @[[UserDetails sharedInstance].full_name,@"Chats", @"Matches", @"Profile", @"My Bazi"];
    
    RNFrostedSidebar *callout = [[RNFrostedSidebar alloc] initWithImages:images selectedIndices:self.optionIndices borderColors:colors textLabels:labels];
    //    RNFrostedSidebar *callout = [[RNFrostedSidebar alloc] initWithImages:images];
    callout.delegate = self;
    //    callout.showFromRight = YES;
    [callout show];

}

- (IBAction)actionNotIntrested:(id)sender {
    _btnNotIntrested.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    
    [UIView animateWithDuration:0.3/2 animations:^{
        _btnNotIntrested.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3/2 animations:^{
            _btnNotIntrested.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3/2 animations:^{
                _btnNotIntrested.transform = CGAffineTransformIdentity;
            }];
        }];
    }];
 
    
}




- (IBAction)actionIntrested:(id)sender {
    
    _btnIntrested.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    
    [UIView animateWithDuration:0.3/2 animations:^{
        _btnIntrested.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3/2 animations:^{
            _btnIntrested.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3/2 animations:^{
                _btnIntrested.transform = CGAffineTransformIdentity;
            }];
        }];
    }];

}


-(DraggableView *)createDraggableViewWithDataAtIndex:(NSInteger)index
{
    DraggableView *draggableView = [[[NSBundle mainBundle] loadNibNamed:@"DraggableView" owner:self options:nil] lastObject];
    draggableView.frame = CGRectMake(0, 0, _viewProfile.frame.size.width, _viewProfile.frame.size.height);
    [draggableView setupView];
 //   DraggableView *draggableView = [[DraggableView alloc]initWithFrame:CGRectMake((self.view.frame.size.width - _viewProfile.frame.size.width)/2, (self.view.frame.size.height - _viewProfile.frame.size.height)/2, _viewProfile.frame.size.width, _viewProfile.frame.size.height)];
   // draggableView.information.text = [exampleCardLabels objectAtIndex:index]; //%%% placeholder for card-specific information
    draggableView.delegate = self;
    return draggableView;
}

//%%% loads all the cards and puts the first x in the "loaded cards" array
-(void)loadCards
{
    if([friendList count] > 0) {
        NSInteger numLoadedCardsCap =(([exampleCardLabels count] > MAX_BUFFER_SIZE)?MAX_BUFFER_SIZE:[exampleCardLabels count]);
        //%%% if the buffer size is greater than the data size, there will be an array error, so this makes sure that doesn't happen
        
        //%%% loops through the exampleCardsLabels array to create a card for each label.  This should be customized by removing "exampleCardLabels" with your own array of data
        for (int i = 0; i<[friendList count]; i++) {
            DraggableView* newCard = [self createDraggableViewWithDataAtIndex:i];
            [newCard.btnLike addTarget:self action:@selector(swipeRight) forControlEvents:UIControlEventTouchUpInside];
            newCard.btnLike.tag = i;
            newCard.btnDislike.tag = i;
            [newCard.btnDislike addTarget:self action:@selector(swipeLeft) forControlEvents:UIControlEventTouchUpInside];
            [allCards addObject:newCard];
            newCard.layer.cornerRadius = 5.0f;
            newCard.layer.masksToBounds = YES;
            newCard.userFriend = friendList[i];
            newCard.lblName.text = [NSString stringWithFormat:@"%@, 24",newCard.userFriend.frdName];

            
            if (i<numLoadedCardsCap) {
                //%%% adds a small number of cards to be loaded
                [loadedCards addObject:newCard];
            }
        }
        
        //%%% displays the small number of loaded cards dictated by MAX_BUFFER_SIZE so that not all the cards
        // are showing at once and clogging a ton of data
        for (int i = 0; i<[loadedCards count]; i++) {
            if (i>0) {
                [_viewProfile insertSubview:[loadedCards objectAtIndex:i] belowSubview:[loadedCards objectAtIndex:i-1]];
            } else {
                [_viewProfile addSubview:[loadedCards objectAtIndex:i]];
            }
            cardsLoadedIndex++; //%%% we loaded a card into loaded cards, so we have to increment
        }
    }
    
}

#warning include own action here!
//%%% action called when the card goes to the left.
// This should be customized with your own action
-(void)cardSwipedLeft:(UIView *)card;
{
    //do whatever you want with the card that was swiped
        DraggableView *c = (DraggableView *)card;
    UserFriends *friend = c.userFriend;
    [self sendRequestwithStatus:@"1" forFriendId:friend.frdId];
    [loadedCards removeObjectAtIndex:0]; //%%% card was swiped, so it's no longer a "loaded card"
    
    if (cardsLoadedIndex < [allCards count]) { //%%% if we haven't reached the end of all cards, put another into the loaded cards
        [loadedCards addObject:[allCards objectAtIndex:cardsLoadedIndex]];
        cardsLoadedIndex++;//%%% loaded a card, so have to increment count
        [_viewProfile insertSubview:[loadedCards objectAtIndex:(MAX_BUFFER_SIZE-1)] belowSubview:[loadedCards objectAtIndex:(MAX_BUFFER_SIZE-2)]];
        
        
        
    }
    
}

//%%% action called when the card goes to the right.
// This should be customized with your own action
-(void)cardSwipedRight:(UIView *)card
{
    //do whatever you want with the card that was swiped
        DraggableView *c = (DraggableView *)card;
    UserFriends *friend = c.userFriend;
    [self sendRequestwithStatus:@"0" forFriendId:friend.frdId];
    [loadedCards removeObjectAtIndex:0]; //%%% card was swiped, so it's no longer a "loaded card"
    
    if (cardsLoadedIndex < [allCards count]) { //%%% if we haven't reached the end of all cards, put another into the loaded cards
        [loadedCards addObject:[allCards objectAtIndex:cardsLoadedIndex]];
        cardsLoadedIndex++;//%%% loaded a card, so have to increment count
        [_viewProfile insertSubview:[loadedCards objectAtIndex:(MAX_BUFFER_SIZE-1)] belowSubview:[loadedCards objectAtIndex:(MAX_BUFFER_SIZE-2)]];
        
    }
    
}

//%%% when you hit the right button, this is called and substitutes the swipe
-(void)swipeRight
{
    DraggableView *dragView = [loadedCards firstObject];
    dragView.overlayView.mode = GGOverlayViewModeRight;
    [UIView animateWithDuration:0.2 animations:^{
        dragView.overlayView.alpha = 1;
    }];
    [dragView rightClickAction];
    UserFriends *friend = dragView.userFriend;
    [self sendRequestwithStatus:@"0" forFriendId:friend.frdId];
}

//%%% when you hit the left button, this is called and substitutes the swipe
-(void)swipeLeft
{
    DraggableView *dragView = [loadedCards firstObject];
    dragView.overlayView.mode = GGOverlayViewModeLeft;
    [UIView animateWithDuration:0.2 animations:^{
        dragView.overlayView.alpha = 1;
    }];
    [dragView leftClickAction];
     UserFriends *friend = dragView.userFriend;
     [self sendRequestwithStatus:@"1" forFriendId:friend.frdId];

}

- (void)sendRequestwithStatus:(NSString *)status forFriendId:(NSString *)friendID
{
    NSString  *urlPath    = [NSString stringWithFormat:@"http://infowebtechsolutions.com/demo/twzapp/accept.php?from_id=%@1&to_id=%@&status=%@",friendID, [UserDetails sharedInstance].user_id, status];
    
    [[NetworkManager sharedManager] getvalueFromServerForGetterURL:urlPath
                                                 completionHandler:^(NSError *error, NSDictionary *result) {
                                                     if(error) {
                                                         NSLog(@"error : %@", [error description]);
                                                     } else {
                                                         // This is the expected result
                                                         NSLog(@"result : %@", result);
                                                         if (result.count >0) {
                                                             if ([result[@"response"][@"Success"] isEqualToString:@"1"]) {
                                                                 
                                                                
                                                             }
                                                             else
                                                             {
                                                                 
                                                             }
                                                         }
                                                         
                                                     }
                                                 }];
}


@end
