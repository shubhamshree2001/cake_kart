
class UserModel {

  final String uid;
  final String name;
  final String pNo;
  final String rNo;
  final String bio;

  UserModel(
    {
      this.uid,
      this.name = "John Doe",
      this.pNo = "8626075449",
      this.rNo = "TECOB201",
      this.bio = "Enter your bio here!",
    }
  ) ;

}