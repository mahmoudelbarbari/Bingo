import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @handMade.
  ///
  /// In en, this message translates to:
  /// **'Handmade'**
  String get handMade;

  /// No description provided for @withLove.
  ///
  /// In en, this message translates to:
  /// **'with Love'**
  String get withLove;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @discoverTalentedMakersCreatingUnique.
  ///
  /// In en, this message translates to:
  /// **'Discover talented makers creating unique'**
  String get discoverTalentedMakersCreatingUnique;

  /// No description provided for @handmadeTreasures.
  ///
  /// In en, this message translates to:
  /// **'handmade treasures !'**
  String get handmadeTreasures;

  /// No description provided for @sell.
  ///
  /// In en, this message translates to:
  /// **'Sell'**
  String get sell;

  /// No description provided for @handmadeProducts.
  ///
  /// In en, this message translates to:
  /// **'handmade Products'**
  String get handmadeProducts;

  /// No description provided for @showcaseYourSkillsConnectWithBuyersAnd.
  ///
  /// In en, this message translates to:
  /// **'Showcase your skills, connect with buyers, and'**
  String get showcaseYourSkillsConnectWithBuyersAnd;

  /// No description provided for @turnPassionIntoBusiness.
  ///
  /// In en, this message translates to:
  /// **'turn passion into business.'**
  String get turnPassionIntoBusiness;

  /// No description provided for @buy.
  ///
  /// In en, this message translates to:
  /// **'Buy'**
  String get buy;

  /// No description provided for @ownUniqueHandmadePiecesCraftedWithLove.
  ///
  /// In en, this message translates to:
  /// **'Own unique handmade pieces crafted with love,'**
  String get ownUniqueHandmadePiecesCraftedWithLove;

  /// No description provided for @authenticityAndPassion.
  ///
  /// In en, this message translates to:
  /// **'authenticity, and passion.'**
  String get authenticityAndPassion;

  /// No description provided for @greateToSeeYouHere.
  ///
  /// In en, this message translates to:
  /// **'Great to see you here '**
  String get greateToSeeYouHere;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @justLogInAndHavefun.
  ///
  /// In en, this message translates to:
  /// **'Just log in and have fun'**
  String get justLogInAndHavefun;

  /// No description provided for @yourEmail.
  ///
  /// In en, this message translates to:
  /// **'Your E-mail'**
  String get yourEmail;

  /// No description provided for @yourPassword.
  ///
  /// In en, this message translates to:
  /// **'Your Password'**
  String get yourPassword;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password ?'**
  String get forgotPassword;

  /// No description provided for @remmberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember Me'**
  String get remmberMe;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'Or'**
  String get or;

  /// No description provided for @readMe.
  ///
  /// In en, this message translates to:
  /// **'Read More'**
  String get readMe;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @requiredField.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get requiredField;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords don\'t match'**
  String get passwordsDoNotMatch;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPassword;

  /// No description provided for @invalidPassword.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters long and include uppercase, lowercase letters, and numbers.'**
  String get invalidPassword;

  /// No description provided for @dontHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account ?'**
  String get dontHaveAnAccount;

  /// No description provided for @letsGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Let\'s get started!'**
  String get letsGetStarted;

  /// No description provided for @createAnAccountToContinue.
  ///
  /// In en, this message translates to:
  /// **'Create an account to continue'**
  String get createAnAccountToContinue;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @userName.
  ///
  /// In en, this message translates to:
  /// **'Your Name'**
  String get userName;

  /// No description provided for @dontWorryWellHelpYouResetIt.
  ///
  /// In en, this message translates to:
  /// **'Don\'t worry, we\'ll help you reset it.'**
  String get dontWorryWellHelpYouResetIt;

  /// No description provided for @reply.
  ///
  /// In en, this message translates to:
  /// **'Reply'**
  String get reply;

  /// No description provided for @loveIt.
  ///
  /// In en, this message translates to:
  /// **'Love it'**
  String get loveIt;

  /// No description provided for @comment.
  ///
  /// In en, this message translates to:
  /// **'Comment'**
  String get comment;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @acceptanceFormate.
  ///
  /// In en, this message translates to:
  /// **'- Accepted formats: JPG, PNG,PDF| Max size: 2MB.'**
  String get acceptanceFormate;

  /// No description provided for @photo_requirements.
  ///
  /// In en, this message translates to:
  /// **'- No glare, reflections, or cropped edges.'**
  String get photo_requirements;

  /// No description provided for @pleaseEnterTheCodeThatWasSentToYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter the code that was sent to your email'**
  String get pleaseEnterTheCodeThatWasSentToYourEmail;

  /// No description provided for @verificationCode.
  ///
  /// In en, this message translates to:
  /// **'Verification Code'**
  String get verificationCode;

  /// No description provided for @resendCode.
  ///
  /// In en, this message translates to:
  /// **'Resend Code'**
  String get resendCode;

  /// No description provided for @createNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Create New Password'**
  String get createNewPassword;

  /// No description provided for @enterYourNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your new password'**
  String get enterYourNewPassword;

  /// No description provided for @passwordCreatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Password created successfully'**
  String get passwordCreatedSuccessfully;

  /// No description provided for @verifyYourAccountAndStartSelling.
  ///
  /// In en, this message translates to:
  /// **'Verify your account and start selling'**
  String get verifyYourAccountAndStartSelling;

  /// No description provided for @forASecureMarketPlaceWeRequireNationalIdentityVerfication.
  ///
  /// In en, this message translates to:
  /// **'For a secure market place, we require national identity verification.'**
  String get forASecureMarketPlaceWeRequireNationalIdentityVerfication;

  /// No description provided for @verifyNow.
  ///
  /// In en, this message translates to:
  /// **'Verify Now'**
  String get verifyNow;

  /// No description provided for @thisInfoIsUsedForIdentityVerficationOnlyAndWillBeKeptSecureByBingo.
  ///
  /// In en, this message translates to:
  /// **'This info is used for identity verification only and will be kept secure by Bingo.'**
  String get thisInfoIsUsedForIdentityVerficationOnlyAndWillBeKeptSecureByBingo;

  /// No description provided for @needHelpContactSupport.
  ///
  /// In en, this message translates to:
  /// **'Need help ? Contact support'**
  String get needHelpContactSupport;

  /// No description provided for @ensureTheEntireIDIsVisibleAndInFocus.
  ///
  /// In en, this message translates to:
  /// **'Ensure the entire ID is visible and in focus.'**
  String get ensureTheEntireIDIsVisibleAndInFocus;

  /// No description provided for @forIDUpload.
  ///
  /// In en, this message translates to:
  /// **'For ID upload'**
  String get forIDUpload;

  /// No description provided for @acceptedFormatsJPGPNGPDFMaxSize2MB.
  ///
  /// In en, this message translates to:
  /// **'Accepted formats: JPG, PNG, PDF | Max size: 2MB.'**
  String get acceptedFormatsJPGPNGPDFMaxSize2MB;

  /// No description provided for @noGlareReflectionsOrCroppedEdges.
  ///
  /// In en, this message translates to:
  /// **'No glare, reflections, or cropped edges.'**
  String get noGlareReflectionsOrCroppedEdges;

  /// No description provided for @uploadProofOfIdentity.
  ///
  /// In en, this message translates to:
  /// **'Upload proof of identity'**
  String get uploadProofOfIdentity;

  /// No description provided for @createYourDreamsWithJoy.
  ///
  /// In en, this message translates to:
  /// **'Create your dreams with joy'**
  String get createYourDreamsWithJoy;

  /// No description provided for @turnYourPassionIntoProfit.
  ///
  /// In en, this message translates to:
  /// **'Turn your passion into profit !'**
  String get turnYourPassionIntoProfit;

  /// No description provided for @myAccount.
  ///
  /// In en, this message translates to:
  /// **'My Account'**
  String get myAccount;

  /// No description provided for @productsList.
  ///
  /// In en, this message translates to:
  /// **'Products List'**
  String get productsList;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @payment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get payment;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @getHelp.
  ///
  /// In en, this message translates to:
  /// **'Get Help'**
  String get getHelp;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @community.
  ///
  /// In en, this message translates to:
  /// **'Community'**
  String get community;

  /// No description provided for @cart.
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get cart;

  /// No description provided for @categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAll;

  /// No description provided for @orderList.
  ///
  /// In en, this message translates to:
  /// **'Order List'**
  String get orderList;

  /// No description provided for @noProductYet.
  ///
  /// In en, this message translates to:
  /// **'No Products Yet'**
  String get noProductYet;

  /// No description provided for @youHaventAddedAnyProductsYet.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t added any products yet.'**
  String get youHaventAddedAnyProductsYet;

  /// No description provided for @startExploringAndFindSomethingSpecial.
  ///
  /// In en, this message translates to:
  /// **'Start exploring and find something special.'**
  String get startExploringAndFindSomethingSpecial;

  /// No description provided for @startAdding.
  ///
  /// In en, this message translates to:
  /// **'Start Adding'**
  String get startAdding;

  /// No description provided for @checkout.
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get checkout;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @delivery.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get delivery;

  /// No description provided for @service.
  ///
  /// In en, this message translates to:
  /// **'Service'**
  String get service;

  /// No description provided for @egp.
  ///
  /// In en, this message translates to:
  /// **'EGP'**
  String get egp;

  /// No description provided for @addItem.
  ///
  /// In en, this message translates to:
  /// **'Add Item'**
  String get addItem;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;

  /// No description provided for @order.
  ///
  /// In en, this message translates to:
  /// **'Order'**
  String get order;

  /// No description provided for @items.
  ///
  /// In en, this message translates to:
  /// **'Items'**
  String get items;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @addNewAddress.
  ///
  /// In en, this message translates to:
  /// **'Add New Address'**
  String get addNewAddress;

  /// No description provided for @cardHolderName.
  ///
  /// In en, this message translates to:
  /// **'Card Holder Name'**
  String get cardHolderName;

  /// No description provided for @expiryDate.
  ///
  /// In en, this message translates to:
  /// **'MM/YY'**
  String get expiryDate;

  /// No description provided for @visa.
  ///
  /// In en, this message translates to:
  /// **'Visa'**
  String get visa;

  /// No description provided for @masterCard.
  ///
  /// In en, this message translates to:
  /// **'Master Card'**
  String get masterCard;

  /// No description provided for @cardNumber.
  ///
  /// In en, this message translates to:
  /// **'Card Number'**
  String get cardNumber;

  /// No description provided for @cvv.
  ///
  /// In en, this message translates to:
  /// **'CVV'**
  String get cvv;

  /// No description provided for @defaultCard.
  ///
  /// In en, this message translates to:
  /// **'Default Card'**
  String get defaultCard;

  /// No description provided for @agreeToTermsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'I agree to the terms & conditions'**
  String get agreeToTermsAndConditions;

  /// No description provided for @addCard.
  ///
  /// In en, this message translates to:
  /// **'Add Card'**
  String get addCard;

  /// No description provided for @cardTypes.
  ///
  /// In en, this message translates to:
  /// **'Card Types'**
  String get cardTypes;

  /// No description provided for @selectCardType.
  ///
  /// In en, this message translates to:
  /// **'Select Card Type'**
  String get selectCardType;

  /// No description provided for @pay.
  ///
  /// In en, this message translates to:
  /// **'Pay'**
  String get pay;

  /// No description provided for @fieldRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get fieldRequired;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get emailRequired;

  /// No description provided for @enterValidEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email'**
  String get enterValidEmail;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordRequired;

  /// No description provided for @passwordValidation.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid password....\nYour password must be at least 8 characters long,\nattached with lowercase and uppercase letters'**
  String get passwordValidation;

  /// No description provided for @minLengthRequired.
  ///
  /// In en, this message translates to:
  /// **'Minimum {count} characters required'**
  String minLengthRequired(int count);

  /// No description provided for @maxLengthRequired.
  ///
  /// In en, this message translates to:
  /// **'Maximum {count} characters allowed'**
  String maxLengthRequired(int count);

  /// No description provided for @valueDoesNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Value does not match'**
  String get valueDoesNotMatch;

  /// No description provided for @confirmOrder.
  ///
  /// In en, this message translates to:
  /// **'Confirm Order'**
  String get confirmOrder;

  /// No description provided for @paymentSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Payment Successful'**
  String get paymentSuccessful;

  /// No description provided for @paymentFailed.
  ///
  /// In en, this message translates to:
  /// **'Payment Failed'**
  String get paymentFailed;

  /// No description provided for @yourPaymentHasBeenSuccessfullyDone.
  ///
  /// In en, this message translates to:
  /// **'Your payment has been successfully done'**
  String get yourPaymentHasBeenSuccessfullyDone;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @paymentStatus.
  ///
  /// In en, this message translates to:
  /// **'Payment Status'**
  String get paymentStatus;

  /// No description provided for @orderNumber.
  ///
  /// In en, this message translates to:
  /// **'Order Number'**
  String get orderNumber;

  /// No description provided for @merchantName.
  ///
  /// In en, this message translates to:
  /// **'Merchant Name'**
  String get merchantName;

  /// No description provided for @paymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get paymentMethod;

  /// No description provided for @paymentDate.
  ///
  /// In en, this message translates to:
  /// **'Payment Date'**
  String get paymentDate;

  /// No description provided for @senderName.
  ///
  /// In en, this message translates to:
  /// **'Sender Name'**
  String get senderName;

  /// No description provided for @backToHome.
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get backToHome;

  /// No description provided for @addToYourCart.
  ///
  /// In en, this message translates to:
  /// **'Add to your cart'**
  String get addToYourCart;

  /// No description provided for @addedToYourCart.
  ///
  /// In en, this message translates to:
  /// **'{productName} Added to your cart'**
  String addedToYourCart(String productName);

  /// No description provided for @productDetails.
  ///
  /// In en, this message translates to:
  /// **'Product Details'**
  String get productDetails;

  /// No description provided for @quantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get quantity;

  /// No description provided for @color.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get color;

  /// No description provided for @size.
  ///
  /// In en, this message translates to:
  /// **'Size'**
  String get size;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @addToCart.
  ///
  /// In en, this message translates to:
  /// **'Add to Cart'**
  String get addToCart;

  /// No description provided for @bingoChatBot.
  ///
  /// In en, this message translates to:
  /// **'Bingo Chat Bot'**
  String get bingoChatBot;

  /// No description provided for @official.
  ///
  /// In en, this message translates to:
  /// **'@Official'**
  String get official;

  /// No description provided for @sendMessage.
  ///
  /// In en, this message translates to:
  /// **'Send Message'**
  String get sendMessage;

  /// No description provided for @microphonePermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Microphone permission denied'**
  String get microphonePermissionDenied;

  /// No description provided for @filterByPrice.
  ///
  /// In en, this message translates to:
  /// **'Filter By Price'**
  String get filterByPrice;

  /// No description provided for @accountInfo.
  ///
  /// In en, this message translates to:
  /// **'Account Info'**
  String get accountInfo;

  /// No description provided for @savedAddress.
  ///
  /// In en, this message translates to:
  /// **'Saved Address'**
  String get savedAddress;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @newAddress.
  ///
  /// In en, this message translates to:
  /// **'New Address'**
  String get newAddress;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @enterYourFullName.
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get enterYourFullName;

  /// No description provided for @streetAddress.
  ///
  /// In en, this message translates to:
  /// **'Street Address'**
  String get streetAddress;

  /// No description provided for @enterYourStreetAddress.
  ///
  /// In en, this message translates to:
  /// **'Enter your street address'**
  String get enterYourStreetAddress;

  /// No description provided for @streetAddressIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Street address is required'**
  String get streetAddressIsRequired;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// No description provided for @enterYourCity.
  ///
  /// In en, this message translates to:
  /// **'Enter your city'**
  String get enterYourCity;

  /// No description provided for @cityIsRequired.
  ///
  /// In en, this message translates to:
  /// **'City is required'**
  String get cityIsRequired;

  /// No description provided for @stateProvince.
  ///
  /// In en, this message translates to:
  /// **'State/Province'**
  String get stateProvince;

  /// No description provided for @enterYourSateOrProvince.
  ///
  /// In en, this message translates to:
  /// **'Enter your state or province'**
  String get enterYourSateOrProvince;

  /// No description provided for @stateProvinceIsRequired.
  ///
  /// In en, this message translates to:
  /// **'State/Province is required'**
  String get stateProvinceIsRequired;

  /// No description provided for @zipCode.
  ///
  /// In en, this message translates to:
  /// **'ZIP Code'**
  String get zipCode;

  /// No description provided for @enterYourZIPCode.
  ///
  /// In en, this message translates to:
  /// **'Enter your ZIP code'**
  String get enterYourZIPCode;

  /// No description provided for @zipCodeIsRequired.
  ///
  /// In en, this message translates to:
  /// **' ZIP code is required'**
  String get zipCodeIsRequired;

  /// No description provided for @country.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get country;

  /// No description provided for @enterYourCountry.
  ///
  /// In en, this message translates to:
  /// **'Enter your country'**
  String get enterYourCountry;

  /// No description provided for @countryIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Country is required'**
  String get countryIsRequired;

  /// No description provided for @setAsDefaultAddress.
  ///
  /// In en, this message translates to:
  /// **'Set as default address'**
  String get setAsDefaultAddress;

  /// No description provided for @thisAddressWillBeYsedAsYourDefaultShippingAddress.
  ///
  /// In en, this message translates to:
  /// **'This address will be used as your default shipping address'**
  String get thisAddressWillBeYsedAsYourDefaultShippingAddress;

  /// No description provided for @saveAddress.
  ///
  /// In en, this message translates to:
  /// **'Save Address'**
  String get saveAddress;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @areYouSureYouWantToDeleteYourAccount.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete your account'**
  String get areYouSureYouWantToDeleteYourAccount;

  /// No description provided for @areYouASellerOrBuyer.
  ///
  /// In en, this message translates to:
  /// **'Are You a seller Or Buyer'**
  String get areYouASellerOrBuyer;

  /// No description provided for @buyingOrSellingWeHaveGotYourBackAndMake.
  ///
  /// In en, this message translates to:
  /// **'Buying or selling? We\'ve got your back and make'**
  String get buyingOrSellingWeHaveGotYourBackAndMake;

  /// No description provided for @itSuperEasyForYou.
  ///
  /// In en, this message translates to:
  /// **'it super easy for you!'**
  String get itSuperEasyForYou;

  /// No description provided for @seller.
  ///
  /// In en, this message translates to:
  /// **'Seller'**
  String get seller;

  /// No description provided for @buyer.
  ///
  /// In en, this message translates to:
  /// **'Buyer'**
  String get buyer;

  /// No description provided for @continu.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continu;

  /// No description provided for @buildYourStore.
  ///
  /// In en, this message translates to:
  /// **'Build your store'**
  String get buildYourStore;

  /// No description provided for @pngOrJpgFormat.
  ///
  /// In en, this message translates to:
  /// **'PNG or JPG format'**
  String get pngOrJpgFormat;

  /// No description provided for @nameYourShop.
  ///
  /// In en, this message translates to:
  /// **'Name your shop'**
  String get nameYourShop;

  /// No description provided for @between420Characters.
  ///
  /// In en, this message translates to:
  /// **'Between 4-20 Character'**
  String get between420Characters;

  /// No description provided for @noSpercialCharactersSpaces.
  ///
  /// In en, this message translates to:
  /// **'No special characters, spaces'**
  String get noSpercialCharactersSpaces;

  /// No description provided for @chooseAUniqueName.
  ///
  /// In en, this message translates to:
  /// **'Choose a unique name'**
  String get chooseAUniqueName;

  /// No description provided for @aboutStore.
  ///
  /// In en, this message translates to:
  /// **'About Store'**
  String get aboutStore;

  /// No description provided for @descripeYourShop.
  ///
  /// In en, this message translates to:
  /// **'Descripe your shop'**
  String get descripeYourShop;

  /// No description provided for @shopAddedSuccessfuly.
  ///
  /// In en, this message translates to:
  /// **'Shop added successfuly'**
  String get shopAddedSuccessfuly;

  /// No description provided for @faildToAddShop.
  ///
  /// In en, this message translates to:
  /// **'Failed to add shop'**
  String get faildToAddShop;

  /// No description provided for @addShop.
  ///
  /// In en, this message translates to:
  /// **'Add Shop'**
  String get addShop;

  /// No description provided for @selectCategories.
  ///
  /// In en, this message translates to:
  /// **'Select Categories'**
  String get selectCategories;

  /// No description provided for @pickFromGallry.
  ///
  /// In en, this message translates to:
  /// **'Pick from Gallery'**
  String get pickFromGallry;

  /// No description provided for @takePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take Photo'**
  String get takePhoto;

  /// No description provided for @openingHours.
  ///
  /// In en, this message translates to:
  /// **'Opening Hours'**
  String get openingHours;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get loading;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
