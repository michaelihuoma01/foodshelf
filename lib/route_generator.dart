import 'package:flutter/material.dart';
import 'package:foodshelf/screens/auth/forgot_password.dart';
import 'package:foodshelf/screens/auth/login.dart';
import 'package:foodshelf/screens/auth/new_password.dart';
import 'package:foodshelf/screens/auth/signup.dart';
import 'package:foodshelf/screens/auth/verification.dart';
import 'package:foodshelf/screens/main_page.dart';
import 'package:foodshelf/screens/pages/about_us.dart';
import 'package:foodshelf/screens/pages/change_language.dart';
import 'package:foodshelf/screens/pages/change_password.dart';
import 'package:foodshelf/screens/pages/checkout.dart';
import 'package:foodshelf/screens/pages/contact_us.dart';
import 'package:foodshelf/screens/pages/delivery_address.dart';
import 'package:foodshelf/screens/pages/details.dart';
import 'package:foodshelf/screens/pages/edit_profile.dart';
import 'package:foodshelf/screens/pages/faqs.dart';
import 'package:foodshelf/screens/pages/my_orders.dart';
import 'package:foodshelf/screens/pages/order_summary.dart';
import 'package:foodshelf/screens/pages/payment.dart';
import 'package:foodshelf/screens/pages/payment_summary.dart';
import 'package:foodshelf/screens/pages/search.dart';
import 'package:foodshelf/screens/pages/t_and_c.dart';
import 'package:foodshelf/screens/tabs/cart_tab.dart';
import 'package:foodshelf/screens/tabs/home_tab.dart';
import 'package:foodshelf/screens/tabs/notifications_tab.dart';
import 'package:foodshelf/screens/tabs/profile_tab.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
//    final args = settings.arguments;
    switch (settings.name) {
      case LoginPage.routeName:
        return MaterialPageRoute(
          builder: (_) => LoginPage(),
          settings: RouteSettings(name: LoginPage.routeName),
        );
      case SignUpPage.routeName:
        return MaterialPageRoute(
          builder: (_) => SignUpPage(),
          settings: RouteSettings(name: SignUpPage.routeName),
        );
      case ForgotPassword.routeName:
        return MaterialPageRoute(
          builder: (_) => ForgotPassword(),
          settings: RouteSettings(name: ForgotPassword.routeName),
        );
      case NewPasswordPage.routeName:
        return MaterialPageRoute(
          builder: (_) => NewPasswordPage(),
          settings: RouteSettings(name: NewPasswordPage.routeName),
        );
      case VerificationPage.routeName:
        return MaterialPageRoute(
          builder: (_) => VerificationPage(),
          settings: RouteSettings(name: VerificationPage.routeName),
        );
      case AboutUs.routeName:
        return MaterialPageRoute(
          builder: (_) => AboutUs(),
          settings: RouteSettings(name: AboutUs.routeName),
        );
      case ChangeLanguage.routeName:
        return MaterialPageRoute(
          builder: (_) => ChangeLanguage(),
          settings: RouteSettings(name: ChangeLanguage.routeName),
        );
      case ChangePassword.routeName:
        return MaterialPageRoute(
          builder: (_) => ChangePassword(),
          settings: RouteSettings(name: ChangePassword.routeName),
        );
      case CheckoutScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => CheckoutScreen(),
          settings: RouteSettings(name: CheckoutScreen.routeName),
        );
      case NotificationsTab.routeName:
        return MaterialPageRoute(
          builder: (cxt) => NotificationsTab(),
          settings: RouteSettings(name: NotificationsTab.routeName),
        );
      case ContactUs.routeName:
        return MaterialPageRoute(
          builder: (cxt) => ContactUs(),
          settings: RouteSettings(name: ContactUs.routeName),
        );
      case DeliveryAddress.routeName:
        return MaterialPageRoute(
          builder: (cxt) => DeliveryAddress(),
          settings: RouteSettings(name: DeliveryAddress.routeName),
        );
      case DetailsPage.routeName:
        return MaterialPageRoute(
          builder: (cxt) => DetailsPage(),
          settings: RouteSettings(name: DetailsPage.routeName),
        );
      case EditProfile.routeName:
        return MaterialPageRoute(
          builder: (cxt) => EditProfile(),
          settings: RouteSettings(name: EditProfile.routeName),
        );
      case Faqs.routeName:
        return MaterialPageRoute(
          builder: (cxt) => Faqs(),
          settings: RouteSettings(name: Faqs.routeName),
        );
      case MyOrders.routeName:
        return MaterialPageRoute(
          builder: (cxt) => MyOrders(),
          settings: RouteSettings(name: MyOrders.routeName),
        );
      case OrderSummary.routeName:
        return MaterialPageRoute(
          builder: (cxt) => OrderSummary(),
          settings: RouteSettings(name: OrderSummary.routeName),
        );
      case PaymentSummary.routeName:
        return MaterialPageRoute(
          builder: (cxt) => PaymentSummary(),
          settings: RouteSettings(name: PaymentSummary.routeName),
        );
      case PaymentScreen.routeName:
        return MaterialPageRoute(
          builder: (cxt) => PaymentScreen(),
          settings: RouteSettings(name: PaymentScreen.routeName),
        );
      case SearchPage.routeName:
        return MaterialPageRoute(
          builder: (cxt) => SearchPage(),
          settings: RouteSettings(name: SearchPage.routeName),
        );
      case TandC.routeName:
        return MaterialPageRoute(
          builder: (cxt) => TandC(),
          settings: RouteSettings(name: TandC.routeName),
        );
      case MainPage.routeName:
        return MaterialPageRoute(
          builder: (cxt) => MainPage(),
          settings: RouteSettings(name: MainPage.routeName),
        );
      case CartTab.routeName:
        return MaterialPageRoute(
          builder: (cxt) => CartTab(),
          settings: RouteSettings(name: CartTab.routeName),
        );
      case HomeTab.routeName:
        return MaterialPageRoute(
          builder: (cxt) => HomeTab(),
          settings: RouteSettings(name: HomeTab.routeName),
        );
      case ProfileTab.routeName:
        return MaterialPageRoute(
          builder: (cxt) => ProfileTab(),
          settings: RouteSettings(name: ProfileTab.routeName),
        );

      default:
        // If there is no such named route in the switch statement, e.g. /third
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                body: SafeArea(
                    child: Text('An error occured, please try again'))));
    }
  }
}
