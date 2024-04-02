import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cook_assistant/ui/theme/color.dart';
import 'package:cook_assistant/ui/theme/text_styles.dart';
import 'package:cook_assistant/widgets/button/primary_button.dart'; // PrimaryButton 사용
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MakeRecipeTextPage extends StatefulWidget {
  const MakeRecipeTextPage({Key? key}) : super(key: key); // const 추가

  @override
  _MakeRecipeTextPageState createState() => _MakeRecipeTextPageState();
}

class _MakeRecipeTextPageState extends State<MakeRecipeTextPage> {
  final TextEditingController _controller = TextEditingController();
  String _response = '';

  Future<void> _fetchRecipeAdvice(String text) async {
    await dotenv.load(fileName: ".env");
    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${dotenv.env['OPENAI_API_KEY']}', // 여기에 실제 API 키를 사용하세요.
      },
      body: jsonEncode({
        'model': 'gpt-3.5-turbo',
        'messages': [
          {'role': 'user', 'content': text},
        ],
      }),
    );

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      setState(() {
        _response = result['choices'][0]['message']['content'].trim();
      });
    } else {
      setState(() {
        _response = '오류가 발생했습니다. 상태 코드: ${response.statusCode}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '텍스트로 레시피 제작하기',
          style: AppTextStyles.headingH4.copyWith(color: AppColors.neutralDarkDarkest),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0), // const 추가
          child: Column(
            children: <Widget>[
              TextField(
                controller: _controller,
                decoration: const InputDecoration( // const 추가
                  labelText: '레시피에 대한 질문을 입력하세요',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20), // const 추가
              PrimaryButton(
                text: '레시피 제안 받기',
                onPressed: () {
                  if (_controller.text.isNotEmpty) {
                    _fetchRecipeAdvice(_controller.text);
                  }
                },
              ),
              const SizedBox(height: 20), // const 추가
              Text(_response, style: const TextStyle(fontSize: 16)), // const 추가
            ],
          ),
        ),
      ),
    );
  }
}
