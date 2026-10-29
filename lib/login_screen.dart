import 'package:auto_tire/main_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  final _loginCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  bool _obscure = true;

  // Ranglar
  final Color _fieldBg = Color(0xFF141416);
  final Color _border = Color(0x26FFFFFF);
  final Color _borderFocus = Color(0x80FFFFFF);
  final Color _textMuted = Color(0xFF8A8A8F);
  final Color _textSoft = Color(0xFFB4B4B9);
  final Color _error = Color(0xFFFF6B6B);

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _loginCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  // Formani tekshirish va asosiy sahifaga o'tish
  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => AutoTireMainScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final w = constraints.maxWidth;
          final h = constraints.maxHeight;

          final isMobile = w < 700;
          final contentWidth = isMobile ? w : w * 0.52;
          final imageWidth = w - contentWidth;

          return Stack(
            fit: StackFit.expand,
            children: [
              // Asosiy qora fon
              Container(color: Colors.black),

              // O'ng tomondagi shina rasmi
              if (!isMobile)
                Positioned(
                  top: 0,
                  right: 0,
                  bottom: 0,
                  width: imageWidth,
                  child: ShaderMask(
                    blendMode: BlendMode.dstIn,
                    shaderCallback: (rect) {
                      return LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                          Colors.black,
                        ],
                        stops: [0.0, 0.22, 0.65],
                      ).createShader(rect);
                    },
                    child: Image.asset(
                      'assets/tire_photo.png',
                      fit: BoxFit.cover,
                      alignment: Alignment.centerRight,
                      errorBuilder: (context, error, stack) {
                        debugPrint('Rasm yuklanmadi: $error');
                        return Container(color: Colors.black);
                      },
                    ),
                  ),
                ),

              // Kontent: chap tomonda, scrollsiz
              Align(
                alignment: isMobile ? Alignment.center : Alignment.centerLeft,
                child: SizedBox(
                  width: contentWidth,
                  height: h,
                  child: SafeArea(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 26 : 48,
                        vertical: 12,
                      ),
                      child: Center(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: SizedBox(
                            width: contentWidth - (isMobile ? 52 : 96),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: 460),
                              child: _buildContent(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildContent() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sarlavha
          Text(
            'Xush kelibsiz',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.7,
            ),
          ),

          // SizedBox(height: 8),
          Text(
            'Tizimga kirish uchun ma’lumotlaringizni kiriting.',
            style: TextStyle(color: _textSoft, fontSize: 14, height: 1.5),
          ),

          SizedBox(height: 24),

          // Ism
          _buildField(
            label: 'Ism',
            hint: 'Ismingizni kiriting',
            icon: Icons.person_outline_rounded,
            controller: _firstNameCtrl,
            action: TextInputAction.next,
            validator: (v) {
              return v == null || v.trim().isEmpty ? 'Ismni kiriting' : null;
            },
          ),

          SizedBox(height: 14),

          // Familiya
          _buildField(
            label: 'Familiya',
            hint: 'Familiyangizni kiriting',
            icon: Icons.person_outline_rounded,
            controller: _lastNameCtrl,
            action: TextInputAction.next,
            validator: (v) {
              return v == null || v.trim().isEmpty
                  ? 'Familiyani kiriting'
                  : null;
            },
          ),

          SizedBox(height: 14),

          // Login
          // Email
          _buildField(
            label: 'Gmail',
            hint: 'example@gmail.com',
            icon: Icons.alternate_email_rounded,
            controller: _loginCtrl,
            action: TextInputAction.next,
            validator: (v) {
              if (v == null || v.trim().isEmpty) {
                return 'Gmail manzilingizni kiriting';
              }

              final email = v.trim();

              if (!RegExp(r'^[a-z0-9._%+-]+@gmail\.com$').hasMatch(email)) {
                return 'Faqat kichik harflarda, @gmail.com bilan kiriting';
              }

              return null;
            },
          ),

          SizedBox(height: 14),

          // Parol
          _buildField(
            label: 'Parol',
            hint: 'Parolingizni kiriting',
            icon: Icons.lock_outline_rounded,
            controller: _passwordCtrl,
            obscure: _obscure,
            action: TextInputAction.done,
            onSubmitted: (_) => _submit(),
            validator: (v) {
              if (v == null || v.isEmpty) {
                return 'Parolni kiriting';
              }

              if (v.length < 8) {
                return 'Parol kamida 8 ta belgidan iborat bo‘lishi kerak';
              }

              return null;
            },
            suffix: IconButton(
              onPressed: () {
                setState(() {
                  _obscure = !_obscure;
                });
              },
              icon: Icon(
                _obscure
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: _textMuted,
                size: 20,
              ),
            ),
          ),

          SizedBox(height: 26),

          // Kirish tugmasi
          SizedBox(
            width: double.infinity,
            height: 52,
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              color: Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(13),
              onPressed: _submit,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Tizimga kirish',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.2,
                    ),
                  ),
                  SizedBox(width: 10),
                  Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.black,
                    size: 19,
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 24),

          // Footer
          Center(
            child: Text(
              'AutoTire · Do‘koningiz boshqaruvi bir joyda',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _textMuted,
                fontSize: 12,
                letterSpacing: 0.1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Barcha inputlar uchun umumiy dizayn
  Widget _buildField({
    required String label,
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    String? Function(String?)? validator,
    TextInputAction? action,
    ValueChanged<String>? onSubmitted,
    bool obscure = false,
    Widget? suffix,
  }) {
    OutlineInputBorder makeBorder(Color color) {
      return OutlineInputBorder(
        borderRadius: BorderRadius.circular(13),
        borderSide: BorderSide(color: color, width: 1.5),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),

        SizedBox(height: 8),

        TextFormField(
          controller: controller,
          obscureText: obscure,
          validator: validator,
          textInputAction: action,
          onFieldSubmitted: onSubmitted,
          cursorColor: Colors.white,
          style: TextStyle(color: Colors.white, fontSize: 14),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: _textMuted, fontSize: 14),
            filled: true,
            fillColor: _fieldBg,
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            prefixIcon: Icon(icon, color: _textMuted, size: 21),
            prefixIconConstraints: BoxConstraints(minWidth: 48, minHeight: 48),
            suffixIcon: suffix,
            errorStyle: TextStyle(color: _error, fontSize: 12),
            enabledBorder: makeBorder(_border),
            focusedBorder: makeBorder(_borderFocus),
            errorBorder: makeBorder(_error.withOpacity(0.7)),
            focusedErrorBorder: makeBorder(_error),
          ),
        ),
      ],
    );
  }
}
