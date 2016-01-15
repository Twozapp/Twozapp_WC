//
//  ProfileTwoViewController.m
//  Twozapp
//
//  Created by Priya on 11/01/16.
//  Copyright © 2016 Priya. All rights reserved.
//

#import "ProfileTwoViewController.h"
#import "SlideAlertiOS7.h"
#import "NetworkManager.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"

@interface ProfileTwoViewController ()< UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate, MBProgressHUDDelegate>

@end

@implementation ProfileTwoViewController
{
    MBProgressHUD *hudProgress;
    
}
@synthesize keys;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.userInteractionEnabled = NO;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTap:)];
    [self.view addGestureRecognizer:tap];
    keys = [[NSMutableArray alloc] init];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    _imgView1.layer.cornerRadius = 5.0f;
    [_imgView1.layer setMasksToBounds:YES];
    
    _imgView2.layer.cornerRadius = 5.0f;
    [_imgView2.layer setMasksToBounds:YES];
    
    _imgView3.layer.cornerRadius = 5.0f;
    [_imgView3.layer setMasksToBounds:YES];
    
    _lbl1.layer.cornerRadius = 5.0;
    [_lbl1.layer setMasksToBounds:YES];
    _lbl2.layer.cornerRadius = 5.0;
    [_lbl2.layer setMasksToBounds:YES];
    _lbl3.layer.cornerRadius = 5.0;
    [_lbl3.layer setMasksToBounds:YES];
    
    _txtViewTellus.layer.borderColor = [UIColor redColor].CGColor;
    _txtViewTellus.layer.borderWidth = 0.5f;
    _txtViewTellus.layer.cornerRadius = 5.0f;
    [_txtViewTellus.layer setMasksToBounds:YES];
    
    _txtFldKeyword.layer.borderColor = [UIColor redColor].CGColor;
    _txtFldKeyword.layer.borderWidth = 0.5f;
    _txtFldKeyword.layer.cornerRadius = 5.0f;
    [_txtFldKeyword.layer setMasksToBounds:YES];
    
    
    UIImage *navImage =  [[UIImage imageNamed:@"navigationbar"]
                          resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
    
    [[UINavigationBar appearance] setBackgroundImage:navImage forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setBackgroundImage:navImage forBarMetrics:UIBarMetricsCompact];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Profile" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    [rightBarButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                            [UIFont fontWithName:@"Segoe Print" size:20.0], NSFontAttributeName,
                                            [UIColor whiteColor], NSForegroundColorAttributeName,
                                            nil]
                                  forState:UIControlStateNormal];
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"twozapp"]] style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return keys.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [_CollectionViewKeyword dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.layer.cornerRadius = 3.0f;
    [cell.layer setMasksToBounds:YES];
    
    UIButton *btnDelete = (UIButton *)[cell viewWithTag:10];
    [btnDelete.layer setMasksToBounds:YES];
    [btnDelete addTarget:self action:@selector(actionDelete:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *lblTitle = (UILabel *)[cell viewWithTag:20];
    lblTitle.text = [keys objectAtIndex:indexPath.item];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = keys[indexPath.item];
    UIFont *myFont = [UIFont fontWithName:@"Segoe Print" size:17.0];
    
    NSAttributedString *attributedText =
    [[NSAttributedString alloc] initWithString:key
                                    attributes:@{NSFontAttributeName: myFont}];
    CGRect rect = [attributedText boundingRectWithSize:(CGSize){CGFLOAT_MAX, 30}
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    return CGSizeMake(rect.size.width + 30, 30);
}


- (IBAction)actionSave:(id)sender {
    
    if (_imgView1.image == nil) {
        [[SlideAlertiOS7 sharedSlideAlert] showSlideAlertViewWithStatus:@"Failure" withText:@"Please upload the primary Picture"];
    }
    else if (_imgView2.image == nil) {
        [[SlideAlertiOS7 sharedSlideAlert] showSlideAlertViewWithStatus:@"Failure" withText:@"Please upload the primary Picture"];
    }
    else if (_imgView3.image == nil) {
        [[SlideAlertiOS7 sharedSlideAlert] showSlideAlertViewWithStatus:@"Failure" withText:@"Please upload the primary Picture"];
    }
    else if (_txtViewTellus.text.length == 0)
    {
        [[SlideAlertiOS7 sharedSlideAlert] showSlideAlertViewWithStatus:@"Failure" withText:@"Please enter something about yourself."];
    }
    else if (keys.count < 3)
    {
        [[SlideAlertiOS7 sharedSlideAlert] showSlideAlertViewWithStatus:@"Failure" withText:@"Please add atleast 3 keywords about yourself."];
    }
    else
    {
        Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
        NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
        if (networkStatus == NotReachable) {
            [[SlideAlertiOS7 sharedSlideAlert] showSlideAlertViewWithStatus:@"Failure" withText:@"No Internet connection Available."];
        } else {
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            hudProgress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hudProgress.delegate = self;
            
            hudProgress.mode = MBProgressHUDModeIndeterminate;
            hudProgress.labelText = @"Loading";
            hudProgress.dimBackground = YES;
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            NSString  *urlPath    = [NSString stringWithFormat:@"http://infowebtechsolutions.com/demo/twzapp/signup.php?full_name=%@&email=%@&password=&gender=%@&description=%@&latitude=%f&logitude=%f&fb_id=%@&chinese_element=water_wood&zodiac_animal=metal_monkey",[OnDeck sharedInstance].strName, [OnDeck sharedInstance].strEmail, [OnDeck sharedInstance].strGender, _txtViewTellus.text, [self appDelegate].location.coordinate.latitude, [self appDelegate].location.coordinate.longitude, [defaults stringForKey:@"fb_id"]];
            
            [[NetworkManager sharedManager] getvalueFromServerForGetterURL:urlPath
                                                         completionHandler:^(NSError *error, NSDictionary *result) {
                                                             if(error) {
                                                                 NSLog(@"error : %@", [error description]);
                                                             } else {
                                                                 // This is the expected result
                                                                 NSLog(@"result : %@", result);
                                                                 if (result.count >0) {
                                                                     if ([result[@"response"][@"Success"] isEqualToString:@"1"]) {
                                                                         
                                                                         [[SlideAlertiOS7 sharedSlideAlert] showSlideAlertViewWithStatus:@"Success" withText:@"Successfully changed the password"];
                                                                         
                                                                         
                                                                         
                                                                     }
                                                                     else
                                                                     {
                                                                         [[SlideAlertiOS7 sharedSlideAlert] showSlideAlertViewWithStatus:@"Failure" withText:@"Already registered"];
                                                                     }
                                                                 }
                                                                 
                                                             }
                                                             UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                                                             UIViewController *profileTwo = [story instantiateViewControllerWithIdentifier:@"MainViewControllerNavi"];
                                                             [self presentViewController:profileTwo animated:YES completion:nil];
                                                             [self hudWasHidden:hudProgress];
                                                         }];
        }
        
    }
}

- (IBAction)actionAddPhoto1:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Take Photo", @"Photo Library", nil];
    actionSheet.tag = 1;
    [actionSheet showInView:self.view];
    
}

- (IBAction)actionPhoto2:(id)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Take Photo", @"Photo Library", nil];
    actionSheet.tag = 3;
    [actionSheet showInView:self.view];
    
}
- (IBAction)actionAddPhoto2:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Take Photo", @"Photo Library", nil];
    actionSheet.tag = 2;
    [actionSheet showInView:self.view];
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.view.tag = actionSheet.tag;
    if (buttonIndex == 0) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:NULL];
        
    }else if (buttonIndex == 1){
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:NULL];
    }
    
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    if (picker.view.tag == 1) {
        UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
        _imgView1.image = chosenImage;
        [[OnDeck sharedInstance].dictImages setObject:chosenImage forKey:[NSString stringWithFormat:@"1"]];
        [picker dismissViewControllerAnimated:YES completion:NULL];
    }
    else if (picker.view.tag == 2)
    {
        UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
        _imgView2.image = chosenImage;
        [[OnDeck sharedInstance].dictImages setObject:chosenImage forKey:[NSString stringWithFormat:@"2"]];
        [picker dismissViewControllerAnimated:YES completion:NULL];
    }
    else if (picker.view.tag == 3)
    {
        UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
        _imgView3.image = chosenImage;
        [[OnDeck sharedInstance].dictImages setObject:chosenImage forKey:[NSString stringWithFormat:@"3"]];
        [picker dismissViewControllerAnimated:YES completion:NULL];
    }
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)actionTap:(UITapGestureRecognizer *)tap
{
    [self.view endEditing:YES];
    [UIView animateWithDuration:0.25
                          delay:0.1
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^
     {
         [self.view setFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height)];
         [self.view endEditing:YES];
     } completion:nil];
}

