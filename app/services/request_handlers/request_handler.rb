# Request handler class
module RequestHandlers
  class RequestHandler < Service
    include DocParser

    CONFIG_FILE = "#{Rails.root}/config/doc_parser_config.yaml"
    DOC_PATH = "#{Rails.root}/app/data/decrees"
  
    def call
      update_decree_data
    end

    # test function
    def test
      ss = [1, 2, 3].map do |s|
        Failure(:ss).bind do |s|
          
        end.or(return Success(:pp))
      end
      p ss
    end

    def faile
      Failure('Error')
    end

    def succ
      Success(10)
    end

    def my_func
      Maybe(nil).to_result
    end
    # test function

    private

    def update_decree_data
      DecreeParser.new
        .with_step_args(
          init_parser: [config_path: CONFIG_FILE],
          parse_docs: [doc_path: DOC_PATH],
        )
        .call
    end
  end
end