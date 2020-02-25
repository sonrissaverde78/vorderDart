
import 'package:virtualorder_app/model/user.dart';


class Local extends User{

  // virtual-order-es Firestore Fields
  String cif;
  String capacity;
  String geolocation;
  String localName;
  String logo;
  // Collections
  String drinks;
  String images;
  String plates;

  initUserDataLocal  (String address, String city,
      String country, String email, String name, String phone,
      String postalcode, String surname, String uid,
      ){

    super.init(  address, city,  country, email, name,
                    phone, postalcode, surname,
                   uid, "LOCAL");
  }

  initLocalData ( String cif,
                  String capacity,
                  String geolocation,
                  String localName,
                  String logo
      )
  {
    print ("===> Local initLocal stars");
    this.cif = cif;
    this.capacity = capacity;
    this.geolocation = geolocation;
    this.localName = localName;
    this.logo = logo;
    print ("===> Local initLocal ends");

  }


}