- (void)keyboardDidShow:(NSNotification *)notification
{
    [UIView animateWithDuration:0.25
                          delay:0.1
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^
     {
         // Assign new frame to your view
         [self.view setFrame:CGRectMake(0,-200,self.view.frame.size.width,self.view.frame.size.height)]; //here taken -20 for example i.e. your view will be scrolled to -20. change its value according to your requirement.
     } completion:nil];
    
}

-(void)keyboardDidHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.25
                          delay:0.1
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^
     {
         [self.view setFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height)];
         [self.view endEditing:YES];
     } completion:nil];
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.25
                          delay:0.1
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^
     {
         // Assign new frame to your view
         [self.view setFrame:CGRectMake(0,-200,self.view.frame.size.width,self.view.frame.size.height)]; //here taken -20 for example i.e. your view will be scrolled to -20. change its value according to your requirement.
     } completion:nil];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // Prevent crashing undo bug – see note below.
    if(range.length + range.location > textField.text.length)
    {
        return NO;
    }
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return newLength <= 20;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [keys addObject:textField.text];
    textField.text = @"";
    [_CollectionViewKeyword reloadData];
    
    return YES;
}

- (IBAction)actionDelete:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    UICollectionViewCell *cell = (UICollectionViewCell *)btn.superview.superview;
    
    NSIndexPath *indexPath = [_CollectionViewKeyword indexPathForCell:cell];
    [keys removeObjectAtIndex:indexPath.row];
    [_CollectionViewKeyword reloadData];
}

- (AppDelegate *)appDelegate
{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
    [hudProgress removeFromSuperview];
    hudProgress = nil;
}

@end
