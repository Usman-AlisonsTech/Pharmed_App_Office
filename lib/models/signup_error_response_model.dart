class SignUpErrorResponse {
    SignUpErrorResponse({
        required this.success,
        required this.message,
    });

    final bool? success;
    final String? message;

    SignUpErrorResponse copyWith({
        bool? success,
        String? message,
    }) {
        return SignUpErrorResponse(
            success: success ?? this.success,
            message: message ?? this.message,
        );
    }

    factory SignUpErrorResponse.fromJson(Map<String, dynamic> json){ 
        return SignUpErrorResponse(
            success: json["success"],
            message: json["message"],
        );
    }

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
    };

}
