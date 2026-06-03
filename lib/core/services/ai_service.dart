import 'dart:math';
import 'dart:async';

// ============================================================
//  StudySpark – AI Service
//  All methods are SIMULATED with realistic delays.
//
//  🤗 HUGGING FACE INTEGRATION POINTS are marked with:
//      // [HF_API] ...
//
//  When you're ready to go live:
//    1. Add `http` or `dio` to pubspec.yaml.
//    2. Store your token in flutter_secure_storage, not in code.
//    3. Replace each simulated block with the [HF_API] snippet below it.
// ============================================================

class AiMessage {
  final String id;
  final String text;
  final bool isUser;
  final DateTime timestamp;

  AiMessage({
    required this.id,
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}

class FlashcardData {
  final String front;
  final String back;
  final String hint;

  const FlashcardData({
    required this.front,
    required this.back,
    required this.hint,
  });
}

class QuizQuestion {
  final String question;
  final List<String> options;
  final int correctIndex;
  final String explanation;

  const QuizQuestion({
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.explanation,
  });
}

class AiService {
  AiService._();
  static final AiService instance = AiService._();

  final _rng = Random();

  // ──────────────────────────────────────────────────────────
  //  1.  STUDY ASSISTANT  –  Chat completions
  // ──────────────────────────────────────────────────────────

  /// Returns a smart reply to the user's study question.
  ///
  /// [HF_API] Replace simulation with:
  /// ```dart
  /// final uri = Uri.parse(
  ///   'https://api-inference.huggingface.co/models/mistralai/Mistral-7B-Instruct-v0.3',
  /// );
  /// final response = await http.post(uri,
  ///   headers: {
  ///     'Authorization': 'Bearer $hfToken',
  ///     'Content-Type': 'application/json',
  ///   },
  ///   body: jsonEncode({
  ///     'inputs': '<s>[INST] You are a helpful study assistant. $userMessage [/INST]',
  ///     'parameters': {'max_new_tokens': 300, 'temperature': 0.7},
  ///   }),
  /// );
  /// final json = jsonDecode(response.body) as List;
  /// return json[0]['generated_text'] as String;
  /// ```
  Future<String> chat(String userMessage, List<AiMessage> history) async {
    // Simulate network latency (1.2 – 2.8 s)
    await Future.delayed(Duration(milliseconds: 1200 + _rng.nextInt(1600)));

    final lower = userMessage.toLowerCase();

    if (lower.contains('photosynthesis'))
      return "Photosynthesis is the process by which green plants convert light energy into chemical energy. "
          "The simplified equation is: **6CO₂ + 6H₂O + light → C₆H₁₂O₆ + 6O₂**. "
          "It happens in two stages — the light-dependent reactions (thylakoids) and the Calvin cycle (stroma). "
          "Would you like me to break down either stage in more detail?";

    if (lower.contains('newton') || lower.contains('law'))
      return "Newton's three laws of motion:\n\n"
          "**1st (Inertia):** An object stays at rest or in motion unless acted upon by a force.\n\n"
          "**2nd (F = ma):** Force equals mass times acceleration.\n\n"
          "**3rd (Action-Reaction):** For every action there is an equal and opposite reaction.\n\n"
          "Which law would you like to explore with examples?";

    if (lower.contains('summary') || lower.contains('summarize'))
      return "I can help you summarize! Please paste the text or topic you'd like summarized, "
          "and I'll extract the key concepts and main ideas for you. 📝";

    if (lower.contains('flashcard'))
      return "Great idea! Flashcards are excellent for spaced repetition. "
          "Head over to the **AI Flashcard Generator** tab to auto-generate a whole deck from any topic or note. "
          "I can also quiz you right here if you'd like!";

    if (lower.contains('quiz') || lower.contains('test'))
      return "Practice testing is one of the most effective study strategies! "
          "Use the **AI Quiz Generator** tab to get custom MCQs on any topic. "
          "Or tell me what subject you're studying and I'll pop a quick question here. 🎯";

    if (lower.contains('hello') || lower.contains('hi'))
      return "Hey there! 👋 I'm your AI study companion. I can explain concepts, "
          "help you understand difficult topics, quiz you, or guide you through problems. "
          "What are you studying today?";

    if (lower.contains('pomodoro') || lower.contains('focus'))
      return "The Pomodoro Technique: work for **25 minutes**, then take a **5-minute break**. "
          "After 4 cycles, take a longer **15–30 minute break**. "
          "This leverages ultradian rhythms and prevents cognitive fatigue. "
          "Your StudySpark timer is already set up — give it a try! ⏱️";

    if (lower.contains('memory') || lower.contains('remember'))
      return "Top evidence-based memory strategies:\n\n"
          "• **Spaced repetition** – review material at increasing intervals\n"
          "• **Active recall** – test yourself instead of re-reading\n"
          "• **Elaborative interrogation** – ask *why* and *how* constantly\n"
          "• **Interleaving** – mix topics rather than blocking\n\n"
          "All of these are built into StudySpark's flashcard and quiz systems!";

    // Generic fallback – varied enough to feel intelligent
    final fallbacks = [
      "That's a great question! Let me break it down: the core idea here relates to foundational principles. "
          "Start by identifying the key variables, then examine how they interact. "
          "Would you like me to walk through a specific example?",
      "I'd love to help with that topic! The most important thing to understand first is the underlying concept. "
          "Once you grasp that, the details start making sense naturally. "
          "What aspect are you finding most challenging?",
      "Excellent topic to study! The best way to approach this is systematically — "
          "start with definitions, then look at relationships between concepts, and finally practice with examples. "
          "Shall we go through it step by step?",
    ];
    return fallbacks[_rng.nextInt(fallbacks.length)];
  }

  // ──────────────────────────────────────────────────────────
  //  2.  NOTES SUMMARIZER
  // ──────────────────────────────────────────────────────────

  /// Summarizes raw note text into bullet points + key terms.
  ///
  /// [HF_API] Replace simulation with:
  /// ```dart
  /// final uri = Uri.parse(
  ///   'https://api-inference.huggingface.co/models/facebook/bart-large-cnn',
  /// );
  /// final response = await http.post(uri,
  ///   headers: {'Authorization': 'Bearer $hfToken', 'Content-Type': 'application/json'},
  ///   body: jsonEncode({
  ///     'inputs': noteText,
  ///     'parameters': {'max_length': 200, 'min_length': 60, 'do_sample': false},
  ///   }),
  /// );
  /// final json = jsonDecode(response.body) as List;
  /// return json[0]['summary_text'] as String;
  /// ```
  Future<Map<String, dynamic>> summarizeNote(String noteText) async {
    await Future.delayed(Duration(milliseconds: 1800 + _rng.nextInt(1200)));

    final wordCount = noteText.split(' ').length;
    final compressed = (wordCount * 0.22).round();

    return {
      'summary':
          'This note covers ${_topicFor(noteText)}. The core concept revolves around the interaction '
          'between key variables and their systemic effects. Understanding the foundational principles '
          'allows for application across related domains. The material also touches on historical context '
          'and modern applications.',
      'keyPoints': [
        '${_topicFor(noteText)} is defined by its fundamental properties',
        'The relationship between components follows predictable patterns',
        'Practical applications span multiple real-world contexts',
        'Common misconceptions often arise from oversimplification',
        'Review the associated formulas and their derivations',
      ],
      'keyTerms': _extractKeyTerms(noteText),
      'compressionRatio': '${wordCount}w → ${compressed}w (${(100 - 22).round()}% shorter)',
      'readingTime': '${max(1, (compressed / 200).ceil())} min read',
    };
  }

  // ──────────────────────────────────────────────────────────
  //  3.  FLASHCARD GENERATOR
  // ──────────────────────────────────────────────────────────

  /// Generates a deck of flashcards for the given topic.
  ///
  /// [HF_API] Replace simulation with a text-generation model:
  /// ```dart
  /// // Use: mistralai/Mistral-7B-Instruct-v0.3 or similar
  /// // Prompt engineering: ask model to return JSON array of
  /// // {front, back, hint} objects and parse the response.
  /// final uri = Uri.parse(
  ///   'https://api-inference.huggingface.co/models/mistralai/Mistral-7B-Instruct-v0.3',
  /// );
  /// final prompt = '''[INST] Generate $count flashcards for the topic: "$topic".
  /// Return ONLY a JSON array with objects having keys: front, back, hint.
  /// No extra text. [/INST]''';
  /// ```
  Future<List<FlashcardData>> generateFlashcards(String topic, int count) async {
    await Future.delayed(Duration(milliseconds: 2000 + _rng.nextInt(1500)));
    return _simulatedFlashcards(topic, count);
  }

  // ──────────────────────────────────────────────────────────
  //  4.  QUIZ GENERATOR  –  MCQs
  // ──────────────────────────────────────────────────────────

  /// Generates multiple-choice questions for the given topic.
  ///
  /// [HF_API] Replace simulation with:
  /// ```dart
  /// // Recommended model: valhalla/t5-base-qg-hl (question generation)
  /// // or use a chat model with structured prompting.
  /// // Prompt: "Generate $count MCQs about $topic in JSON:
  /// //   [{question, options:[A,B,C,D], correctIndex, explanation}]"
  /// ```
  Future<List<QuizQuestion>> generateQuiz(String topic, int count) async {
    await Future.delayed(Duration(milliseconds: 2200 + _rng.nextInt(1400)));
    return _simulatedQuestions(topic, count);
  }

  // ──────────────────────────────────────────────────────────
  //  Helpers
  // ──────────────────────────────────────────────────────────

  String _topicFor(String text) {
    final lower = text.toLowerCase();
    if (lower.contains('photo')) return 'Photosynthesis';
    if (lower.contains('newton') || lower.contains('force')) return 'Classical Mechanics';
    if (lower.contains('cell')) return 'Cell Biology';
    if (lower.contains('algebra') || lower.contains('equation')) return 'Algebra';
    if (lower.contains('history') || lower.contains('war')) return 'Historical Events';
    return 'the studied topic';
  }

  List<String> _extractKeyTerms(String text) {
    // [HF_API] Real implementation: use
    //   'dslim/bert-base-NER' for named-entity recognition, or
    //   'ml6team/keyphrase-extraction-kbir-inspec' for keyphrases.
    final words = text.split(RegExp(r'\W+')).where((w) => w.length > 5).toSet().take(6).toList();
    return words.isEmpty
        ? ['Concept', 'Theory', 'Principle', 'Application', 'Formula']
        : words;
  }

  List<FlashcardData> _simulatedFlashcards(String topic, int count) {
    final all = [
      FlashcardData(
        front: 'What is the definition of $topic?',
        back: '$topic is a fundamental concept that describes the systematic relationship between '
            'key variables in its domain. It forms the basis of understanding related phenomena.',
        hint: 'Think about the core properties and their interactions.',
      ),
      FlashcardData(
        front: 'What are the main components of $topic?',
        back: 'The primary components include: (1) foundational elements, (2) governing relationships, '
            '(3) boundary conditions, and (4) practical constraints that shape real-world behavior.',
        hint: 'Break it down systematically.',
      ),
      FlashcardData(
        front: 'How does $topic apply in real-world scenarios?',
        back: 'Real-world applications span engineering, science, and everyday life. '
            'The principles help predict outcomes, optimize systems, and solve complex problems.',
        hint: 'Consider examples from your course material.',
      ),
      FlashcardData(
        front: 'What is the key formula or equation associated with $topic?',
        back: 'The governing equation relates input variables to outputs via a defined mathematical '
            'relationship. Check your textbook for the precise notation used in your course.',
        hint: 'Look for the relationship between dependent and independent variables.',
      ),
      FlashcardData(
        front: 'What are common misconceptions about $topic?',
        back: 'Students often confuse $topic with related concepts. The key distinction is in '
            'the specific conditions under which it applies and the assumptions made.',
        hint: 'What edge cases or exceptions exist?',
      ),
      FlashcardData(
        front: 'Who first described or discovered $topic?',
        back: 'The theoretical foundation was laid by pioneering researchers who observed '
            'consistent patterns. Their work was later refined and formalized into the framework we use today.',
        hint: 'Think about historical development in your subject.',
      ),
      FlashcardData(
        front: 'What are the limitations of $topic?',
        back: 'Limitations include assumptions of idealized conditions, breakdown at extreme values, '
            'and interactions with other phenomena not accounted for in the basic model.',
        hint: 'Under what conditions does the model break down?',
      ),
      FlashcardData(
        front: 'How do you measure or quantify $topic?',
        back: 'Measurement involves selecting appropriate units, instruments, and control conditions. '
            'Accuracy depends on minimizing systematic errors and accounting for environmental factors.',
        hint: 'Consider both direct and indirect measurement methods.',
      ),
    ];
    all.shuffle(_rng);
    return all.take(count).toList();
  }

  List<QuizQuestion> _simulatedQuestions(String topic, int count) {
    final all = [
      QuizQuestion(
        question: 'Which of the following BEST describes $topic?',
        options: [
          'A systematic framework explaining relationships between variables',
          'A random collection of unrelated observations',
          'A purely theoretical construct with no practical use',
          'A historical artifact with no modern relevance',
        ],
        correctIndex: 0,
        explanation:
            '$topic is indeed best described as a systematic framework. The other options mischaracterize '
            'its structured, applicable nature.',
      ),
      QuizQuestion(
        question: 'What is the PRIMARY purpose of studying $topic?',
        options: [
          'To memorize facts for exams',
          'To understand underlying principles for problem-solving',
          'To replicate experiments exactly',
          'To disprove existing theories',
        ],
        correctIndex: 1,
        explanation:
            'Understanding principles — not memorization — is what enables transfer of knowledge to novel problems.',
      ),
      QuizQuestion(
        question: 'Which scenario demonstrates a direct APPLICATION of $topic?',
        options: [
          'Randomly guessing outcomes without measurement',
          'Applying the governing equation to predict system behavior',
          'Ignoring boundary conditions in a model',
          'Using unrelated methods from a different field',
        ],
        correctIndex: 1,
        explanation:
            'Direct application means using the governing principles and equations to make predictions.',
      ),
      QuizQuestion(
        question: 'What is a KEY ASSUMPTION made in the basic model of $topic?',
        options: [
          'All variables are random and uncontrollable',
          'External forces always dominate internal ones',
          'Conditions are idealized and boundary effects are negligible',
          'The system is always in a non-equilibrium state',
        ],
        correctIndex: 2,
        explanation:
            'Basic models typically assume idealized conditions. Real-world analysis requires accounting for deviations.',
      ),
      QuizQuestion(
        question: 'How does $topic relate to energy conservation?',
        options: [
          'Energy is always created in these systems',
          'Energy transformations follow conservation principles',
          'Energy conservation does not apply here',
          'Only kinetic energy is relevant',
        ],
        correctIndex: 1,
        explanation: 'Energy conservation is a universal principle that governs all physical and chemical systems.',
      ),
      QuizQuestion(
        question: 'Which mathematical tool is most commonly used to analyze $topic?',
        options: [
          'Differential equations and calculus',
          'Basic arithmetic only',
          'Topology and abstract algebra',
          'Statistical sampling without models',
        ],
        correctIndex: 0,
        explanation:
            'Most scientific topics involve rates of change, making differential equations the primary analytical tool.',
      ),
    ];
    all.shuffle(_rng);
    return all.take(count).toList();
  }
}
