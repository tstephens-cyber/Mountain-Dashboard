import 'package:flutter/material.dart';

const String kBackendCoachUrl = 'https://mountain-intelligence-coach-backend.onrender.com/coach';
const String kBackendUrl = 'https://mountain-intelligence-coach-backend.onrender.com/coach';

void main() {
  runApp(const MountainIntelligenceApp());
}

class MountainIntelligenceApp extends StatelessWidget {
  const MountainIntelligenceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mountain Intelligence',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal, brightness: Brightness.dark),
        scaffoldBackgroundColor: const Color(0xFF101820),
        cardTheme: const CardTheme(
          color: Color(0xFF1E2730),
          margin: EdgeInsets.symmetric(vertical: 8),
        ),
      ),
      home: const MainDashboard(),
    );
  }
}

class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  int _selectedIndex = 0;
  String _selectedBranch = 'North';
  String _selectedPeriod = 'MTD';
  final TextEditingController _chatController = TextEditingController();
  final List<String> _chatMessages = [
    'Welcome to AI Coach. Ask a question or request insight here.',
  ];

  static const List<String> _branches = ['North', 'South', 'East', 'West'];
  static const List<String> _periods = ['MTD', 'YTD', 'LTM'];

  void _onNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _sendChat() {
    final text = _chatController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _chatMessages.add(text);
      _chatController.clear();
    });
  }

  Widget _buildKpiCard(String label, String value, {String? suffix}) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(height: 12),
              Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              if (suffix != null) ...[
                const SizedBox(height: 6),
                Text(suffix, style: const TextStyle(color: Colors.white70)),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String value, String description) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 12),
            Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(description, style: const TextStyle(color: Colors.white70)),
          ],
        ),
      ),
    );
  }

  Widget _homeScreen() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Executive KPIs', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Row(children: [
            _buildKpiCard('Revenue', '\$4.8M'),
            const SizedBox(width: 12),
            _buildKpiCard('EBITDA %', '18.4%', suffix: 'On track'),
          ]),
          Row(children: [
            _buildKpiCard('Labor %', '24.1%', suffix: 'Stable'),
            const SizedBox(width: 12),
            _buildKpiCard('COGS %', '38.6%', suffix: 'Review pricing'),
          ]),
          const SizedBox(height: 12),
          _buildInfoCard('Retention', '92%', 'High employee retention rate.'),
        ],
      ),
    );
  }

  Widget _financialsScreen() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Financials', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        const Text('Branch', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: _branches.map((branch) {
            final selected = branch == _selectedBranch;
            return ChoiceChip(
              label: Text(branch),
              selected: selected,
              onSelected: (_) => setState(() => _selectedBranch = branch),
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
        const Text('Period', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: _periods.map((period) {
            final selected = period == _selectedPeriod;
            return ChoiceChip(
              label: Text(period),
              selected: selected,
              onSelected: (_) => setState(() => _selectedPeriod = period),
            );
          }).toList(),
        ),
        const SizedBox(height: 20),
        _buildInfoCard('MTD Revenue', '\$1.1M', 'Branch: $_selectedBranch'),
        _buildInfoCard('YTD Profit', '\$236K', 'Period: $_selectedPeriod'),
        _buildInfoCard('LTM Margin', '22.8%', 'KPI trend is improving'),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
              Text('Excel P&L Import', style: TextStyle(fontWeight: FontWeight.w700)),
              SizedBox(height: 12),
              Text('Placeholder for Excel P&L import tools and upload workflow.'),
            ]),
          ),
        ),
      ]),
    );
  }

  Widget _aiCoachScreen() {
    return Column(children: [
      Expanded(
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: _chatMessages.length,
          itemBuilder: (context, index) {
            final message = _chatMessages[index];
            final isUser = index != 0;
            return Align(
              alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
              child: Card(
                color: isUser ? Colors.teal : const Color(0xFF25303A),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(message, style: const TextStyle(fontSize: 16)),
                ),
              ),
            );
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(children: [
          Card(
            child: ListTile(
              title: const Text('Backend URL'),
              subtitle: const Text(kBackendCoachUrl),
              leading: const Icon(Icons.storage),
            ),
          ),
          const SizedBox(height: 8),
          Row(children: [
            Expanded(
              child: TextField(
                controller: _chatController,
                decoration: const InputDecoration(
                  labelText: 'Ask AI Coach',
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (_) => _sendChat(),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: _sendChat,
              child: const Icon(Icons.send),
            ),
          ]),
        ]),
      ),
    ]);
  }

  Widget _workspaceScreen() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Workspace', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
              Text('SMART Goals', style: TextStyle(fontWeight: FontWeight.w700)),
              SizedBox(height: 12),
              Text('• Increase EBITDA margin to 19% by Q4.'),
              Text('• Reduce COGS by 2% across branches.'),
            ]),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
              Text('Action Items', style: TextStyle(fontWeight: FontWeight.w700)),
              SizedBox(height: 12),
              Text('• Review payroll plan for labor optimization.'),
              Text('• Update branch level forecast reports.'),
            ]),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
              Text('Notes', style: TextStyle(fontWeight: FontWeight.w700)),
              SizedBox(height: 12),
              Text('• Import new P&L data weekly.'),
              Text('• Track retention and employee engagement.'),
            ]),
          ),
        ),
      ]),
    );
  }

  Widget _settingsScreen() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        const Text('Settings', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Card(
          child: ListTile(
            title: const Text('Backend URL'),
            subtitle: const Text(kBackendUrl),
            leading: const Icon(Icons.cloud),
          ),
        ),
        Card(
          child: ListTile(
            title: const Text('App version'),
            subtitle: const Text('v5.0'),
            leading: const Icon(Icons.info),
          ),
        ),
        Card(
          child: ListTile(
            title: const Text('Data import status'),
            subtitle: const Text('Last import complete. No pending files.'),
            leading: const Icon(Icons.upload_file),
          ),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      _homeScreen(),
      _financialsScreen(),
      _aiCoachScreen(),
      _workspaceScreen(),
      _settingsScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mountain Intelligence'),
        centerTitle: true,
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onNavTapped,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.bar_chart), label: 'Financials'),
          NavigationDestination(icon: Icon(Icons.chat_bubble_outline), label: 'AI Coach'),
          NavigationDestination(icon: Icon(Icons.workspaces_outline), label: 'Workspace'),
          NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
