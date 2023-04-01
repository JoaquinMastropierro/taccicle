class User {

    User({
        required this.idUser,
        required this.username,
        this.email,
        required this.avatar
    });

    int idUser;
    String username;
    String? email;
    String? avatar;

    factory User.fromJson(Map<String, dynamic> json) => User(
        idUser: json["idUser"],
        username: json["username"],
        email: json["email"],
        avatar: json["avatar"],
    );

    Map<String, dynamic> toJson() => {
        "idUser": idUser,
        "username": username,
        "email": email,
    };

    static String? validateUsername(String? username){
      
      if(username == null) return "Minimo 4 caracteres";

      if(username.length < 4) return "Minimo 4 caracteres";

      final validCharacters = RegExp(r'^[A-Za-z][A-Za-z0-9_]{3,29}$');

      bool esValido = validCharacters.hasMatch(username);

      if(!esValido) return "No se aceptan caracteres especiales";

      return null;
    }
}
