// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class BoshSahifaAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final String formattedDate;
//   final TextEditingController? searchController;
//   final ValueChanged<String>? onSearchChanged;
//   final VoidCallback? onNotification;
//   final VoidCallback? onProfile;

//   BoshSahifaAppBar({
//     super.key,
//     required this.formattedDate,
//     this.searchController,
//     this.onSearchChanged,
//     this.onNotification,
//     this.onProfile,
//   });

//   @override
//   Size get preferredSize => Size.fromHeight(60);

//   @override
//   Widget build(BuildContext context) {
//     return PreferredSize(
//       preferredSize: Size.fromHeight(60),
//       child: Container(
//         decoration: BoxDecoration(
//           border: Border(
//             bottom: BorderSide(color: Color(0xFF2A2A2A), width: 1),
//           ),
//         ),
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 24),
//           child: AppBar(
//             backgroundColor: Colors.black,
//             elevation: 0,
//             scrolledUnderElevation: 0,
//             centerTitle: true,
//             titleSpacing: 0,
//             leadingWidth: 120,
//             leading: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'Bosh sahifa',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//             title: Container(
//               width: 275,
//               height: 35,
//               decoration: BoxDecoration(
//                 color: Colors.black,
//                 borderRadius: BorderRadius.circular(8),
//                 border: Border.all(
//                   color: Focus.of(context).hasFocus
//                       ? Color(0xFF555555)
//                       : Color(0xFF2A2A2A),
//                   width: 1.5,
//                 ),
//               ),
//               child: TextField(
//                 controller: searchController,
//                 onChanged: onSearchChanged,
//                 cursorColor: Colors.white,
//                 cursorWidth: 1.5,
//                 cursorHeight: 15,
//                 style: TextStyle(color: Colors.white, fontSize: 12.5),
//                 textAlignVertical: TextAlignVertical.center,
//                 decoration: InputDecoration(
//                   hintText: 'Sotuvni qidirish...',
//                   hintStyle: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.w400,
//                     fontSize: 13,
//                   ),
//                   isDense: true,
//                   prefixIcon: Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 8),
//                     child: Icon(
//                       Icons.search_rounded,
//                       color: Colors.white,
//                       size: 16,
//                     ),
//                   ),
//                   prefixIconConstraints: BoxConstraints(
//                     minWidth: 32,
//                     minHeight: 32,
//                   ),
//                   border: InputBorder.none,
//                   contentPadding: EdgeInsets.zero,
//                 ),
//               ),
//             ),
//             actions: [
//               CupertinoButton(
//                 padding: EdgeInsets.zero,
//                 minimumSize: Size(0, 0),
//                 onPressed: () {},
//                 child: Container(
//                   padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     border: Border.all(color: Color(0xFF2A2A2A), width: 1.5),
//                   ),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Icon(
//                         Icons.calendar_month_outlined,
//                         color: Colors.white,
//                         size: 15,
//                       ),
//                       SizedBox(width: 8),
//                       Text(
//                         formattedDate,
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 13,
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(width: 8),
//               CupertinoButton(
//                 padding: EdgeInsets.zero,
//                 minimumSize: Size(0, 0),
//                 onPressed: onNotification,
//                 child: Container(
//                   width: 40,
//                   height: 40,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(color: Color(0xFF2A2A2A), width: 1.5),
//                   ),
//                   child: Center(
//                     child: Icon(
//                       Icons.notifications_none,
//                       color: Colors.white,
//                       size: 18,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(width: 8),
//               CupertinoButton(
//                 padding: EdgeInsets.zero,
//                 minimumSize: Size(0, 0),
//                 onPressed: onProfile,
//                 child: SizedBox(
//                   width: 40,
//                   height: 40,
//                   child: Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       Container(
//                         width: 40,
//                         height: 40,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           border: Border.all(
//                             color: Color(0xFF38332E),
//                             width: 2.5,
//                           ),
//                         ),
//                       ),
//                       Container(
//                         width: 30,
//                         height: 30,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: Color(0xFF121212),
//                         ),
//                         child: Center(
//                           child: Text(
//                             'JE',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 13,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:auto_tire/login_screen.dart';

class BoshSahifaAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String formattedDate;
  final String firstName;
  final String lastName;
  final String login;
  final String phone;
  final String password;
  final String storeName;
  final String storeAddress;

  final TextEditingController? searchController;
  final ValueChanged<String>? onSearchChanged;
  final VoidCallback? onProfile;
  final VoidCallback? onStoreProfile;
  final VoidCallback? onLogout;

  const BoshSahifaAppBar({
    super.key,
    required this.formattedDate,
    this.firstName = 'Jaloliddin',
    this.lastName = 'Egamberdiyev',
    this.login = '',
    this.phone = '',
    this.password = '',
    this.storeName = 'Auto Tire',
    this.storeAddress = 'Manzil kiritilmagan',
    this.searchController,
    this.onSearchChanged,
    this.onProfile,
    this.onStoreProfile,
    this.onLogout,
  });

  static const Color background = Color(0xFF000000);
  static const Color card = Color(0xFF121212);
  static const Color border = Color(0xFF2A2A2A);
  static const Color muted = Color(0xFF999999);
  static const Color fieldBg = Color(0xFF181818);

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  State<BoshSahifaAppBar> createState() => _BoshSahifaAppBarState();
}

class _BoshSahifaAppBarState extends State<BoshSahifaAppBar> {
  late String firstName;
  late String lastName;
  late String login;
  late String phone;
  late String password;
  late String storeName;
  late String storeAddress;

  @override
  void initState() {
    super.initState();
    _loadValues();
  }

