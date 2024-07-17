import 'package:flutter/material.dart';

class AnimatedDropdownIstanbul extends StatefulWidget {
  @override
  _AnimatedDropdownIstanbulState createState() => _AnimatedDropdownIstanbulState();
}

class _AnimatedDropdownIstanbulState extends State<AnimatedDropdownIstanbul> with SingleTickerProviderStateMixin {
  bool _isOpen = false;
  late AnimationController _controller;
  late Animation<double> _heightFactor;
  String? _selectedItem;
  List<String> _items = [
    'Adalar', 'Arnavutköy', 'Ataşehir', 'Avcılar', 'Bağcılar', 'Bahçelievler',
    'Bakırköy', 'Başakşehir', 'Bayrampaşa', 'Beşiktaş', 'Beykoz', 'Beylikdüzü',
    'Beyoğlu', 'Büyükçekmece', 'Çatalca', 'Çekmeköy', 'Esenler', 'Esenyurt',
    'Eyüpsultan', 'Fatih', 'Gaziosmanpaşa', 'Güngören', 'Kadıköy', 'Kağıthane',
    'Kartal', 'Küçükçekmece', 'Maltepe', 'Pendik', 'Sancaktepe', 'Sarıyer',
    'Silivri', 'Sultanbeyli', 'Sultangazi', 'Şile', 'Şişli', 'Tuzla',
    'Ümraniye', 'Üsküdar', 'Zeytinburnu'
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );

    _heightFactor = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  void _toggleDropdown() {
    setState(() {
      if (_isOpen) {
        _controller.reverse();
      } else {
        _controller.forward();
      }
      _isOpen = !_isOpen;
    });
  }

  void _selectItem(String item) {
    setState(() {
      _selectedItem = item;
      _isOpen = false;
      _controller.reverse();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: _toggleDropdown,
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _selectedItem ?? 'İstanbul İlçeleri',
                  style: TextStyle(color: Colors.white),
                ),
                Icon(
                  _isOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
        SizeTransition(
          sizeFactor: _heightFactor,
          axisAlignment: -1.0,
          child: Container(
            height: 150, // Kaydırılabilir alan yüksekliği
            padding: EdgeInsets.all(8),
            color: Colors.blue[50],
            child: ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                return _buildDropdownItem(_items[index]);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownItem(String title) {
    return GestureDetector(
      onTap: () => _selectItem(title),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(8),
        color: _selectedItem == title ? Colors.blue[200] : Colors.transparent,
        child: Text(title),
      ),
    );
  }
}

class AnimatedDropdownAnkara extends StatefulWidget {
  @override
  _AnimatedDropdownAnkaraState createState() => _AnimatedDropdownAnkaraState();
}

class _AnimatedDropdownAnkaraState extends State<AnimatedDropdownAnkara> with SingleTickerProviderStateMixin {
  bool _isOpen = false;
  late AnimationController _controller;
  late Animation<double> _heightFactor;
  String? _selectedItem;
  List<String> _items = [
    'Altındağ', 'Ayaş', 'Bala', 'Beypazarı', 'Çamlıdere', 'Çankaya',
    'Çubuk', 'Elmadağ', 'Etimesgut', 'Evren', 'Gölbaşı', 'Güdül',
    'Haymana', 'Kalecik', 'Kazan', 'Keçiören', 'Kızılcahamam', 'Mamak',
    'Nallıhan', 'Polatlı', 'Pursaklar', 'Sincan', 'Şereflikoçhisar', 'Yenimahalle'
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );

    _heightFactor = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  void _toggleDropdown() {
    setState(() {
      if (_isOpen) {
        _controller.reverse();
      } else {
        _controller.forward();
      }
      _isOpen = !_isOpen;
    });
  }

  void _selectItem(String item) {
    setState(() {
      _selectedItem = item;
      _isOpen = false;
      _controller.reverse();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: _toggleDropdown,
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _selectedItem ?? 'Ankara İlçeleri',
                  style: TextStyle(color: Colors.white),
                ),
                Icon(
                  _isOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
        SizeTransition(
          sizeFactor: _heightFactor,
          axisAlignment: -1.0,
          child: Container(
            height: 150, // Kaydırılabilir alan yüksekliği
            padding: EdgeInsets.all(8),
            color: Colors.blue[50],
            child: ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                return _buildDropdownItem(_items[index]);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownItem(String title) {
    return GestureDetector(
      onTap: () => _selectItem(title),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(8),
        color: _selectedItem == title ? Colors.blue[200] : Colors.transparent,
        child: Text(title),
      ),
    );
  }
}
