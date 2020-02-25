
class User{

  String user;
  String address;
  String city; 
  String country; 
  String name; 
  String surname; 
  String email; 
  String postalCode; 
  String phone; 
  String type; 
  String uid; 
  String userType;


  
  void init ( String address, String city, String country, String email, String name, String phone, String postalcode, String surname, String uid, String userType){

    this.city = city; 
    this.country = country; 
    this.name = name; 
    this.surname = surname; 
    this.email = email; 
    this.postalCode = postalcode; 
    this.phone = phone; 
    this.uid = uid; 
    this.address = address;
    this.userType = userType;
  }


  
}
