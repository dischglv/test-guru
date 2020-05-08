# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user_mary = User.create(name: 'Mary', email: 'mary@testguruapplication.ru')
user_james = User.create(name: 'James', email: 'james@testguruapplication.ru')

category_biology = Category.create(title: 'Биология')
category_history = Category.create(title: 'История')

all_tests = [
  {
    title: 'Корень',
    description: 'Легкий тест по корневой системе',
    level: 1,
    category: category_biology,
    questions: [
    { 
      question_text: 'Корневая система представлена...',
      answers: [
      { answer_text: 'боковыми корнями', correct: false },
      { answer_text: 'главным корнем', correct: false },
      { answer_text: 'всеми корнями растений', correct: true }
      ]
    },
    { 
      question_text: 'Многие двудольные растения имеют...',
      answers: [
      { answer_text: 'стержневую корневую систему', correct: true },
      { answer_text: 'мочковатую корневую систему', correct: false },
      { answer_text: 'боковые или придаточные корни', correct: false }
      ]
    },
    { 
      question_text: 'Придаточными называют корни...',
      answers: [
      { answer_text: 'развивающиеся из корешка зародыша', correct: false },
      { answer_text: 'отрастающие от стебля', correct: true },
      { answer_text: 'развивающиеся на главном корне', correct: false }
      ]
    }
    ]
  },
  {
    title: 'Млекопитающие',
    description: 'Очень легкий тест по млекопитающим',
    level: 0,
    category: category_biology,
    questions: [
    { 
      question_text: 'Млекопитающие населяют сушу, моря, пресноводные водоемы и дышат при помощи...',
      answers: [
      { answer_text: 'кожи или легких', correct: false },
      { answer_text: 'легких или жабр', correct: false },
      { answer_text: 'легких', correct: true }
      ]
    },
    { 
      question_text: 'Конечности у млекопитающих в отличие от пресмыкающихся расположены...',
      answers: [
      { answer_text: 'по бокам', correct: false },
      { answer_text: 'под туловищем', correct: true },
      { answer_text: 'у одних - по бокам, у других - под туловищем', correct: false }
      ]
    },
    { 
      question_text: 'Для млекопитающих характерны зубы...',
      answers: [
      { answer_text: 'все конической формы', correct: false },
      { answer_text: 'только коренные и клыки', correct: false },
      { answer_text: 'резцы, клыки и коренные', correct: true }
      ]
    }
    ]
  },
  {
    title: 'В Риме при императоре Нероне',
    description: 'Тест по истории Древнего мира',
    level: 1,
    category: category_history,
    questions: [
    { 
      question_text: 'Граница между Римской империей и владениями германцев пролегала...',
      answers: [
      { answer_text: 'по Эльбе', correct: false },
      { answer_text: 'по Висле', correct: false },
      { answer_text: 'по Рейну', correct: true }
      ]
    },
    { 
      question_text: 'Вольноотпущенники в Риме — это',
      answers: [
      { answer_text: 'разорившиеся землевладельцы', correct: false },
      { answer_text: 'воины, завершившие службу', correct: false },
      { answer_text: 'рабы, получившие свободу и гражданские права', correct: true }
      ]
    },
    { 
      question_text: 'Великим поэтом и актёром считал себя император',
      answers: [
      { answer_text: 'Нерон', correct: true },
      { answer_text: 'Клавдий', correct: false },
      { answer_text: 'Октавиан', correct: false }
      ]
    }
    ]
  }
]

all_tests.each do |t|
  test_object = Test.create(title: t[:title], level: t[:level], description: t[:description],
  category_id: t[:category].id, author_id: user_mary.id)

  t[:questions].each do |q|
    question_object = Question.create(question_text: q[:question_text], test_id: test_object.id)

    q[:answers].each do |a|
      Answer.create(answer_text: a[:answer_text], correct: a[:correct], question_id: question_object.id)
    end
  end
end