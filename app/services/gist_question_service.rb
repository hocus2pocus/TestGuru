class GistQuestionService

  class GistQuestionServiceResult
    attr_reader :response

    def initialize(response)
      @response = response
    end

    def success?
      !@response.url.nil?
    end

    def gist_id
      @response.id
    end

    def gist_url
      @response.html_url
    end
  end

  def initialize(question, client: default_client)
    @question = question
    @test = @question.test
    @client = client
  end

  def call
    GistQuestionServiceResult.new(@client.create_gist(gist_params))
  end

  private

  def gist_params
    {
      description: I18n.t('services.git_question_service.description', title: @test.title),
      files: {
        'test-guru-question.txt' => {
          content: gist_content
        }
      }
    }
  end

  def gist_content
    [@question.body, *@question.answers.pluck(:body)].join("\n")
  end

  def default_client
    Octokit::Client.new(:access_token => ENV['GITHUB_GIST_ACCESS_TOKEN'])
  end
end
