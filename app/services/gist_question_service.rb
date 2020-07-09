class GistQuestionService

  def initialize(question, client: default_client)
    @question = question
    @test = @question.test
    @client = client
  end

  def call
    @client.create_gist(gist_params)
  end

  def success?
    @client.last_response.status == 201
  end

  private

  def gist_params
    {
      description: I18n.t('gists.description', test: @test.title),
      files: {
        'test-guru-question.txt' => {
          content: gist_content
        }
      }
    }
  end

  def gist_content
    content = [@question.question_text]
    content += @question.answers.pluck(:question_text)
    content.join("\n")
  end

  def default_client
    Octokit::Client.new(access_token: 'f457b68b39240aff9509621c03cd2cd50eefb952')
  end

end