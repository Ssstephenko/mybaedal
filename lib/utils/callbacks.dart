/// 일반적인 Callback 타입을 정의
typedef V KeyCallback<K, V>(K id);

/// 출력값이 없는 Callback 타입을 정의
typedef void VoidKeyCallback<K>(K id);