  @override
  void didUpdateWidget(covariant BoshSahifaAppBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.firstName != widget.firstName ||
        oldWidget.lastName != widget.lastName ||
        oldWidget.login != widget.login ||
        oldWidget.phone != widget.phone ||
        oldWidget.password != widget.password ||
        oldWidget.storeName != widget.storeName ||
        oldWidget.storeAddress != widget.storeAddress) {
      _loadValues();
    }
  }

  void _loadValues() {
    firstName = widget.firstName;
    lastName = widget.lastName;
    login = widget.login;
    phone = widget.phone;
    password = widget.password;
    storeName = widget.storeName;
    storeAddress = widget.storeAddress;
  }

  // Matnni tahrirlash oynasi
  Future<String?> _editValue({
    required String title,
    required String initialValue,
    required String hint,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
  }) async {
    final controller = TextEditingController(text: initialValue);

    final result = await showDialog<String>(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: BoshSahifaAppBar.card,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            side: const BorderSide(color: BoshSahifaAppBar.border),
          ),
          child: Container(
            width: 400,
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: controller,
                  autofocus: true,
                  maxLines: maxLines,
                  keyboardType: keyboardType,
                  inputFormatters: inputFormatters,
                  cursorColor: Colors.white,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: const TextStyle(
                      color: BoshSahifaAppBar.muted,
                      fontSize: 13,
                    ),
                    filled: true,
                    fillColor: BoshSahifaAppBar.fieldBg,
                    contentPadding: const EdgeInsets.all(15),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: BoshSahifaAppBar.border,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.white54),
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(dialogContext),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: const BorderSide(
                            color: BoshSahifaAppBar.border,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 13),
                        ),
                        child: const Text('Bekor qilish'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          final value = controller.text.trim();

                          if (value.isEmpty) return;

                          Navigator.pop(dialogContext, value);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 13),
                        ),
                        child: const Text(
                          'Saqlash',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );

    controller.dispose();
    return result;
  }

  // Telefonni 90 123 45 67 ko'rinishida formatlash
  String _formatPhone(String value) {
    final digits = value.replaceAll(RegExp(r'\D'), '');
    final local = digits.startsWith('998') && digits.length > 9
        ? digits.substring(3)
        : digits;

    final limited = local.length > 9 ? local.substring(0, 9) : local;
    final buffer = StringBuffer();

    for (int i = 0; i < limited.length; i++) {
      if (i == 2 || i == 5 || i == 7) {
        buffer.write(' ');
      }
      buffer.write(limited[i]);
    }

    return buffer.toString();
  }

  List<TextInputFormatter> get _phoneFormatters => [
    FilteringTextInputFormatter.digitsOnly,
    _UzPhoneFormatter(),
  ];

  // Profil ma'lumotlari
  Future<void> _showProfile() async {
    if (widget.onProfile != null) {
      widget.onProfile!();
      return;
    }

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            Future<void> editField({
              required String title,
              required String value,
              required String hint,
              required ValueChanged<String> onSave,
              TextInputType keyboardType = TextInputType.text,
              List<TextInputFormatter>? formatters,
            }) async {
              final result = await _editValue(
                title: title,
                initialValue: value,
                hint: hint,
                keyboardType: keyboardType,
                inputFormatters: formatters,
              );

              if (result != null && mounted) {
                setState(() => onSave(result));
                setDialogState(() {});
              }
            }

            return _infoDialog(
              title: 'Profil ma’lumotlari',
              subtitle: 'Shaxsiy hisobingiz',
              icon: Icons.person_outline_rounded,
              items: [
                _InfoItem(
                  icon: Icons.badge_outlined,
                  label: 'Ism',
                  value: firstName,
                  editable: true,
                  onEdit: () => editField(
                    title: 'Ismni o‘zgartirish',
                    value: firstName,
                    hint: 'Ismingiz',
                    onSave: (v) => firstName = v,
                  ),
                ),
                _InfoItem(
                  icon: Icons.person_outline_rounded,
                  label: 'Familiya',
                  value: lastName,
                  editable: true,
                  onEdit: () => editField(
                    title: 'Familiyani o‘zgartirish',
                    value: lastName,
                    hint: 'Familiyangiz',
                    onSave: (v) => lastName = v,
                  ),
                ),
                _InfoItem(
                  icon: Icons.alternate_email_rounded,
                  label: 'Gmail / Login',
                  value: login.isEmpty ? 'Kiritilmagan' : login,
                  editable: true,
                  onEdit: () => editField(
                    title: 'Gmailni o‘zgartirish',
                    value: login,
                    hint: 'example@gmail.com',
                    keyboardType: TextInputType.emailAddress,
                    onSave: (v) => login = v,
                  ),
                ),
                _InfoItem(
                  icon: Icons.phone_outlined,
                  label: 'Telefon raqami',
                  value: phone.isEmpty
                      ? 'Kiritilmagan'
                      : '+998 ${_formatPhone(phone)}',
                  editable: true,
                  onEdit: () => editField(
                    title: 'Telefon raqamini o‘zgartirish',
                    value: _formatPhone(phone),
                    hint: '90 123 45 67',
                    keyboardType: TextInputType.phone,
                    formatters: _phoneFormatters,
                    onSave: (v) => phone = v,
                  ),
                ),
                _InfoItem(
                  icon: Icons.lock_outline_rounded,
                  label: 'Parol',
                  value: password.isEmpty ? 'Kiritilmagan' : '••••••••',
                  editable: true,
                  onEdit: () => editField(
                    title: 'Parolni o‘zgartirish',
                    value: password,
                    hint: 'Yangi parol',
                    onSave: (v) => password = v,
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // Do'kon ma'lumotlari
  Future<void> _showStore() async {
    if (widget.onStoreProfile != null) {
      widget.onStoreProfile!();
      return;
    }

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return _infoDialog(
              title: 'Do‘kon ma’lumotlari',
              subtitle: 'Magaziningiz haqida',
              icon: Icons.store_outlined,
              items: [
                _InfoItem(
                  icon: Icons.storefront_outlined,
                  label: 'Do‘kon nomi',
                  value: storeName,
                  editable: true,
                  onEdit: () async {
                    final result = await _editValue(
                      title: 'Do‘kon nomini o‘zgartirish',
                      initialValue: storeName,
                      hint: 'Do‘kon nomi',
                    );

                    if (result != null && mounted) {
                      setState(() => storeName = result);
                      setDialogState(() {});
                    }
                  },
                ),
                _InfoItem(
                  icon: Icons.location_on_outlined,
                  label: 'Manzil',
                  value: storeAddress.isEmpty
                      ? 'Manzil kiritilmagan'
                      : storeAddress,
                ),
              ],
            );
          },
        );
      },
    );
  }

  // Umumiy ma'lumot oynasi
  Widget _infoDialog({
    required String title,
    required String subtitle,
    required IconData icon,
    required List<_InfoItem> items,
  }) {
    return Dialog(
      backgroundColor: BoshSahifaAppBar.card,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: BoshSahifaAppBar.border),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 440),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(22),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: const Color(0xFF222222),
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: Icon(icon, color: Colors.white, size: 24),
                  ),
                  const SizedBox(width: 13),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: const TextStyle(
                            color: BoshSahifaAppBar.muted,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.close_rounded,
                      color: BoshSahifaAppBar.muted,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              const Divider(color: BoshSahifaAppBar.border, height: 1),
              const SizedBox(height: 8),
              ...items.map(
                (item) => Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 13,
                    vertical: 13,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF181818),
                    borderRadius: BorderRadius.circular(11),
                    border: Border.all(color: BoshSahifaAppBar.border),
                  ),
                  child: Row(
                    children: [
                      Icon(item.icon, color: BoshSahifaAppBar.muted, size: 20),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.label,
                              style: const TextStyle(
                                color: BoshSahifaAppBar.muted,
                                fontSize: 11,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              item.value,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (item.editable)
                        IconButton(
                          tooltip: 'Tahrirlash',
                          visualDensity: VisualDensity.compact,
                          onPressed: item.onEdit,
                          icon: const Icon(
                            Icons.edit_outlined,
                            color: Colors.white70,
                            size: 18,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 42,
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: BoshSahifaAppBar.border),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Yopish'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Tizimdan chiqishni tasdiqlash
  void _confirmLogout() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: BoshSahifaAppBar.card,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            side: const BorderSide(color: BoshSahifaAppBar.border),
          ),
          child: Container(
            width: 360,
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2B1919),
                    borderRadius: BorderRadius.circular(17),
                  ),
                  child: const Icon(
                    Icons.logout_rounded,
                    color: Color(0xFFF87171),
                    size: 28,
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  'Tizimdan chiqish',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 9),
                const Text(
                  'Haqiqatan ham tizimdan chiqmoqchimisiz?',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: BoshSahifaAppBar.muted, fontSize: 13),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(dialogContext),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: const BorderSide(
                            color: BoshSahifaAppBar.border,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 13),
                        ),
                        child: const Text('Bekor qilish'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(dialogContext);

                          if (widget.onLogout != null) {
                            widget.onLogout!();
                          } else {
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (_) => LoginScreen()),
                              (route) => false,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 13),
                        ),
                        child: const Text('Chiqish'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: BoshSahifaAppBar.border, width: 1),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: AppBar(
          backgroundColor: BoshSahifaAppBar.background,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          titleSpacing: 0,
          leadingWidth: 120,
          leading: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Bosh sahifa',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          title: Container(
            width: 275,
            height: 35,
            decoration: BoxDecoration(
              color: BoshSahifaAppBar.background,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: BoshSahifaAppBar.border, width: 1.5),
            ),
            child: TextField(
              controller: widget.searchController,
              onChanged: widget.onSearchChanged,
              cursorColor: Colors.white,
              cursorWidth: 1.5,
              style: const TextStyle(color: Colors.white, fontSize: 12.5),
              textAlignVertical: TextAlignVertical.center,
              decoration: const InputDecoration(
                hintText: 'Sotuvni qidirish...',
                hintStyle: TextStyle(color: Colors.white54, fontSize: 13),
                isDense: true,
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Icon(
                    Icons.search_rounded,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
                prefixIconConstraints: BoxConstraints(
                  minWidth: 32,
                  minHeight: 32,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          actions: [
            CupertinoButton(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              onPressed: () {},
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: BoshSahifaAppBar.border,
                    width: 1.5,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.calendar_month_outlined,
                      color: Colors.white,
                      size: 15,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      widget.formattedDate,
                      style: const TextStyle(color: Colors.white, fontSize: 13),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),

            // Profil menyusi
            PopupMenuButton<String>(
              tooltip: 'Profil',
              color: BoshSahifaAppBar.card,
              elevation: 12,
              offset: const Offset(0, 48),
              constraints: const BoxConstraints(minWidth: 245, maxWidth: 280),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: const BorderSide(color: BoshSahifaAppBar.border),
              ),
              onSelected: (value) {
                if (value == 'profile') {
                  _showProfile();
                } else if (value == 'store') {
                  _showStore();
                } else if (value == 'logout') {
                  _confirmLogout();
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem<String>(
                  value: 'profile',
                  height: 70,
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Color(0xFF252525),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.person_outline_rounded,
                          color: Colors.white,
                          size: 23,
                        ),
                      ),
                      const SizedBox(width: 11),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$firstName $lastName',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Profil ma’lumotlari',
                              style: TextStyle(
                                color: BoshSahifaAppBar.muted,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const PopupMenuItem<String>(
                  enabled: false,
                  height: 1,
                  padding: EdgeInsets.zero,
                  child: Divider(height: 1, color: BoshSahifaAppBar.border),
                ),
                const PopupMenuItem<String>(
                  value: 'store',
                  height: 44,
                  child: Row(
                    children: [
                      Icon(
                        Icons.store_outlined,
                        color: Colors.white70,
                        size: 19,
                      ),
                      SizedBox(width: 12),
                      Text(
                        'Do‘kon ma’lumotlari',
                        style: TextStyle(color: Colors.white, fontSize: 12.5),
                      ),
                    ],
                  ),
                ),
                const PopupMenuItem<String>(
                  enabled: false,
                  height: 1,
                  padding: EdgeInsets.zero,
                  child: Divider(height: 1, color: BoshSahifaAppBar.border),
                ),
                const PopupMenuItem<String>(
                  value: 'logout',
                  height: 44,
                  child: Row(
                    children: [
                      Icon(
                        Icons.logout_rounded,
                        color: Color(0xFFF87171),
                        size: 19,
                      ),
                      SizedBox(width: 12),
                      Text(
                        'Chiqish',
                        style: TextStyle(
                          color: Color(0xFFF87171),
                          fontSize: 12.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              child: SizedBox(
                width: 40,
                height: 40,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF38332E),
                          width: 2.5,
                        ),
                      ),
                    ),
                    Container(
                      width: 30,
                      height: 30,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: BoshSahifaAppBar.card,
                      ),
                      child: Center(
                        child: Text(
                          '${firstName.isNotEmpty ? firstName[0].toUpperCase() : ''}'
                          '${lastName.isNotEmpty ? lastName[0].toUpperCase() : ''}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 4),
          ],
        ),
      ),
    );
  }
}

class _InfoItem {
  final IconData icon;
  final String label;
  final String value;
  final bool editable;
  final VoidCallback? onEdit;

  const _InfoItem({
    required this.icon,
    required this.label,
    required this.value,
    this.editable = false,
    this.onEdit,
  });
}

// Telefon raqamini avtomatik formatlash
class _UzPhoneFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String digits = newValue.text.replaceAll(RegExp(r'\D'), '');

    if (digits.length > 9) {
      digits = digits.substring(0, 9);
    }

    final buffer = StringBuffer();

    for (int i = 0; i < digits.length; i++) {
      if (i == 2 || i == 5 || i == 7) {
        buffer.write(' ');
      }
      buffer.write(digits[i]);
    }

    final formatted = buffer.toString();

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
